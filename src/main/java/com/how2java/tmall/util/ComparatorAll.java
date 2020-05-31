package com.how2java.tmall.util;

import com.how2java.tmall.pojo.Product;

import java.util.Comparator;

public class ComparatorAll implements Comparator<Product> {
    @Override
    public int compare(Product o1, Product o2) {//把 销量x评价 高的放前面
        return o2.getReviewCount()*o2.getSaleCount()-o1.getReviewCount()*o1.getSaleCount();
    }
}
