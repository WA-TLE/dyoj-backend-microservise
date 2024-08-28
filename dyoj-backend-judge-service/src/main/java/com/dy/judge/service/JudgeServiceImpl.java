package com.dy.judge.service;


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
import com.dy.judge.JudgeContext;
import com.dy.judge.JudgeManager;
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

    @Value("${codeSandBox.type}")
    private String type;

    @Resource
    private JudgeManager judgeManager;

    @Override
    public QuestionSubmit doJudge(Long questionSubmitId) {
        // 1. 校验题目提交信息
        if (questionSubmitId == null || questionSubmitId < 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        // 2. 获取用户提交题目信息信息
        QuestionSubmit questionSubmit = questionFeignClient.getQuestionSubmitById(questionSubmitId);
        String language = questionSubmit.getSubmitLanguage();
        String code = questionSubmit.getSubmitCode();
        Long questionId = questionSubmit.getQuestionId();
        Integer questionSubmitStatus = questionSubmit.getSubmitState();

        // 3. 防止用户重复判题
        if (!Objects.equals(QuestionSubmitStatusEnum.WAITING.getValue(), questionSubmitStatus)) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "程序已经执行判题");
        }

        // TODO: 2024/7/17 并发情况下限制用户重复判题

        // 4. 更新题目判题状态 - 改为判题中
        QuestionSubmit questionSubmitUpdate = new QuestionSubmit();
        questionSubmitUpdate.setSubmitState(QuestionSubmitStatusEnum.RUNNING.getValue());
        questionSubmitUpdate.setId(questionSubmit.getId());
        questionSubmitUpdate.setId(questionSubmitId);
        boolean update = questionFeignClient.updateQuestionSubmitById(questionSubmitUpdate);
        if (!update) {
            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "更新题目信息失败");
        }



        // 5. 获取对应题目的测试用例, 题目限制信息
        Question question = questionFeignClient.getQuestionById(questionId);
        String judgeCase = question.getJudgeCase();
        List<JudgeCase> judgeCaseList = JSONUtil.toList(judgeCase, JudgeCase.class);
        List<String> standardInputList = judgeCaseList.stream().map(JudgeCase::getInput).collect(Collectors.toList());
        List<String> standardOutputList = judgeCaseList.stream().map(JudgeCase::getOutput).collect(Collectors.toList());
        String judgeConfigStr = question.getJudgeConfig();
        JudgeConfig judgeConfig = JSONUtil.toBean(judgeConfigStr, JudgeConfig.class);

        // 6. 调用沙箱, 获取代码执行信息
        CodeSanBox codeSanBox = codeSanBoxFactory.createCodeSanBox(type);

        // 7. 代理模式对沙箱进行增强
        CodeSanBoxProxy codeSanBoxProxy = new CodeSanBoxProxy(codeSanBox);

        // 8. 构造代码沙箱输入参数
        ExecuteCodeRequest executeCodeRequest = new ExecuteCodeRequest();
        executeCodeRequest.setLanguage(language);
        executeCodeRequest.setCode(code);
        executeCodeRequest.setInputList(standardInputList);

        // 9. 执行代码沙箱, 获取沙箱执行结果
        ExecuteCodeResponse executeCodeResponse = codeSanBoxProxy.executeCode(executeCodeRequest);

        // 10. 构造判题策略参数
        JudgeContext judgeContext = new JudgeContext();
        judgeContext.setJudgeInfo(executeCodeResponse.getJudgeInfo());
        judgeContext.setOutputList(executeCodeResponse.getOutputList());
        judgeContext.setJudgeCaseList(judgeCaseList);
        judgeContext.setQuestion(question);
        judgeContext.setQuestionSubmit(questionSubmit);

        // 11. 策略模式进行判题
        JudgeInfo judgeInfo = judgeManager.doJudge(judgeContext);

        questionSubmitUpdate = new QuestionSubmit();
        questionSubmitUpdate.setId(questionSubmitId);
        questionSubmitUpdate.setJudgeInfo(JSONUtil.toJsonStr(judgeInfo));
        questionSubmitUpdate.setSubmitState(QuestionSubmitStatusEnum.SUCCEED.getValue());

        update = questionFeignClient.updateQuestionSubmitById(questionSubmitUpdate);
        if (!update) {
            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "题目状态更新错误");
        }

        return questionFeignClient.getQuestionSubmitById(questionId);
    }
}
