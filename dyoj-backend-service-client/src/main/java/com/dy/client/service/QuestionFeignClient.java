package com.dy.client.service;


import com.dy.entity.Question;
import com.dy.entity.QuestionSubmit;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
* @author 微光
* @description 针对表【question(题目)】的数据库操作Service
* @createDate 2024-07-14 10:24:31
*/
@FeignClient(contextId = "question",value = "dyoj-backend-question-service", path = "/api/inner/question")
public interface QuestionFeignClient {

    /**
     * 根据 id 获取题目提交记录
     *
     * @param questionSubmitId
     */
    @GetMapping("/questionSubmit/get")
    QuestionSubmit getQuestionSubmitById(@RequestParam("questionSubmitId") Long questionSubmitId);


    /**
     * 根据 id 更新题目提交信息
     *
     * @param questionSubmitUpdate
     */
    @GetMapping("/questionSubmit/update")
    Boolean updateQuestionSubmitById(@RequestParam("questionSubmitUpdate") QuestionSubmit questionSubmitUpdate);


    /**
     * 根据 id 获取题目信息
     *
     * @param questionSubmitId
     */
    @GetMapping("/get")
    Question getQuestionById(@RequestParam("questionSubmitId") Long questionSubmitId);


}
