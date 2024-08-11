package com.dy.client.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import com.dy.common.ErrorCode;
import com.dy.dto.user.UserQueryRequest;
import com.dy.entity.User;
import com.dy.enums.UserRoleEnum;
import com.dy.exception.BusinessException;
import com.dy.vo.LoginUserVO;
import com.dy.vo.UserVO;
import org.springframework.beans.BeanUtils;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.Collection;
import java.util.List;

import static com.dy.constant.UserConstant.USER_LOGIN_STATE;

/**
 * 用户服务
 *
 */
@FeignClient(name = "dyoj-backend-user-service", path = "/api/user/inner")
public interface UserFeignClient  {

    //  ● userService.getById(userId)
    //  ● userService.listByIds(userIdSet)

    //  ● userService.getUserVO(user)
    //  ● userService.getLoginUser(request)
    //  ● userService.isAdmin(loginUser)


    @GetMapping("/get")
    User getById(@RequestParam("userId") Long userId);


    @GetMapping("/get/list")
    List<User> listByIds(@RequestParam("ids") Collection<Long> ids);

    /**
     * 获取当前登录用户
     *
     * @param request
     * @return
     */
    default User getLoginUser(HttpServletRequest request) {

        // 先判断是否已登录
        Object userObj = request.getSession().getAttribute(USER_LOGIN_STATE);
        User currentUser = (User) userObj;
        if (currentUser == null || currentUser.getId() == null) {
            throw new BusinessException(ErrorCode.NOT_LOGIN_ERROR);
        }
        return currentUser;
    }




    /**
     * 是否为管理员
     *
     * @param user
     * @return
     */
   default boolean isAdmin(User user) {
       return user != null && UserRoleEnum.ADMIN.getValue().equals(user.getUserRole());
   }


    /**
     * 获取脱敏的已登录用户信息
     *
     * @return
     */
   default LoginUserVO getLoginUserVO(User user) {
       if (user == null) {
           return null;
       }
       LoginUserVO loginUserVO = new LoginUserVO();
       BeanUtils.copyProperties(user, loginUserVO);
       return loginUserVO;
    }


    /**
     * 获取脱敏的用户信息
     *
     * @param user
     * @return
     */
    default UserVO getUserVO(User user) {
        if (user == null) {
            return null;
        }
        UserVO userVO = new UserVO();
        BeanUtils.copyProperties(user, userVO);
        return userVO;
    }



}
