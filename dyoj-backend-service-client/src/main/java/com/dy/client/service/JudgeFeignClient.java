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
@FeignClient(contextId = "judge",value = "dyoj-backend-judge-service", path = "/api/inner/judge")
public interface JudgeFeignClient {
    @PostMapping("/do")
    QuestionSubmit doJudge(@RequestParam("questionSubmitId") Long questionSubmitId);
}
