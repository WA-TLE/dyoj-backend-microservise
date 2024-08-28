package com.dy.judge.strategy;


import com.dy.dto.questionsubmit.JudgeInfo;
import com.dy.judge.JudgeContext;

/**
 * @Author: dy
 * @Date: 2024/7/17 23:42
 * @Description:
 */
public interface JudgeStrategy {
    JudgeInfo doJudge(JudgeContext judgeContext);
}