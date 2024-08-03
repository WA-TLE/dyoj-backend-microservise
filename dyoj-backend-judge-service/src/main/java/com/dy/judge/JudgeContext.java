package com.dy.judge;



import com.dy.dto.question.JudgeCase;
import com.dy.dto.questionsubmit.JudgeInfo;
import com.dy.entity.Question;
import com.dy.entity.QuestionSubmit;
import lombok.Data;

import java.util.List;

/**
 * @Author: dy
 * @Date: 2024/7/17 23:43
 * @Description:
 */
@Data
public class JudgeContext {
    private JudgeInfo judgeInfo;

    private List<String> inputList;

    private List<String> outputList;

    private List<JudgeCase> judgeCaseList;

    private Question question;

    private QuestionSubmit questionSubmit;
}
