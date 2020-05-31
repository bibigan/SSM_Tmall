package com.how2java.tmall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.how2java.tmall.pojo.Order;
import com.how2java.tmall.service.OrderItemService;
import com.how2java.tmall.service.OrderService;
import com.how2java.tmall.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import sun.awt.ModalExclude;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("")
public class OrderController {
    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;

    @RequestMapping("admin_order_list")
    public ModelAndView listOrder(Page page){
        ModelAndView mav=new ModelAndView();

        PageHelper.offsetPage(page.getStart(),page.getCount());

        List<Order> os=orderService.list();//只设置了user
        orderItemService.fill(os);//设置了oi\total\totalNumber

        int total=(int) new PageInfo<>(os).getTotal();
        page.setTotal(total);

        mav.addObject("os",os);
        mav.addObject("page", page);
        mav.setViewName("admin/listOrder");
        return mav;
    }
    //点击卖家发货
    @RequestMapping("admin_order_delivery")
    public ModelAndView deliveryOrder(int id){
        //admin_order_delivery?id=${o.id}
        ModelAndView mav=new ModelAndView("redirect:/admin_order_list");
        Order order=orderService.get(id);

        order.setDeliveryDate(new Date());
        order.setStatus(OrderService.waitConfirm);

        orderService.update(order);
        return mav;
    }
}
