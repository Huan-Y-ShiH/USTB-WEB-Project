package com.cxy.service;

import com.cxy.pojo.Patients;


/**
 * @author 陈翔宇
 * Date  2025/7/17 21:01
 */
public interface UsersService {
    /**
     * 用户注册
     * @param patient 患者对象
     * @return 注册结果（1成功，0失败）
     */
    int register(Patients patient);

    /**
     * 用户登录（通过手机号和密码）
     * @param phone 手机号
     * @param password 密码
     * @return 登录成功返回患者对象，否则返回null
     */
    Patients login(String phone, String password);

    /**
     * 修改患者个人信息
     */
    int updatePatientInfo(Patients patient);
}
