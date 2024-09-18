package com.dy.judge.controller;

import com.dy.entity.QuestionSubmit;
import com.dy.judge.service.JudgeService;
import com.dy.client.service.JudgeFeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @Author: dy
 * @Date: 2024/8/4 12:29
 * @Description:
 */
//@RestController
//@RequestMapping("/inner")
public class JudgeInnerController implements JudgeFeignClient {

    @Resource
    private JudgeService judgeService;

    @Override
    @PostMapping("/do")
    public void doJudge(@RequestParam("questionSubmitId") Long questionSubmitId) {
        judgeService.doJudge(questionSubmitId);
    }
}
