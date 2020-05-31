package com.how2java.tmall.service;

import com.how2java.tmall.pojo.User;

import java.util.List;

public interface UserService {
    void add(User c);
    void delete(int id);
    void update(User c);
    User get(int id);
    List<User> list();
    boolean hasUser(User u);
    boolean hasUser(String name);
    boolean checkPassword(User u);
    User getUser(String name, String password);
}
