package com.dy.judge.listener;

import com.dy.judge.JudgeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.Exchange;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.QueueBinding;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

import static com.dy.constant.MqConstant.*;

/**
 * @Author: dy
 * @Date: 2024/8/21 11:29
 * @Description:
 */
@Component
@Slf4j
public class JudgeListener {

    @Resource
    private JudgeService judgeService;

    @RabbitListener(bindings = @QueueBinding(
            value = @Queue(value = CODE_QUESTION_QUEUE, durable = "true"),
            exchange = @Exchange(CODE_QUESTION_EXCHANGE),
            key = CODE_QUESTION_ROUTING_KEY
    ))
    public void listenerJudge(Long questionSubmitId) {
        judgeService.doJudge(questionSubmitId);
    }

}
