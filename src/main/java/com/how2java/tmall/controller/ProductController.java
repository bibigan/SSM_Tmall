package com.how2java.tmall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.how2java.tmall.pojo.Category;
import com.how2java.tmall.pojo.Product;
import com.how2java.tmall.service.CategoryService;
import com.how2java.tmall.service.ProductService;
import com.how2java.tmall.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("")
public class ProductController {
    @Autowired
    ProductService productService;
    @Autowired
    CategoryService categoryService;

    @RequestMapping("admin_product_list")
    public ModelAndView listProduct(int cid, Page page){
        //路径：admin_product_list?cid=${c.id}
        ModelAndView mav=new ModelAndView();
        //配置page
        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Product> productList =productService.list(cid);
        int total=(int) new PageInfo<>(productList).getTotal();
        page.setTotal(total);
        page.setParam("&cid="+cid);
        //配置mav
        mav.addObject("productList",productList);
        Category category=categoryService.get(cid);
        mav.addObject("category",category);
        mav.setViewName("admin/listProduct");
        return mav;
    }
    @RequestMapping("admin_product_add")
    public ModelAndView addProduct(Product product){
        ModelAndView mav=new ModelAndView("redirect:/admin_product_list?cid="+product.getCid());
        product.setCreateDate(new Date());
        productService.add(product);
        return mav;
    }
    @RequestMapping("admin_product_delete")
    public ModelAndView deleteProduct(int id){
        Product product=productService.get(id);
        ModelAndView mav=new ModelAndView("redirect:/admin_product_list?cid="+product.getCid());
        productService.delete(id);
        return mav;
    }
    @RequestMapping("admin_product_edit")
    public ModelAndView editProduct(int id){
        ModelAndView mav=new ModelAndView();
        //product
        Product product=productService.get(id);
        //已经在serviceImpl中设置了
        //Category category=categoryService.get(product.getCid());
        //product.setCategory(category);
        //mav
        mav.addObject("product",product);
        mav.setViewName("admin/editProduct");
        return mav;
    }
    @RequestMapping("admin_product_update")
    public ModelAndView updateProduct(Product product){
        ModelAndView mav=new ModelAndView("redirect:/admin_product_list?cid="+product.getCid());
        productService.update(product);
        return mav;
    }
}
