package com.cxy.service;

import com.cxy.pojo.Admins;
import com.cxy.service.impl.AdminServiceImpl;
import org.junit.Test;

/**
 * @author 陈翔宇
 * Date  2025/7/8 10:38
 */
public class AdminServiceTest {
    @Test
    public void login(){
        AdminService adminService = new AdminServiceImpl();
        Admins admins = adminService.login("admin","123456");
        System.out.println(admins!=null?"登陆成功":"登录失败");
    }
}
