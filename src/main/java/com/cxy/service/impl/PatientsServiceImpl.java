package com.cxy.service.impl;

import com.cxy.Vo.PatientSearchVo;
import com.cxy.mapper.PatientsMapper;
import com.cxy.pojo.Patients;
import com.cxy.service.PatientsService;
import com.cxy.util.SqlSessionUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * 患者管理Service实现类
 * @author 王知涵
 * Date  2025/1/10 20:00
 */
public class PatientsServiceImpl implements PatientsService {
    
    @Override
    public List<Patients> getPatientAll(PatientSearchVo searchVo) {
        try {
            PatientsMapper mapper = SqlSessionUtil.getMapper(PatientsMapper.class);
            return mapper.selectPatientAll(searchVo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public PageInfo<Patients> getPatientsByPageAndSearch(PatientSearchVo searchVo, Integer pageNum, Integer pageSize) {
        try {
            PatientsMapper mapper = SqlSessionUtil.getMapper(PatientsMapper.class);
            
            // 使用pageHelper中的查询方法
            PageHelper.startPage(pageNum, pageSize);
            
            // 调用mapper中的查询方法
            List<Patients> patientsList = mapper.selectPatientAll(searchVo);
            
            // 返回pageInfo对象
            return new PageInfo<>(patientsList);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public Patients getPatientById(Integer patientId) {
        try {
            PatientsMapper mapper = SqlSessionUtil.getMapper(PatientsMapper.class);
            return mapper.selectPatientById(patientId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public Patients getPatientByIdCard(String idCardNumber) {
        try {
            PatientsMapper mapper = SqlSessionUtil.getMapper(PatientsMapper.class);
            return mapper.selectPatientByIdCard(idCardNumber);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public Patients getPatientByPhone(String phone) {
        try {
            PatientsMapper mapper = SqlSessionUtil.getMapper(PatientsMapper.class);
            return mapper.selectPatientByPhone(phone);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public List<Patients> getPatientsByDoctor(Integer doctorId, PatientSearchVo searchVo) {
        try {
            PatientsMapper mapper = SqlSessionUtil.getMapper(PatientsMapper.class);
            return mapper.selectPatientsByDoctor(doctorId, searchVo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public PageInfo<Patients> getPatientsByDoctorAndPage(Integer doctorId, PatientSearchVo searchVo, Integer pageNum, Integer pageSize) {
        try {
            PatientsMapper mapper = SqlSessionUtil.getMapper(PatientsMapper.class);
            
            // 使用pageHelper中的查询方法
            PageHelper.startPage(pageNum, pageSize);
            
            // 调用mapper中的查询方法
            List<Patients> patientsList = mapper.selectPatientsByDoctor(doctorId, searchVo);
            
            // 返回pageInfo对象
            return new PageInfo<>(patientsList);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public List<Patients> getPatientsByDepartment(Integer departmentId, PatientSearchVo searchVo) {
        try {
            PatientsMapper mapper = SqlSessionUtil.getMapper(PatientsMapper.class);
            return mapper.selectPatientsByDepartment(departmentId, searchVo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public PageInfo<Patients> getPatientsByDepartmentAndPage(Integer departmentId, PatientSearchVo searchVo, Integer pageNum, Integer pageSize) {
        try {
            PatientsMapper mapper = SqlSessionUtil.getMapper(PatientsMapper.class);
            
            // 使用pageHelper中的查询方法
            PageHelper.startPage(pageNum, pageSize);
            
            // 调用mapper中的查询方法
            List<Patients> patientsList = mapper.selectPatientsByDepartment(departmentId, searchVo);
            
            // 返回pageInfo对象
            return new PageInfo<>(patientsList);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public int countPatients(PatientSearchVo searchVo) {
        try {
            PatientsMapper mapper = SqlSessionUtil.getMapper(PatientsMapper.class);
            return mapper.countPatients(searchVo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public int countPatientsByDoctor(Integer doctorId) {
        try {
            PatientsMapper mapper = SqlSessionUtil.getMapper(PatientsMapper.class);
            return mapper.countPatientsByDoctor(doctorId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public boolean updatePassword(Integer patientId, String newPassword) {
        try {
            PatientsMapper mapper = SqlSessionUtil.getMapper(PatientsMapper.class);
            int result = mapper.updatePassword(patientId, newPassword);
            SqlSessionUtil.commit();
            return result > 0;
        } catch (Exception e) {
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
} 