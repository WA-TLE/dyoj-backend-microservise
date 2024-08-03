package com.dy.judge.codesanbox.proxy;


import com.dy.codesanbox.ExecuteCodeRequest;
import com.dy.codesanbox.ExecuteCodeResponse;
import com.dy.dto.questionsubmit.JudgeInfo;
import com.dy.judge.codesanbox.CodeSanBox;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

/**
 * @Author: dy
 * @Date: 2024/7/16 17:55
 * @Description:
 */
@Slf4j
public class CodeSanBoxProxy implements CodeSanBox {

    private final CodeSanBox codeSanBox;

    public CodeSanBoxProxy(CodeSanBox codeSanBox) {
        this.codeSanBox = codeSanBox;
    }

    @Override
    public ExecuteCodeResponse executeCode(ExecuteCodeRequest executeCodeRequest) {
        String language = executeCodeRequest.getLanguage();
        String code = executeCodeRequest.getCode();
        List<String> inputList = executeCodeRequest.getInputList();

        log.info("代码执行语言: {}", language);
        log.info("用户提交代码: {}", code);
        log.info("测试用例: {}", code);
        ExecuteCodeResponse executeCodeResponse = codeSanBox.executeCode(executeCodeRequest);
        String message = executeCodeResponse.getMessage();
        List<String> outputList = executeCodeResponse.getOutputList();
        JudgeInfo judgeInfo = executeCodeResponse.getJudgeInfo();
        String status = executeCodeResponse.getStatus();

        log.info("代码执行语言: {}", language);
        log.info("用户代码执行信息: {}", message);
        log.info("代码输出用例: {}", outputList);
        log.info("判题信息: {}", judgeInfo);
        log.info("题目执行状态: {}", status);
        return executeCodeResponse;
    }
}
