package com.how2java.tmall.util;

import com.how2java.tmall.pojo.Product;

import java.util.Comparator;

public class ComparatorDate implements Comparator<Product> {
    @Override
    public int compare(Product o1, Product o2) {//按时间从大到小排序
        if(o2.getCreateDate().getTime()>o1.getCreateDate().getTime())
            return 1;
        else if(o2.getCreateDate().getTime()==o1.getCreateDate().getTime())
            return 0;
        return -1;
    }
}
