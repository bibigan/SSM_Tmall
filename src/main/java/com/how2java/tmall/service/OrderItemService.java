package com.how2java.tmall.service;

import com.how2java.tmall.pojo.Order;
import com.how2java.tmall.pojo.OrderItem;
import com.how2java.tmall.pojo.Product;

import java.util.List;

public interface OrderItemService {
    void delete(int id);
    void update(OrderItem c);
    OrderItem get(int id);
    List<OrderItem> list();
    List<OrderItem> list(Order o);
    List<OrderItem> list(int pid);
    List<OrderItem> listInCart(int uid);
    void add(OrderItem orderItem);
    //填充订单,页面要通过订单来调订单项
    void fill(List<Order> os);
    //基于用户对象user，查询没有生成订单的某产品的订单项
    OrderItem getUser_Product_notOrder(int uid, int pid);

    void fill(Order o);
    //得到销量给p
    int getSaleCount(Product p);
}
