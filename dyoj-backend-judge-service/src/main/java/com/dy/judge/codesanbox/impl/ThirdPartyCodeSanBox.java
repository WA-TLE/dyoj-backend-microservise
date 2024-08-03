package com.dy.judge.codesanbox.impl;


import com.dy.codesanbox.ExecuteCodeRequest;
import com.dy.codesanbox.ExecuteCodeResponse;
import com.dy.judge.codesanbox.CodeSanBox;

/**
 * @Author: dy
 * @Date: 2024/7/16 17:20
 * @Description: 第三方代码沙箱(用于接入第三方的代码沙箱)
 */
public class ThirdPartyCodeSanBox implements CodeSanBox {
    @Override
    public ExecuteCodeResponse executeCode(ExecuteCodeRequest executeCodeRequest) {
        System.out.println("Third Party 沙箱执行:");
        return null;
    }
}
