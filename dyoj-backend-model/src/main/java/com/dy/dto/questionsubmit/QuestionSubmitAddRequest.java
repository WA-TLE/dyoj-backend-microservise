package com.dy.dto.questionsubmit;

import lombok.Data;

/**
 * @Author: dy
 * @Date: 2024/7/14 14:22
 * @Description:
 */
@Data
public class QuestionSubmitAddRequest {
    /**
     * 编程语言
     */
    private String language;

    /**
     * 用户代码
     */
    private String code;


    /**
     * 题目 id
     */
    private Long questionId;

    /**
     * 创建用户 id
     */
    private Long userId;


}
