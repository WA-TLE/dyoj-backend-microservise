package com.dy.judge.codesanbox;


import com.dy.codesanbox.ExecuteCodeRequest;
import com.dy.codesanbox.ExecuteCodeResponse;

/**
 * @Author: dy
 * @Date: 2024/7/16 17:08
 * @Description:
 */
public interface CodeSanBox {
    ExecuteCodeResponse executeCode(ExecuteCodeRequest executeCodeRequest);
}
