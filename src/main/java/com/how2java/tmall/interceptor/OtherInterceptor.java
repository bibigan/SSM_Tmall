package com.how2java.tmall.interceptor;

import com.how2java.tmall.pojo.Category;
import com.how2java.tmall.pojo.OrderItem;
import com.how2java.tmall.pojo.User;
import com.how2java.tmall.service.CategoryService;
import com.how2java.tmall.service.OrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class OtherInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    CategoryService categoryService;
    @Autowired
    OrderItemService orderItemService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        return super.preHandle(request, response, handler);
    }
    /**
     * 在业务处理器处理请求执行完成后,生成视图之前执行的动作
     * 可在modelAndView中加入数据，比如当前时间
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        super.postHandle(request, response, handler, modelAndView);
        //获取分类信息放搜索栏下
        List<Category> cs=categoryService.list();
        request.getSession().setAttribute("cs", cs);
        //获取当前的contextPath:tmall_ssm
        HttpSession session=request.getSession();
        String contextPath=session.getServletContext().getContextPath();
        request.getSession().setAttribute("contextPath", contextPath);
        //获取购物车数量
        User user =(User)  session.getAttribute("user");
        int  cartTotalItemNumber = 0;
        if(null!=user){//有登录
            List<OrderItem> ois=orderItemService.listInCart(user.getId());
            for(OrderItem oi:ois)
                cartTotalItemNumber+=oi.getNumber();
        }
        request.getSession().setAttribute("cartTotalItemNumber", cartTotalItemNumber);
    }
//    在访问视图之后被调用
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        super.afterCompletion(request, response, handler, ex);
    }

    @Override
    public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        super.afterConcurrentHandlingStarted(request, response, handler);
    }
}
