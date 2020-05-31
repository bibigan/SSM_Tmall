package com.how2java.tmall.service;

import com.how2java.tmall.pojo.Category;
import com.how2java.tmall.pojo.Product;

import java.util.List;

public interface ProductService {
    List<Product> list(int cid);//某分类下的所有产品
    void add(Product product);
    void delete(int id);
    Product get(int id);
    int update(Product product);

    //增加 为了产品管理的显示
    void setFirstProductImage(Product p);

    //	为了首页的显示
    void fill(List<Category> cs);

    void fill(Category c);

    void fillByRow(List<Category> cs);
    //搜索关键词
    List<Product> searchProuducts(String keyword);

    //设置非数据库字段
    void setProductSingleImages(Product p);
    void setProductDetailImages(Product p);
    void setReviewCount(Product p);
    void setSaleCount(Product p);
    void setSaleAndReviewNumber(Product p);
    void setSaleAndReviewNumber(List<Product> ps);
}
