package com.how2java.tmall.controller;

import com.how2java.tmall.pojo.*;
import com.how2java.tmall.service.*;
import com.how2java.tmall.util.*;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpSession;
import java.io.Console;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("")
public class ForeController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    OrderService orderService;
    @Autowired
    ProductService productService;
    @Autowired
    ProductImageService productImageService;
    @Autowired
    PropertyService propertyService;
    @Autowired
    PropertyValueService propertyValueService;
    @Autowired
    UserService userService;
    @Autowired
    ReviewService reviewService;

    //首页
    @RequestMapping("forehome")
    public ModelAndView home(){
        ModelAndView mav=new ModelAndView();
//		所需要的数据：所有分类列表cs，并带有产品信息
//      所显示的视图：home.jsp
        List<Category> cs=categoryService.list();
        productService.fill(cs);//配置p
        productService.fillByRow(cs);//配置pByRow

        mav.addObject("cs",cs);
        mav.setViewName("fore/home");
        return  mav;
    }
    //注册
    @RequestMapping("foreregister")
    public ModelAndView register(User user){
        ModelAndView mav=new ModelAndView();
        //判断用户已经存在，返回msg "用户名已经被使用,不能使用"

        //为了页面显示用户名时防止恶意符号，要进行对名字的转义
        user.setName(HtmlUtils.htmlEscape(user.getName()));

        if(!userService.hasUser(user)){//可以注册，注册成功跳转到注册成功页面
            userService.add(user);
            mav.setViewName("redirect:/registerSuccessPage");//forePageNontroller响应这个路径
        }
        else{//不可注册，跳转原来页面
            String msg="用户名已经被使用,不能使用";
            mav.addObject("msg",msg);
            mav.setViewName("fore/register");//服务器跳转register.jsp
        }
        //由于user作为参数，会被隐性地加入到mav里,导致top.jsp里取得到user对象。所以要置空
        mav.addObject("user",null);
        return mav;
    }
    //登录
    @RequestMapping("forelogin")
    public ModelAndView login(User user, HttpSession session){
        ModelAndView mav=new ModelAndView();

        //为了页面显示用户名时防止恶意符号，要进行对名字的转义
        user.setName(HtmlUtils.htmlEscape(user.getName()));
        User u=userService.getUser(user.getName(),user.getPassword());//数据库找到的user

        session.setAttribute("user",u);//设置session的用户

        if(u!=null){//账户密码正确
            //设置user
            mav.setViewName("redirect:/forehome");
        }
        else{//不成功
            String msg=null;
            if(!userService.hasUser(user)){//不存在该用户名
                msg="该用户不存在";//服务器跳转，msg:该用户不存在
            }
            else{
                msg="密码错误";// 服务器跳转，msg:密码不正确
            }
            mav.setViewName("fore/login");
            mav.addObject("msg",msg);
            //由于user作为参数，会被隐性地加入到mav里,导致top.jsp里取得到user对象。所以要置空
            mav.addObject("user",null);
        }
        return  mav;
    }
    //退出
    @RequestMapping("forelogout")
    public ModelAndView logout(HttpSession session){
        //session去掉user，跳转到首页
        ModelAndView mav=new ModelAndView("redirect:/forehome");
        session.removeAttribute("user");
        return mav;
    }
    //产品页
    @RequestMapping("foreproduct")
    public ModelAndView product(int pid){
        ModelAndView mav =new ModelAndView();
        //需要传pvs、p、reviews
        Product product=productService.get(pid);//设置了非数据库字段
        productService.setProductDetailImages(product);
        productService.setProductSingleImages(product);

        List<PropertyValue> pvs=propertyValueService.list(pid);//设置了pt
        List<Review> reviews=reviewService.list(pid);//设置了user
        productService.setSaleAndReviewNumber(product);//设置了销量评论数
        mav.addObject("pvs",pvs);
        mav.addObject("p",product);
        mav.addObject("reviews",reviews);

        mav.setViewName("fore/product");
        return mav;
    }
    /*productImgAndInfo.jsp传来*/
    @RequestMapping("forecheckLogin")
    @ResponseBody//响应体中的数据
    public String checkLogin(HttpSession session){//判断此时是否在登录-模态登录
        User user =(User)session.getAttribute("user");
        if(null==user){//没有在登录
            return "failed";
        }
        else
            return "success";
    }

    @RequestMapping("foreloginAjax")
    @ResponseBody
    public String loginAjax(String name,String password,HttpSession session){
        name=HtmlUtils.htmlEscape(name);
        User user=userService.getUser(name,password);

        if(null!=user){//登录成功
            session.setAttribute("user",user);
            return "success";
        }
        else{
            return "failed";
        }
    }

    //分类页
    @RequestMapping("forecategory")
    public ModelAndView category(int cid,String sort){
        ModelAndView mav=new ModelAndView("fore/category");
        //需要填充好ps的c ps也要填充
        Category c=categoryService.get(cid);
        productService.fill(c);
        productService.setSaleAndReviewNumber(c.getProducts());
        //排序
        if(null!=sort){
            switch (sort){
                case "all":
                    Collections.sort(c.getProducts(), new ComparatorAll());
                    break;
                case "review":
                    Collections.sort(c.getProducts(), new ComparatorReview());
                    break;
                case "date":
                    Collections.sort(c.getProducts(), new ComparatorDate());
                    break;
                case "saleCount":
                    Collections.sort(c.getProducts(), new ComparatorSaleCount());
                    break;
                case "price":
                    Collections.sort(c.getProducts(), new ComparatorPrice());
                    break;
                default:break;
            }
        }
        mav.addObject("c",c);
        return mav;
    }
    //搜索
    @RequestMapping("foresearch")
    public ModelAndView search(String keyword,String sort){//搜索产品标题
        ModelAndView mav=new ModelAndView("fore/searchResult");
        //传递ps
        List<Product> ps=productService.searchProuducts(keyword);
        productService.setSaleAndReviewNumber(ps);

        //排序
        if(null!=sort){
            switch (sort){
                case "all":
                    Collections.sort(ps, new ComparatorAll());
                    break;
                case "review":
                    Collections.sort(ps, new ComparatorReview());
                    break;
                case "date":
                    Collections.sort(ps, new ComparatorDate());
                    break;
                case "saleCount":
                    Collections.sort(ps, new ComparatorSaleCount());
                    break;
                case "price":
                    Collections.sort(ps, new ComparatorPrice());
                    break;
                default:break;
            }
        }
        mav.addObject("keyword",keyword);
        mav.addObject("ps",ps);
        return mav;
    }
    //用户登录才能访问
    //加入购物车 新增 OrderItem
    @RequestMapping("foreaddCart")
    @ResponseBody
    public String addCart(int pid,int num,HttpSession session){//num:加入购物车的数量
        //和点击立即购买操作一样，就是返回值不同
        Product p=productService.get(pid);
        User user=(User)session.getAttribute("user");
        OrderItem oi=orderItemService.getUser_Product_notOrder(user.getId(),pid);//没有设置p
        if(oi==null){
            oi=new OrderItem();
            oi.setNumber(num);
            oi.setOid(-1);//未形成订单
            oi.setPid(p.getId());
            oi.setUid(user.getId());
            orderItemService.add(oi);//加到数据库,数据库自动判断是不是应该为-2//加到了购物车里
        }else{
            oi.setNumber(oi.getNumber()+num);
            orderItemService.update(oi);//更新数据库，数据库触发判断-2
        }
        return "success";
    }
    //立即购买 新增 OrderItem
    @RequestMapping("forebuyone")
    public ModelAndView buyone(int pid,int num,HttpSession session){
        ModelAndView mav=new ModelAndView();
        //需要填充了p的ois、付款总金额sum
        //a. 如果已经存在这个产品对应的OrderItem，并且还没有生成订单，即还在购物车中。 那么就应该在对应的OrderItem基础上，调整数量
        //a.1 基于用户对象user，查询没有生成订单的某产品的订单项
        //a.2 如果存在该订单项的话，就进行数量追加
        //b. 如果不存在对应的OrderItem,那么就新增一个订单项OrderItem
        //b.1 生成新的订单项
        //b.2 设置数量，用户和产品
        //b.3 插入到数据库
        //bug:结算时会把购物车里同一产品的订单项也算进去
        // 要解决要给oi添加type字段。区分订单项是来源于立即购买还是购物车----逆向工程的问题
        Product p=productService.get(pid);
        User user=(User)session.getAttribute("user");
        OrderItem oi=orderItemService.getUser_Product_notOrder(user.getId(),pid);//没有设置p
        if(oi==null){
            oi=new OrderItem();
            oi.setNumber(num);
            oi.setOid(-1);//未形成订单
            oi.setPid(p.getId());
            oi.setUid(user.getId());
            orderItemService.add(oi);//加到数据库,数据库自动判断是不是应该为-2//加到了购物车里
        }else{
            oi.setNumber(oi.getNumber()+num);
            orderItemService.update(oi);//更新数据库,数据库触犯判断-2
        }
        int oiid=oi.getId();//加到数据库后，自动将原来对象的id填充
        mav.setViewName("redirect:forebuy?oiid="+oiid);
        return mav;
    }
    //结算页面
    @RequestMapping("forebuy")
    public ModelAndView buy(int[] oiid,HttpSession session){
        ModelAndView mav=new ModelAndView("fore/buy");
        List<OrderItem> ois = new ArrayList<>();
        float total = 0;
        for (int i=0;i<oiid.length;i++) {
            int id = oiid[i];
            OrderItem oi= orderItemService.get(id);
            total +=oi.getProduct().getPromotePrice()*oi.getNumber();
            ois.add(oi);
        }
        session.setAttribute("ois", ois);//为了后面点击提交订单时调用到订单项
        session.setAttribute("oiids",oiid);
        mav.addObject("sum", total);
        return mav;
    }
    @RequestMapping("forecart")
    public ModelAndView cart(HttpSession session){
//        1. 通过session获取当前用户
//        所以一定要登录才访问，否则拿不到用户对象,会报错
//        2. 获取为这个用户关联的未成订单的订单项集合 ois
//        3. 把ois放在model中
//        4. 服务端跳转到cart.jsp
        ModelAndView mav=new ModelAndView("fore/cart");
        User user=(User) session.getAttribute("user");//已经模态登录
        List<OrderItem> ois=orderItemService.listInCart(user.getId());

        String mess=(String)session.getAttribute("mess");
        if(mess!=null){
            mav.addObject("mess",mess);
            session.removeAttribute("mess");
        }

        mav.addObject("ois",ois);
        return mav;
    }
    //异步刷新购物车数量
    @RequestMapping("forecartNumber")
    @ResponseBody
    public String cartNumber(HttpSession session){
        int data=(int) session.getAttribute("cartTotalItemNumber");
        //System.out.println("***************************data**********    ==="+data);
        return data+"";
    }
    //购物车页面
    //更改oi的数量
    @RequestMapping("forechangeOrderItem")
    @ResponseBody
    public String changeOrderItem(int pid,int number,HttpSession session){
        User user=(User)session.getAttribute("user");
        if(null==user)
            return "fail";
        //找到用户购物车下更改产品数量的订单项
        OrderItem oi=orderItemService.getUser_Product_notOrder(user.getId(),pid);
        oi.setNumber(number);
        orderItemService.update(oi);//数据库触发判断-2
        //再次
        int oiid=oi.getId();
        OrderItem oii=orderItemService.get(oiid);
        if(oii.getOid()==-2)
            return ""+oi.getProduct().getStock();
        return "success";
    }
    //设置最新的stock
    @RequestMapping("foregetStock")
    @ResponseBody
    public String getStock(int oiid){
        //找到用户购物车下更改产品数量的订单项
        OrderItem oi=orderItemService.get(oiid);
        return oi.getProduct().getStock()+"";
    }
    //待购买的oi是否存在num>stock /库存为0 过期的
    @RequestMapping("forecheckNum")
    @ResponseBody
    public String checkNum(int oiid){
        OrderItem oi=orderItemService.get(oiid);
        if(oi.getOid()==-2||oi.getProduct().getStock()==0)
            return "fail";
        return "success";
    }

    //删除订单项
    @RequestMapping("foredeleteOrderItem")
    @ResponseBody
    public String deleteOrderItem(int oiid,HttpSession session){
        User user=(User)session.getAttribute("user");
        if(null==user)
            return "fail";
        orderItemService.delete(oiid);
        return "success";
    }
    //提交订单
    @RequestMapping("forecreateOrder")
    public ModelAndView createOrder(Order order,HttpSession session){
        //新增oder，并把oi的oid改为该订单-----事务管理
        ModelAndView mav=new ModelAndView();

        //得到ois
        //请求结算页面时就把ois放session里了
        boolean flag=false;
        //重新获取一次ois
        int[] oiids=(int[])session.getAttribute("oiids");
        for (int i=0;i<oiids.length;i++) {
            int id = oiids[i];
            OrderItem oi= orderItemService.get(id);
            if(oi.getOid()==-2){
                flag=true;
                break;
            }
        }
        if(flag){//存在不行
            mav.setViewName("redirect:forecart");
            session.setAttribute("mess","当前商品库存有变化，重新购买商品！");
            return mav;
        }
        else {//全部都可以
            List<OrderItem> ois = (List<OrderItem>)session.getAttribute("ois");
            User user=(User)session.getAttribute("user");
            //根据当前时间加上一个4位随机数生成订单号
            SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyyMMddHHmmssSSS");
            String orderCode=simpleDateFormat.format(new Date())+RandomUtils.nextInt(10000);
            //设置order
            order.setOrderCode(orderCode);
            order.setCreateDate(new Date());
            order.setUid(user.getId());
            order.setStatus(OrderService.waitPay);//待支付

            //修改数据库中order表和orderItem表，并得到订单总金额
            float total=orderService.add(order,ois);
            mav.setViewName("redirect:forealipay?oid="+order.getId()+"&total="+total);
            return mav;
        }
    }
    //确认支付页面提交
    @RequestMapping("forepayed")
    public ModelAndView payed(int oid,float total){
        //修改订单对象的状态和支付时间
        ModelAndView mav=new ModelAndView("fore/payed");
        Order order=orderService.get(oid);
        order.setStatus(OrderService.waitDelivery);//待发货
        order.setPayDate(new Date());
        orderService.update(order);
        mav.addObject("o",order);
        return mav;
    }
    //订单页
    @RequestMapping("forebought")
    public ModelAndView bought(HttpSession session){
        //得到含oi的os
        ModelAndView mav=new ModelAndView("fore/bought");
        User u=(User)session.getAttribute("user");
        //查询user所有的状态不是"delete" 的订单集合os
        List<Order> os=orderService.listByUsr(u.getId(),OrderService.delete);
        //填充订单项
        orderItemService.fill(os);
        mav.addObject("os",os);
        return mav;
    }
    //确认收货页面
    @RequestMapping("foreconfirmPay")
    public ModelAndView confirmPay(int oid){
        ModelAndView mav=new ModelAndView("fore/confirmPay");
        Order o=orderService.get(oid);
        orderItemService.fill(o);
        mav.addObject("o",o);
        return mav;
    }
    //点击确认
    @RequestMapping("foreorderConfirmed")
    public ModelAndView orderConfirmed(int oid){
        ModelAndView mav=new ModelAndView("fore/orderConfirmed");
        Order o=orderService.get(oid);
        o.setConfirmDate(new Date());
        o.setStatus(OrderService.waitReview);
        orderService.update(o);
        return mav;
    }
    //点击评价
    @RequestMapping("forereview")
    public ModelAndView review(int oid){
        ModelAndView mav=new ModelAndView("fore/review");
        Order o=orderService.get(oid);
        orderItemService.fill(o);

        Product p=o.getorderItemList().get(0).getProduct();
        productService.setSaleAndReviewNumber(p);

        List<Review> rs=reviewService.list(p.getId());

        mav.addObject("p",p);
        mav.addObject("o",o);
        mav.addObject("reviews",rs);
        return mav;
    }
    //AJAX点击删除
    @RequestMapping("foredeleteOrder")
    @ResponseBody
    public String deleteOrder(int oid){
        Order o=orderService.get(oid);
        o.setStatus(OrderService.delete);
        orderService.update(o);
        return "success";
    }
    //提交评价
    //新建评价
    @RequestMapping("foredoreview")
    public ModelAndView doreview(int oid,int pid,String content,HttpSession session){
        ModelAndView mav=new ModelAndView();
        Order o=orderService.get(oid);
        o.setStatus(OrderService.finish);
        orderService.update(o);

        Product p=productService.get(pid);

        content=HtmlUtils.htmlEscape(content);//转义

        User user=(User)session.getAttribute("user");

        Review review=new Review();
        review.setUser(user);
        review.setContent(content);
        review.setCreateDate(new Date());
        review.setPid(pid);
        review.setUid(user.getId());
        reviewService.add(review);
        mav.setViewName("redirect:forereview?oid="+oid+"&showonly=true");
        return mav;
    }
}

