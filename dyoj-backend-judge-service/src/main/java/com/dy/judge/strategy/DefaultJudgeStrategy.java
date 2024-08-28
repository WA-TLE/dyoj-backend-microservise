package com.dy.judge.strategy;

import cn.hutool.json.JSONUtil;
import com.dy.dto.question.JudgeCase;
import com.dy.dto.question.JudgeConfig;
import com.dy.dto.questionsubmit.JudgeInfo;
import com.dy.entity.Question;
import com.dy.entity.QuestionSubmit;
import com.dy.enums.JudgeInfoMessageEnum;
import com.dy.judge.JudgeContext;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author: dy
 * @Date: 2024/7/17 23:43
 * @Description:
 */
public class DefaultJudgeStrategy implements JudgeStrategy {
    @Override
    public JudgeInfo doJudge(JudgeContext judgeContext) {
        // 1. 从上下文中获取判题信息
        JudgeInfo judgeInfo = judgeContext.getJudgeInfo();
        long time = judgeInfo.getTime();       // 获取提交代码的运行时间
        long memory = judgeInfo.getMemory();   // 获取提交代码的内存使用情况

        // 2. 获取题目信息
        Question question = judgeContext.getQuestion();

        // 3 .初始化判题结果对象
        JudgeInfo judgeInfoResponse = new JudgeInfo();
        judgeInfoResponse.setTime(time);
        judgeInfoResponse.setMemory(memory);

        // 4. 获取题目配置（时间和内存限制）
        String judgeConfigStr = question.getJudgeConfig();
        JudgeConfig judgeConfig = JSONUtil.toBean(judgeConfigStr, JudgeConfig.class);

        // 5. 判断运行时间是否超出限制
        if (time > judgeConfig.getTimeLimit()) {
            judgeInfoResponse.setMessage(JudgeInfoMessageEnum.TIME_LIMIT_EXCEEDED.getValue());
            return judgeInfoResponse;
        }

        // 6. 判断内存使用是否超出限制
        if (memory > judgeConfig.getMemoryLimit()) {
            judgeInfoResponse.setMessage(JudgeInfoMessageEnum.MEMORY_LIMIT_EXCEEDED.getValue());
            return judgeInfoResponse;
        }

        // 7. 获取判题的输出列表和标准输出列表
        List<String> outputList = judgeContext.getOutputList();
        List<JudgeCase> judgeCaseList = judgeContext.getJudgeCaseList();
        List<String> standardOutputList = judgeCaseList.stream().map(JudgeCase::getOutput).collect(Collectors.toList());

        // 8. 判断输出结果数量是否一致
        if (outputList.size() != standardOutputList.size()) {
            judgeInfoResponse.setMessage(JudgeInfoMessageEnum.WRONG_ANSWER.getValue());
            return judgeInfoResponse;
        }

        // 9. 逐个对比输出结果是否正确
        for (int i = 0; i < standardOutputList.size(); i++) {
            if (!standardOutputList.get(i).equals(outputList.get(i))) {
                judgeInfoResponse.setMessage(JudgeInfoMessageEnum.WRONG_ANSWER.getValue());
                return judgeInfoResponse;
            }
        }

        // 10. 所有测试用例均通过，返回判题结果：Accepted
        judgeInfoResponse.setMessage(JudgeInfoMessageEnum.ACCEPTED.getValue());
        return judgeInfoResponse;
    }



}
