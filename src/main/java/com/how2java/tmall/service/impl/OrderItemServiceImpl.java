package com.how2java.tmall.service.impl;

import com.how2java.tmall.mapper.OrderItemMapper;
import com.how2java.tmall.pojo.Order;
import com.how2java.tmall.pojo.OrderItem;
import com.how2java.tmall.pojo.OrderItemExample;
import com.how2java.tmall.pojo.Product;
import com.how2java.tmall.service.OrderItemService;
import com.how2java.tmall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class OrderItemServiceImpl implements OrderItemService{
    @Autowired
    OrderItemMapper orderItemMapper;
    @Autowired
    ProductService productService;
    @Override
    public void delete(int id) {
        orderItemMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(OrderItem c) {
        orderItemMapper.updateByPrimaryKeySelective(c);
    }

    @Override
    public OrderItem get(int id) {
        OrderItem oi= orderItemMapper.selectByPrimaryKey(id);
        setProduct(oi);
        return oi;
    }

    @Override
    public void add(OrderItem orderItem) {
        orderItemMapper.insert(orderItem);
    }

    @Override
    public List<OrderItem> list() {
        OrderItemExample orderItemExample=new OrderItemExample();
        orderItemExample.setOrderByClause("id desc");
        List<OrderItem> orderItems= orderItemMapper.selectByExample(orderItemExample);
        setProduct(orderItems);
        return orderItems;
    }
    @Override
    public List<OrderItem> list(Order o) {
        OrderItemExample orderItemExample=new OrderItemExample();
        orderItemExample.createCriteria().andOidEqualTo(o.getId());
        orderItemExample.setOrderByClause("id desc");
        List<OrderItem> orderItems= orderItemMapper.selectByExample(orderItemExample);
        setProduct(orderItems);
        return orderItems;
    }
    @Override
    public List<OrderItem> list(int pid){//查看某产品下的订单项
        OrderItemExample orderItemExample=new OrderItemExample();
        orderItemExample.createCriteria().andPidEqualTo(pid);
        orderItemExample.setOrderByClause("id desc");
        List<OrderItem> orderItems= orderItemMapper.selectByExample(orderItemExample);
        setProduct(orderItems);
        return orderItems;
    }

    @Override
    public List<OrderItem> listInCart(int uid) {//查看某用户购物车里的订单项oid=-1;
        OrderItemExample orderItemExample=new OrderItemExample();
        orderItemExample.createCriteria().andUidEqualTo(uid)
                                         .andOidEqualTo(-1);
        orderItemExample.setOrderByClause("id desc");
        List<OrderItem> orderItems= orderItemMapper.selectByExample(orderItemExample);
        setProduct(orderItems);
        return orderItems;
    }

    @Override
    public void fill(List<Order> os) {
        for(Order o:os)
            fill(o);
    }

    @Override
    public void fill(Order o) {
        List<OrderItem> ois=list(o);//找出o下的所有oi 设置了ois的所属产品
        // 计算o的总金额、总数量
        float total=0f;//该订单的总计金额
        int totalNumber=0;//该订单的总计数量
        for(OrderItem oi:ois){
            total+=oi.getProduct().getPromotePrice()*oi.getNumber();
            totalNumber+=oi.getNumber();
        }
        o.setorderItemList(ois);
        o.setTotal(total);
        o.setTotalNumber(totalNumber);
    }
    public  void setProduct(List<OrderItem> ois){
        for(OrderItem oi:ois)
            setProduct(oi);
    }
    public  void setProduct(OrderItem oi){//设置订单项的所属产品
        Product product= productService.get(oi.getPid());
        oi.setProduct(product);
    }
    @Override
    public int getSaleCount(Product p){
        //销量为该产品下的订单项的数量之和
        OrderItemExample example =new OrderItemExample();
        example.createCriteria().andPidEqualTo(p.getId());
        List<OrderItem> ois =orderItemMapper.selectByExample(example);
        int result =0;
        for (OrderItem oi : ois) {
            result+=oi.getNumber();
        }
        return result;
    }
    //基于用户对象user，查询没有生成订单的某产品的订单项
    @Override
    public OrderItem getUser_Product_notOrder(int uid, int pid) {
        OrderItemExample example=new OrderItemExample();
        example.createCriteria().andPidEqualTo(pid)
                                .andUidEqualTo(uid)
                                .andOidEqualTo(-1);
        List<OrderItem> ois=orderItemMapper.selectByExample(example);
        //setProduct(ois.get(0));
        if(ois.isEmpty())
            return null;
        return ois.get(0);
    }
}
