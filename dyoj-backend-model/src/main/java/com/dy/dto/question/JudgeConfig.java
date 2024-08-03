package com.dy.dto.question;

import lombok.Data;

/**
 * @Author: dy
 * @Date: 2024/7/14 10:56
 * @Description:
 */
@Data
public class JudgeConfig {


    /**
     * 时间限制
     */
    Long timeLimit;
    /**
     * 内存限制
     */
    Long memoryLimit;
    /**
     * 堆栈限制
     */
    Long stackLimit;
}
