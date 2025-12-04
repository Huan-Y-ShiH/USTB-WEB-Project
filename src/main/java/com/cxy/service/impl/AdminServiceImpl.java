package com.cxy.service.impl;

import com.cxy.mapper.AdminMapper;
import com.cxy.pojo.Admins;
import com.cxy.service.AdminService;
import com.cxy.util.SqlSessionUtil;

/**
 *
 * @author  陈翔宇
 * Date  2025/7/8 10:35
 */
public class AdminServiceImpl implements AdminService {
    @Override
    public Admins login(String username, String password) {
        try {
            AdminMapper mapper = SqlSessionUtil.getMapper(AdminMapper.class);
            Admins admin = mapper.selectAdminByName(username);
            if(admin != null && admin.getPassword().equals(password)){
                return admin;
            }
            return null;
        }catch (Exception e){
            throw new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }
}
