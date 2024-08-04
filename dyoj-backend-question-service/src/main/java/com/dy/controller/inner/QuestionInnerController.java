package com.dy.controller.inner;

import com.dy.entity.Question;
import com.dy.entity.QuestionSubmit;
import com.dy.client.service.QuestionFeignClient;
import com.dy.service.QuestionService;
import com.dy.service.QuestionSubmitService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @Author: dy
 * @Date: 2024/8/4 12:31
 * @Description:
 */
@RestController
@RequestMapping("inner/question")
public class QuestionInnerController implements QuestionFeignClient {

    @Resource
    private QuestionService questionService;
    @Resource
    private QuestionSubmitService questionSubmitService;

    /**
     * 根据 id 获取题目提交记录
     *
     * @param questionSubmitId
     */
    @GetMapping("/questionSubmit/get")
    public QuestionSubmit getQuestionSubmitById(@RequestParam("questionSubmitId") Long questionSubmitId){
        return questionSubmitService.getById(questionSubmitId);
    }


    /**
     * 根据 id 更新题目提交信息
     *
     * @param questionSubmitUpdate
     */
    @GetMapping("/questionSubmit/update")
   public Boolean updateQuestionSubmitById(@RequestParam("questionSubmitUpdate") QuestionSubmit questionSubmitUpdate){
        return questionSubmitService.updateById(questionSubmitUpdate);
    }

    /**
     * 根据 id 获取题目信息
     *
     * @param questionId
     */
    @GetMapping("/get")
    public Question getQuestionById(@RequestParam("questionId") Long questionId){
        return questionService.getById(questionId);
    }

}
