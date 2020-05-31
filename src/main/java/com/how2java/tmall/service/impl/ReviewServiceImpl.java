package com.how2java.tmall.service.impl;

import com.how2java.tmall.mapper.ReviewMapper;
import com.how2java.tmall.pojo.Review;
import com.how2java.tmall.pojo.ReviewExample;
import com.how2java.tmall.pojo.User;
import com.how2java.tmall.service.ReviewService;
import com.how2java.tmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {
    @Autowired
    ReviewMapper reviewMapper;
    @Autowired
    UserService userService;

    @Override
    public List<Review> list(int pid) {
        ReviewExample example=new ReviewExample();
        example.createCriteria().andPidEqualTo(pid);
        example.setOrderByClause("id desc");
        List<Review> reviews=reviewMapper.selectByExample(example);
        setUser(reviews);
        return reviews;
    }

    @Override
    public Review get(int id) {
        Review r=reviewMapper.selectByPrimaryKey(id);
        setUser(r);
         return r;
    }

    @Override
    public void add(Review r) {
        reviewMapper.insert(r);
    }

    @Override
    public void delete(int id) {
        reviewMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Review r) {
        reviewMapper.updateByPrimaryKeySelective(r);
    }

    @Override
    public int getReviewCount(int pid) {
        return list(pid).size();
    }
    public void setUser(Review r){
        User user=userService.get(r.getId());
        r.setUser(user);
    }
    public void setUser(List<Review> reviews){
        for(Review r:reviews){
            setUser(r);
        }
    }
}
