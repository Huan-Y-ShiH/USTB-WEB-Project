package com.cxy.mapper;

import com.cxy.pojo.Admins;
import com.cxy.util.SqlSessionUtil;
import org.junit.Test;

/**
 * @author 陈翔宇
 * Date  2025/7/8 10:20
 */
public class AdminMapperTest {
    @Test
    public void selectAdminByName(){
        AdminMapper mapper = SqlSessionUtil.getMapper(AdminMapper.class);
        Admins admin = mapper.selectAdminByName("admin");
        System.out.println(admin);
    }
}
