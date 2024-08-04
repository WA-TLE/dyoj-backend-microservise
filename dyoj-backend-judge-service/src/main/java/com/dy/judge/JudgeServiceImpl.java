package com.dy.judge;


import cn.hutool.json.JSONUtil;
import com.dy.codesanbox.ExecuteCodeRequest;
import com.dy.codesanbox.ExecuteCodeResponse;
import com.dy.common.ErrorCode;
import com.dy.dto.question.JudgeCase;
import com.dy.dto.question.JudgeConfig;
import com.dy.dto.questionsubmit.JudgeInfo;
import com.dy.entity.Question;
import com.dy.entity.QuestionSubmit;
import com.dy.enums.QuestionSubmitStatusEnum;
import com.dy.exception.BusinessException;
import com.dy.judge.codesanbox.CodeSanBox;
import com.dy.judge.codesanbox.CodeSanBoxFactory;
import com.dy.judge.codesanbox.proxy.CodeSanBoxProxy;
import com.dy.client.service.QuestionFeignClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @Author: dy
 * @Date: 2024/7/17 21:39
 * @Description:
 */
@Service
public class JudgeServiceImpl implements JudgeService {

//    @Resource
//    private QuestionSubmitService questionSubmitService;

    @Resource
    private QuestionFeignClient questionFeignClient;

    @Resource
    private CodeSanBoxFactory codeSanBoxFactory;

    @Value("${codeSanBox.type}")
    private String type;

    @Resource
    private JudgeManager judgeManager;

    @Override
    public QuestionSubmit doJudge(Long questionSubmitId) {
        if (questionSubmitId == null || questionSubmitId < 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        //  获取用户提交信息
        QuestionSubmit questionSubmit = questionFeignClient.getQuestionSubmitById(questionSubmitId);
        String language = questionSubmit.getLanguage();
        String code = questionSubmit.getCode();
        Long questionId = questionSubmit.getQuestionId();
        Integer questionSubmitStatus = questionSubmit.getStatus();

        if (!Objects.equals(QuestionSubmitStatusEnum.WAITING.getValue(), questionSubmitStatus)) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "程序已经执行判题");
        }

        // TODO: 2024/7/17 并发情况下限制用户重复判题

        //  更新题目信息
        QuestionSubmit questionSubmitUpdate = new QuestionSubmit();
        questionSubmitUpdate.setStatus(QuestionSubmitStatusEnum.RUNNING.getValue());
        questionSubmitUpdate.setId(questionSubmitId);
        boolean update = questionFeignClient.updateQuestionSubmitById(questionSubmitUpdate);
        if (!update) {
            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "更新题目信息失败");
        }

        //  获取题目信息
        Question question = questionFeignClient.getQuestionById(questionId);

        //  获取题目测试用例
        String judgeCase = question.getJudgeCase();
        List<JudgeCase> judgeCaseList = JSONUtil.toList(judgeCase, JudgeCase.class);
        List<String> standardInputList = judgeCaseList.stream().map(JudgeCase::getInput).collect(Collectors.toList());
        List<String> standardOutputList = judgeCaseList.stream().map(JudgeCase::getOutput).collect(Collectors.toList());

        //  获取题目限制信息(超时限制, 内存限制)
        String judgeConfigStr = question.getJudgeConfig();
        JudgeConfig judgeConfig = JSONUtil.toBean(judgeConfigStr, JudgeConfig.class);

        //  调用沙箱, 获取代码执行信息
        CodeSanBox codeSanBox = codeSanBoxFactory.createCodeSanBox(type);
        CodeSanBoxProxy codeSanBoxProxy = new CodeSanBoxProxy(codeSanBox);
        ExecuteCodeRequest executeCodeRequest = new ExecuteCodeRequest();
        executeCodeRequest.setLanguage(language);
        executeCodeRequest.setCode(code);
        executeCodeRequest.setInputList(standardInputList);
        ExecuteCodeResponse executeCodeResponse = codeSanBoxProxy.executeCode(executeCodeRequest);

        //  执行判题策略
        JudgeContext judgeContext = new JudgeContext();
        judgeContext.setJudgeInfo(executeCodeResponse.getJudgeInfo());
        judgeContext.setOutputList(executeCodeResponse.getOutputList());
        judgeContext.setJudgeCaseList(judgeCaseList);
        judgeContext.setQuestion(question);
        judgeContext.setQuestionSubmit(questionSubmit);

        JudgeInfo judgeInfo = judgeManager.doJudge(judgeContext);

        questionSubmitUpdate = new QuestionSubmit();
        questionSubmitUpdate.setId(questionSubmitId);
        questionSubmitUpdate.setJudgeInfo(JSONUtil.toJsonStr(judgeInfo));
        questionSubmitUpdate.setStatus(QuestionSubmitStatusEnum.SUCCEED.getValue());

        update = questionFeignClient.updateQuestionSubmitById(questionSubmitUpdate);
        if (!update) {
            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "题目状态更新错误");
        }

        return questionFeignClient.getQuestionSubmitById(questionId);
    }
}
