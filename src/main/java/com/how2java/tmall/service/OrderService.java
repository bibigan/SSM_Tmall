package com.how2java.tmall.service;

import com.how2java.tmall.pojo.Order;
import com.how2java.tmall.pojo.OrderItem;

import java.util.List;

public interface OrderService {
    String waitPay = "waitPay";
    String waitDelivery = "waitDelivery";
    String waitConfirm = "waitConfirm";
    String waitReview = "waitReview";
    String finish = "finish";
    String delete = "delete";

    void delete(int id);
    void update(Order c);
    Order get(int id);
    List<Order> list();
    List<Order> listByUsr(int uid, String excludedStatus);//查看用户的订单页面
    float add(Order o,List<OrderItem> ois);//提交订单，同时新增订单和修改订单项
}
