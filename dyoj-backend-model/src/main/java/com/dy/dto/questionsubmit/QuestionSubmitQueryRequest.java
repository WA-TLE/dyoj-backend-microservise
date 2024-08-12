package com.dy.dto.questionsubmit;

import com.dy.common.PageRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * @Author: dy
 * @Date: 2024/7/15 19:30
 * @Description:
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class QuestionSubmitQueryRequest extends PageRequest  implements Serializable {
    /**
     * 题目 id
     */
    private Long questionId;

    /**
     * 编程语言
     */
    private String submitLanguage;

    /**
     * 提交状态
     */
    private Integer submitState;


    /**
     * 用户 id
     */
    private Long userId;

    private static final long serialVersionUID = 1L;

}
