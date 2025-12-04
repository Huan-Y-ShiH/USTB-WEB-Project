package com.cxy.service.impl;

import com.cxy.mapper.UsersAppointmentMapper;
import com.cxy.pojo.Appointments;
import com.cxy.service.UsersAppointmentsService;
import com.cxy.util.SqlSessionUtil;
import com.cxy.Vo.PatientSearchVo;

import java.util.Collections;
import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/17 21:33
 */
public class UsersAppointmentsServiceImpl implements UsersAppointmentsService {
    @Override
    public List<Appointments> getMyAppointments(Integer patientId) {
        UsersAppointmentMapper mapper = SqlSessionUtil.getMapper(UsersAppointmentMapper.class);
        return mapper.selectMyAppointments(patientId);
    }

    @Override
    public int cancelAppointment(Integer appointmentId) {
        UsersAppointmentMapper mapper = SqlSessionUtil.getMapper(UsersAppointmentMapper.class);
        int result = mapper.cancelAppointment(appointmentId);
        SqlSessionUtil.commit();
        return result;
    }
    
    @Override
    public List<Appointments> searchAppointments(PatientSearchVo searchVo) {
        UsersAppointmentMapper mapper = SqlSessionUtil.getMapper(UsersAppointmentMapper.class);
        return mapper.searchAppointments(searchVo);
    }
    
    @Override
    public int getAppointmentCount(PatientSearchVo searchVo) {
        UsersAppointmentMapper mapper = SqlSessionUtil.getMapper(UsersAppointmentMapper.class);
        return mapper.getAppointmentCount(searchVo);
    }
    
    @Override
    public Appointments getAppointmentDetail(Integer appointmentId, Integer patientId) {
        UsersAppointmentMapper mapper = SqlSessionUtil.getMapper(UsersAppointmentMapper.class);
        return mapper.getAppointmentDetail(appointmentId, patientId);
    }
    
    @Override
    public boolean addAppointment(Integer patientId, Integer doctorId, String appointmentDate, String appointmentTime) {
        try {
            UsersAppointmentMapper mapper = SqlSessionUtil.getMapper(UsersAppointmentMapper.class);
            int result = mapper.addAppointment(patientId, doctorId, appointmentDate, appointmentTime);
            SqlSessionUtil.commit();
            return result > 0;
        } catch (Exception e) {
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public boolean hasExistingAppointment(Integer patientId, Integer doctorId, String appointmentDate, String appointmentTime) {
        try {
            UsersAppointmentMapper mapper = SqlSessionUtil.getMapper(UsersAppointmentMapper.class);
            int count = mapper.checkExistingAppointment(patientId, doctorId, appointmentDate, appointmentTime);
            return count > 0;
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public boolean deleteAppointment(Integer appointmentId, Integer patientId) {
        try {
            UsersAppointmentMapper mapper = SqlSessionUtil.getMapper(UsersAppointmentMapper.class);
            int result = mapper.deleteAppointment(appointmentId, patientId);
            SqlSessionUtil.commit();
            return result > 0;
        } catch (Exception e) {
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public Appointments getAppointmentForDelete(Integer appointmentId, Integer patientId) {
        try {
            UsersAppointmentMapper mapper = SqlSessionUtil.getMapper(UsersAppointmentMapper.class);
            return mapper.getAppointmentForDelete(appointmentId, patientId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
}