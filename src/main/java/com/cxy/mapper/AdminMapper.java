package com.cxy.mapper;

import com.cxy.pojo.Admins;

/**
 * @author 陈翔宇
 * Date  2025/7/8 10:16
 */
public interface AdminMapper  {
    /**
     * 根据用户名查询用户信息
     * @param username
     * @ return
     */
    Admins selectAdminByName(String username);
}
