package com.how2java.tmall.service.impl;

import com.how2java.tmall.mapper.OrderMapper;
import com.how2java.tmall.pojo.*;
import com.how2java.tmall.service.OrderItemService;
import com.how2java.tmall.service.OrderService;
import com.how2java.tmall.service.ProductService;
import com.how2java.tmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    OrderMapper orderMapper;
    @Autowired
    UserService userService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    ProductService productService;

    @Override
    public void delete(int id) {
        orderMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Order c) {
        orderMapper.updateByPrimaryKeySelective(c);
    }

    @Override
    public Order get(int id) {
        return orderMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Order> list() {
        OrderExample orderExample=new OrderExample();
        orderExample.setOrderByClause("id desc");
        List<Order> os= orderMapper.selectByExample(orderExample);
        //设置user
        setUser(os);
        return os;
    }
    public void setUser(List<Order> os){
        for (Order o : os)
            setUser(o);
    }
    public void setUser(Order o){
        int uid = o.getUid();
        User u = userService.get(uid);
        o.setUser(u);
    }

    //提交订单，同时新增订单和修改订单项,并返回订单总金额
    @Override
    @Transactional(propagation = Propagation.REQUIRED,rollbackForClassName = "Exception")//通过注解进行事务管理
    public float add(Order o,List<OrderItem> ois) {
        float total=0f;
        orderMapper.insert(o);

        if(false)//模拟当增加订单后出现异常，观察事务管理是否预期发生。（需要把false修改为true才能观察到）
            throw new RuntimeException();

        for(OrderItem oi:ois){
            oi.setOid(o.getId());
            orderItemService.update(oi);
            total+=oi.getNumber()*oi.getProduct().getPromotePrice();
            //减少p库存
            Product p=oi.getProduct();
            p.descStock(oi.getNumber());
            productService.update(p);//数据库触发断判断在该产品下，是否有-2的oi可以改为-1，或者-1的改为-2
            System.out.println("!!!!!!!!!!!!!!!!减库存!!!!!!!!!!!!!!!");
        }
        return total;
    }

    @Override
    public List<Order> listByUsr(int uid, String excludedStatus) {//查看用户的订单，不是excludedStatus状态
        OrderExample orderExample=new OrderExample();
        orderExample.createCriteria().andUidEqualTo(uid)
                                    .andStatusNotEqualTo(excludedStatus);
        orderExample.setOrderByClause("id desc");
        List<Order> os= orderMapper.selectByExample(orderExample);
        return os;
    }
}
