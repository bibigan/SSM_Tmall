package com.how2java.tmall.service;

import com.how2java.tmall.pojo.Product;
import com.how2java.tmall.pojo.PropertyValue;

import java.util.List;

public interface PropertyValueService {
    void init(Product product);
    void update(PropertyValue propertyValue);

    PropertyValue get(int ptid, int pid);//根据属性id和产品id获取PropertyValue对象
    List<PropertyValue> list(int pid);
}
