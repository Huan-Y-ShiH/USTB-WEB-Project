package com.cxy.service.impl;

import com.cxy.mapper.AppointmentsMapper;
import com.cxy.pojo.Appointments;
import com.cxy.service.AppointmentsService;
import com.cxy.util.SqlSessionUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/16 16:44
 */
public class AppointmentsServiceImpl implements AppointmentsService {
    @Override
    public List<Appointments> selectAllAppointments(String patientName, String doctorName,
                                                    String status, Date appointmentDate) {
        try {
            AppointmentsMapper mapper = SqlSessionUtil.getMapper(AppointmentsMapper.class);
            return mapper.selectAllAppointments(patientName, doctorName, status, appointmentDate);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public PageInfo<Appointments> getAppointmentsByPageAndSearch(String patientName, String doctorName,
                                                                 String status, Date appointmentDate,
                                                                 Integer pageNum, Integer pageSize) {
        try {
            AppointmentsMapper mapper = SqlSessionUtil.getMapper(AppointmentsMapper.class);

            // 使用pageHelper进行分页
            PageHelper.startPage(pageNum, pageSize);

            // 调用mapper查询方法
            List<Appointments> appointmentsList = mapper.selectAllAppointments(patientName, doctorName, status, appointmentDate);

            // 返回pageInfo对象
            return new PageInfo<>(appointmentsList);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public int addAppointment(Appointments appointment) {
        try {
            AppointmentsMapper mapper = SqlSessionUtil.getMapper(AppointmentsMapper.class);

            // 设置创建时间
            if (appointment.getCreatetime() == null) {
                appointment.setCreatetime(new Date());
            }

            // 设置默认状态
            if (appointment.getStatus() == null || appointment.getStatus().trim().isEmpty()) {
                appointment.setStatus("booked");
            }

            int result = mapper.insertAppointment(appointment);
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
    public boolean updateAppointmentStatus(Integer appointmentId, String status) {
        try {
            AppointmentsMapper mapper = SqlSessionUtil.getMapper(AppointmentsMapper.class);
            int result = mapper.updateAppointmentStatus(appointmentId, status);
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
    public Appointments getAppointmentById(Integer appointmentId) {
        try {
            AppointmentsMapper mapper = SqlSessionUtil.getMapper(AppointmentsMapper.class);
            return mapper.selectAppointmentById(appointmentId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public int getAppointmentCount(Integer doctorId, Date appointmentDate, String appointmentTime) {
        try {
            AppointmentsMapper mapper = SqlSessionUtil.getMapper(AppointmentsMapper.class);
            return mapper.countAppointmentsByDoctorAndDateTime(doctorId, appointmentDate, appointmentTime);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public List<Appointments> getAppointmentsByDoctorId(Integer doctorId, String status) {
        try {
            AppointmentsMapper mapper = SqlSessionUtil.getMapper(AppointmentsMapper.class);
            return mapper.selectAppointmentsByDoctorId(doctorId, status);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public boolean deleteAppointment(Integer appointmentId) {
        try {
            AppointmentsMapper mapper = SqlSessionUtil.getMapper(AppointmentsMapper.class);
            int result = mapper.deleteAppointment(appointmentId);
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
    public PageInfo<Appointments> getAppointmentsByDoctorIdAndPage(Integer doctorId, String status,
                                                                   Integer pageNum, Integer pageSize) {
        try {
            AppointmentsMapper mapper = SqlSessionUtil.getMapper(AppointmentsMapper.class);

            // 使用pageHelper进行分页
            PageHelper.startPage(pageNum, pageSize);

            // 调用mapper查询方法
            List<Appointments> appointmentsList = mapper.selectAppointmentsByDoctorId(doctorId, status);

            // 返回pageInfo对象
            return new PageInfo<>(appointmentsList);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
}