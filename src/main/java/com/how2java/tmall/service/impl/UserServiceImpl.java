package com.how2java.tmall.service.impl;

import com.how2java.tmall.mapper.UserMapper;
import com.how2java.tmall.pojo.User;
import com.how2java.tmall.pojo.UserExample;
import com.how2java.tmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserMapper userMapper;
    @Override
    public void add(User c) {
        userMapper.insert(c);
    }

    @Override
    public void delete(int id) {
        userMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(User c) {
        userMapper.updateByPrimaryKeySelective(c);
    }

    @Override
    public User get(int id) {
        return userMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<User> list() {//只有查询
        UserExample userExample=new UserExample();
        userExample.setOrderByClause("id desc");
        List<User> userList=userMapper.selectByExample(userExample);
        return userList;
    }

    @Override
    public boolean hasUser(User u) {//判断是否存在该用户,存在true
        UserExample userExample=new UserExample();
        userExample.createCriteria().andNameEqualTo(u.getName());
        List<User> userList=userMapper.selectByExample(userExample);
        return !userList.isEmpty();
    }
    @Override
    public boolean hasUser(String name) {//判断是否存在该用户,存在true
        UserExample userExample=new UserExample();
        userExample.createCriteria().andNameEqualTo(name);
        List<User> userList=userMapper.selectByExample(userExample);
        return !userList.isEmpty();
    }

    @Override
    public boolean checkPassword(User u) {//判断密码是否正确
        UserExample userExample=new UserExample();
        userExample.createCriteria().andNameEqualTo(u.getName())
                                    .andPasswordEqualTo(u.getPassword());
        List<User> userList=userMapper.selectByExample(userExample);
        return !userList.isEmpty();
    }

    @Override
    public User getUser(String name, String password) {
        UserExample userExample=new UserExample();
        userExample.createCriteria().andNameEqualTo(name)
                .andPasswordEqualTo(password);
        List<User> userList=userMapper.selectByExample(userExample);
        if(userList.isEmpty())
            return null;
        return userList.get(0);
    }
}
