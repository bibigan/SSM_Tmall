package com.how2java.tmall.service;

import com.how2java.tmall.pojo.Review;

import java.util.List;

public interface ReviewService {
    List<Review> list(int pid);//某产品下的评论
    Review get(int id);
    void add(Review r);
    void delete(int id);
    void update(Review r);
    int getReviewCount(int pid);//某产品下的评论数
}
