package com.how2java.tmall.controller;

import com.how2java.tmall.pojo.Product;
import com.how2java.tmall.pojo.PropertyValue;
import com.how2java.tmall.service.ProductService;
import com.how2java.tmall.service.PropertyValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.Console;
import java.util.List;

@Controller
@RequestMapping("")
public class PropertyValueController {
    @Autowired
    PropertyValueService propertyValueService;
    @Autowired
    ProductService productService;

    @RequestMapping("admin_propertyValue_edit")
    public ModelAndView editPropertyValue(int pid){
        //admin_propertyValue_edit?id=${p.id}
        //product、pvs
        ModelAndView mav=new ModelAndView();

        Product product=productService.get(pid);
        //初始化某产品下所有的PropertyValue的pid\ptid
        propertyValueService.init(product);
        List<PropertyValue> propertyValueList=propertyValueService.list(product.getId());
        mav.addObject("product",product);
        mav.addObject("pvs",propertyValueList);
        mav.setViewName("admin/editPropertyValue");
        return mav;
    }
    @RequestMapping("admin_propertyValue_update")
    @ResponseBody//响应体中的数据
    public String updatePropertyValue(PropertyValue pv){//SSM接受到浏览器提交的json，并转换为pv对象
        propertyValueService.update(pv);

        return "success";
    }
}
