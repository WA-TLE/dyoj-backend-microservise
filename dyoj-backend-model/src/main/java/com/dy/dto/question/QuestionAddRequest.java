package com.dy.dto.question;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * 创建请求
 */
@Data
public class QuestionAddRequest implements Serializable {

    /**
     * 标题
     */
    private String title;

    /**
     * 内容
     */
    private String content;

    /**
     * 标签列表（json 数组）
     * 标签使用 List 来接收, 前端传进来会更方便
     */
    private List<String> tags;

    /**
     * 题目参考代码
     */
    private String answer;


    /**
     * 判题用例(json 数组)
     */
    private List<JudgeCase> judgeCase;

    /**
     * 判题配置(json 对象)
     */
    private JudgeConfig judgeConfig;


    /**
     * 创建用户 id
     */
    private Long userId;


    private static final long serialVersionUID = 1L;
}