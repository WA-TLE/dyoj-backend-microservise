package com.dy.judge.codesanbox;

import com.dy.judge.codesanbox.impl.ExampleCodeSanBox;
import com.dy.judge.codesanbox.impl.RemoteCodeSanBox;
import com.dy.judge.codesanbox.impl.ThirdPartyCodeSanBox;
import org.springframework.stereotype.Component;


/**
 * @Author: dy
 * @Date: 2024/7/16 17:33
 * @Description: 代码沙箱生产工厂
 */
@Component
public class CodeSanBoxFactory {
   public CodeSanBox createCodeSanBox(String type) {
        switch (type) {
            case "example":
                return new ExampleCodeSanBox();
            case "remote":
                return new RemoteCodeSanBox();
            case "thridParty":
                return new ThirdPartyCodeSanBox();
            default:
                return new ExampleCodeSanBox();
        }
    }
}
