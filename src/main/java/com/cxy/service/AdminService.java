package com.cxy.service;

import com.cxy.pojo.Admins;

/**
 * @author 陈翔宇
 * Date  2025/7/8 10:33
 */
public interface AdminService {
    Admins login(String username,String password);
}
