package com.dy.client.service;


import com.dy.entity.QuestionSubmit;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @Author: dy
 * @Date: 2024/7/17 21:38
 * @Description:
 */
@FeignClient(name = "dyoj-backend-judge-service", path = "/api/judge/inner")
public interface JudgeFeignClient {
    // TODO: 2024/8/25 添加 Fallback 逻辑
    @PostMapping("/do")
    QuestionSubmit doJudge(@RequestParam("questionSubmitId") Long questionSubmitId);
}
