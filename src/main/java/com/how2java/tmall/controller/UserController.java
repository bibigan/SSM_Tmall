package com.how2java.tmall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.how2java.tmall.pojo.User;
import com.how2java.tmall.service.UserService;
import com.how2java.tmall.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("")
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping("admin_user_list")
    public ModelAndView listUser(Page page){
        ModelAndView mav=new ModelAndView();

        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<User> us=userService.list();
        int total=(int) new PageInfo<>(us).getTotal();
        page.setTotal(total);

        mav.addObject("us",us);
        mav.setViewName("admin/listUser");
        return mav;
    }
}
