package com.how2java.tmall.util;

import com.how2java.tmall.pojo.Product;

import java.util.Comparator;

public class ComparatorPrice implements Comparator<Product> {
    @Override
    public int compare(Product o1, Product o2) {//按价格从小到大排序
        if(o1.getPromotePrice()>o2.getPromotePrice())
            return 1;
        else if(o1.getPromotePrice()==o2.getPromotePrice())
            return 0;
        return -1;
    }
}
