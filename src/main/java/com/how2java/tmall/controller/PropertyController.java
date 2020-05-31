package com.how2java.tmall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.how2java.tmall.pojo.Category;
import com.how2java.tmall.pojo.Property;
import com.how2java.tmall.service.CategoryService;
import com.how2java.tmall.service.PropertyService;
import com.how2java.tmall.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("")
public class PropertyController {
    @Autowired
    PropertyService propertyService;
    @Autowired
    CategoryService categoryService;

    @RequestMapping("admin_property_list")
    public ModelAndView listProperty(int cid,Page page){//查看某分类下的属性
        ModelAndView mav=new ModelAndView();

        PageHelper.offsetPage(page.getStart(),page.getCount());
        List<Property> ps=propertyService.list(cid);
        int total=(int) new PageInfo<>(ps).getTotal();
        page.setTotal(total);
        page.setParam("&cid="+cid);
        //由于当前是某分类下的属性，为了页面分类的相关显示，加上categpry
        Category category=categoryService.get(cid);
        mav.addObject("category",category);
        //加入ps
        mav.addObject("propertyList",ps);

        mav.setViewName("admin/listProperty");
        return mav;
    }
    @RequestMapping("admin_property_add")
    public ModelAndView addProperty(Property property){
        ModelAndView mav=new ModelAndView("redirect:/admin_property_list?cid="+property.getCid());
        propertyService.add(property);
        return mav;
    }
    @RequestMapping("admin_property_delete")
    public ModelAndView deleteProperty(int id){
        Property property=getProperty(id);
        ModelAndView mav=new ModelAndView("redirect:/admin_property_list?cid="+property.getCid());
        propertyService.delete(id);
        return mav;
    }
    @RequestMapping("admin_property_edit")
    public ModelAndView editProperty(int id){
        ModelAndView mav=new ModelAndView();

        Property property=getProperty(id);
        Category category=categoryService.get(property.getCid());
        property.setCategory(category);//配置property的category

        mav.addObject("property",property);
        mav.setViewName("admin/editProperty");
        return mav;
    }
    @RequestMapping("admin_property_update")
    public ModelAndView updateProterty(Property property){
        ModelAndView mav=new ModelAndView("redirect:/admin_property_list?cid="+property.getCid());
        propertyService.update(property);
        return mav;
    }
    public Property getProperty(int id){
        return propertyService.get(id);
    }
}
