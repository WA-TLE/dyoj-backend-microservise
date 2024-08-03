package com.dy.dto.questionsubmit;

import com.dy.common.PageRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @Author: dy
 * @Date: 2024/7/15 19:30
 * @Description:
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class QuestionSubmitQueryRequest extends PageRequest {
    /**
     * id
     */
    private Long id;

    /**
     * 编程语言
     */
    private String language;

    /**
     * 判题状态（0 - 待判题、1 - 判题中、2 - 成功、3 - 失败）
     */
    private Integer status;


    /**
     * 题目 id
     */
    private Long questionId;

    /**
     * 创建用户 id
     */
    private Long userId;

}
