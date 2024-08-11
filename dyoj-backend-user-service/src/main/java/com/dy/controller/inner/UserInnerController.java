package com.dy.controller.inner;

import com.dy.entity.User;
import com.dy.client.service.UserFeignClient;
import com.dy.service.UserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Collection;
import java.util.List;

/**
 * @Author: dy
 * @Date: 2024/8/4 12:20
 * @Description:
 */
@RestController
@RequestMapping("/inner")
public class UserInnerController implements UserFeignClient {

    @Resource
    private UserService userService;

    @Override
    @GetMapping("get")
    public User getById(@RequestParam("userId") Long userId) {
        return userService.getById(userId);
    }

    @Override
    @GetMapping("/get/list")
    public List<User> listByIds(@RequestParam("ids") Collection<Long> ids) {
        return userService.listByIds(ids);
    }
}
