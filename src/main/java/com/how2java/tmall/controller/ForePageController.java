package com.how2java.tmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
@Controller
@RequestMapping("")
public class ForePageController {
//服务端跳转到jsp页面

    @RequestMapping("registerPage")//服务端跳转到register.jsp注册页面
    public String jumpToRegisterPage(){
        return  "fore/register";
    }

    @RequestMapping("registerSuccessPage")//服务端跳转到registerSuccess.jsp注册页面
    public String jumpToRegisterSuccessPage(){
        return "fore/registerSuccess";
    }

    @RequestMapping("loginPage")//服务端跳转到login.jsp注册页面
    public String jumpToLoginPage(){
        return "fore/login";
    }

    @RequestMapping("forealipay")////服务端跳转到alipay.jsp支付页面
    public String alipayPage(){
        return "fore/alipay";
    }
}
