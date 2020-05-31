package com.how2java.tmall.service;

import com.how2java.tmall.pojo.ProductImage;

import java.util.List;

public interface ProductImageService {
    String type_detail="type_detail";
    String type_single="type_single";
//没有编辑和修改
    List<ProductImage> list(int pid, String type);//某产品下某类型下的所有产品图片
    void add(ProductImage productImage);
    void delete(int id);
    ProductImage get(int id);
    void update(ProductImage productImage);
}
