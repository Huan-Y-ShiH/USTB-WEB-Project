package com.cxy.mapper;

import com.cxy.pojo.Patients;
import org.apache.ibatis.annotations.Param;

/**
 * @author 陈翔宇
 * Date  2025/7/17 21:00
 */
public interface UsersMapper {
    /**
     * 用户注册
     */
    int insertPatient(Patients patient);

    /**
     * 用户登录（通过手机号和密码）
     */
    Patients selectByPhoneAndPassword(@Param("phone") String phone, @Param("password") String password);

    /**
     * 根据ID查询患者信息
     */
    Patients getPatientById(@Param("patientId") Integer patientId);

    /**
     * 修改患者个人信息
     */
    int updatePatientInfo(Patients patient);
}
