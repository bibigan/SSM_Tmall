package com.how2java.tmall.util;

import com.how2java.tmall.pojo.Product;

import java.util.Comparator;

public class ComparatorSaleCount implements Comparator<Product> {
    @Override
    public int compare(Product o1, Product o2) {//按销量从大到小排序
        return o2.getSaleCount()-o1.getSaleCount();
    }
}
