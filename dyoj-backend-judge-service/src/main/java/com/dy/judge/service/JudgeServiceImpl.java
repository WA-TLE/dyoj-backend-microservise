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

import javax.annotation.PreDestroy;
import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;
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

//    // 创建固定大小的线程池
//    private final ExecutorService executorService = Executors.newFixedThreadPool(10); // 线程池大小可以根据需求调整

    @Resource
    private ThreadPoolExecutor executorService;

    @Override
    public void doJudge(Long questionSubmitId) {
        // 1. 校验题目提交信息
        if (questionSubmitId == null || questionSubmitId < 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }

        // 2. 获取用户提交题目信息
        QuestionSubmit questionSubmit = questionFeignClient.getQuestionSubmitById(questionSubmitId);
        String language = questionSubmit.getSubmitLanguage();
        String code = questionSubmit.getSubmitCode();
        Long questionId = questionSubmit.getQuestionId();
        Integer questionSubmitStatus = questionSubmit.getSubmitState();

        // 3. 防止用户重复判题
        if (!Objects.equals(QuestionSubmitStatusEnum.WAITING.getValue(), questionSubmitStatus)) {
            throw new BusinessException(ErrorCode.FORBIDDEN_ERROR, "程序已经执行判题");
        }

        // 4. 更新题目判题状态 - 改为判题中
        QuestionSubmit questionSubmitUpdate = new QuestionSubmit();
        questionSubmitUpdate.setSubmitState(QuestionSubmitStatusEnum.RUNNING.getValue());
        questionSubmitUpdate.setId(questionSubmit.getId());
        questionSubmitUpdate.setId(questionSubmitId);
        boolean update = questionFeignClient.updateQuestionSubmitById(questionSubmitUpdate);
        if (!update) {
            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "更新题目信息失败");
        }

        // 5. 获取对应题目的测试用例和限制信息
        Question question = questionFeignClient.getQuestionById(questionId);
        String judgeCase = question.getJudgeCase();
        List<JudgeCase> judgeCaseList = JSONUtil.toList(judgeCase, JudgeCase.class);
        List<String> standardInputList = judgeCaseList.stream().map(JudgeCase::getInput).collect(Collectors.toList());
        List<String> standardOutputList = judgeCaseList.stream().map(JudgeCase::getOutput).collect(Collectors.toList());
        String judgeConfigStr = question.getJudgeConfig();
        JudgeConfig judgeConfig = JSONUtil.toBean(judgeConfigStr, JudgeConfig.class);

        // 6. 创建代码沙箱和代理
        CodeSanBox codeSanBox = codeSanBoxFactory.createCodeSanBox(type);
        CodeSanBoxProxy codeSanBoxProxy = new CodeSanBoxProxy(codeSanBox);

        // 7. 构造代码沙箱输入参数
        ExecuteCodeRequest executeCodeRequest = new ExecuteCodeRequest();
        executeCodeRequest.setLanguage(language);
        executeCodeRequest.setCode(code);
        executeCodeRequest.setInputList(standardInputList);

        // 8. 异步执行代码沙箱，使用线程池进行并发管理
        CompletableFuture<ExecuteCodeResponse> future = CompletableFuture.supplyAsync(() -> {
            return codeSanBoxProxy.executeCode(executeCodeRequest);
        }, executorService);

        // 9. 异步处理代码沙箱的执行结果
        future.thenAccept(executeCodeResponse -> {
            // 构造判题策略参数
            JudgeContext judgeContext = new JudgeContext();
            judgeContext.setJudgeInfo(executeCodeResponse.getJudgeInfo());
            judgeContext.setOutputList(executeCodeResponse.getOutputList());
            judgeContext.setJudgeCaseList(judgeCaseList);
            judgeContext.setQuestion(question);
            judgeContext.setQuestionSubmit(questionSubmit);

            // 10. 策略模式进行判题
            JudgeInfo judgeInfo = judgeManager.doJudge(judgeContext);

            // 更新题目状态和判题结果
            QuestionSubmit questionSubmitUpdateInner = new QuestionSubmit();
            questionSubmitUpdateInner.setId(questionSubmitId);
            questionSubmitUpdateInner.setJudgeInfo(JSONUtil.toJsonStr(judgeInfo));
            questionSubmitUpdateInner.setSubmitState(QuestionSubmitStatusEnum.SUCCEED.getValue());

            boolean updateInner = questionFeignClient.updateQuestionSubmitById(questionSubmitUpdateInner);
            if (!updateInner) {
                throw new BusinessException(ErrorCode.SYSTEM_ERROR, "题目状态更新错误");
            }
        }).exceptionally(ex -> {
            // 异常处理
            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "代码沙箱执行失败");
        });
    }

    @PreDestroy
    public void shutdown() {
        // 关闭线程池，避免资源泄露
        executorService.shutdown();
    }
}
