package com.cxy.service.impl;

import com.cxy.mapper.UsersMapper;
import com.cxy.pojo.Patients;
import com.cxy.service.UsersService;
import com.cxy.util.SqlSessionUtil;

/**
 * @author 陈翔宇
 * Date  2025/7/17 21:02
 */
public class UsersServiceImpl implements UsersService {
    @Override
    public int register(Patients patient) {
        try {
            UsersMapper mapper = SqlSessionUtil.getMapper(UsersMapper.class);
            int result = mapper.insertPatient(patient);
            SqlSessionUtil.commit();
            return result;
        } catch (Exception e) {
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public Patients login(String phone, String password) {
        try {
            UsersMapper mapper = SqlSessionUtil.getMapper(UsersMapper.class);
            return mapper.selectByPhoneAndPassword(phone, password);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public int updatePatientInfo(Patients patient) {
        try {
            UsersMapper mapper = SqlSessionUtil.getMapper(UsersMapper.class);
            int result = mapper.updatePatientInfo(patient);
            SqlSessionUtil.commit();
            return result;
        } catch (Exception e) {
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
}