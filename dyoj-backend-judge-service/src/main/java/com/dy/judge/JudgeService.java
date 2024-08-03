package com.dy.judge;


import com.dy.entity.QuestionSubmit;

/**
 * @Author: dy
 * @Date: 2024/7/17 21:38
 * @Description:
 */
public interface JudgeService {
    QuestionSubmit doJudge(Long questionSubmitId);
}
