package com.how2java.tmall.service;

import com.how2java.tmall.pojo.Property;

import java.util.List;

public interface PropertyService {
    List<Property> list(int cid);//某分类下的所有属性
    void add(Property property);
    void delete(int id);
    Property get(int id);
    int update(Property property);
}
