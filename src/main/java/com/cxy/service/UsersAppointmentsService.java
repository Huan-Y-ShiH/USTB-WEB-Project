package com.cxy.service;

import com.cxy.pojo.Appointments;
import com.cxy.Vo.PatientSearchVo;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/17 21:33
 */
public interface UsersAppointmentsService {
    // 查询我的门诊预约
    List<Appointments> getMyAppointments(Integer patientId);

    // 取消预约
    int cancelAppointment(Integer appointmentId);
    
    // 搜索预约（支持条件查询和分页）
    List<Appointments> searchAppointments(PatientSearchVo searchVo);
    
    // 获取预约总数
    int getAppointmentCount(PatientSearchVo searchVo);
    
    // 获取预约详情
    Appointments getAppointmentDetail(Integer appointmentId, Integer patientId);
    
    /**
     * 添加预约
     * @param patientId 患者ID
     * @param doctorId 医生ID
     * @param appointmentDate 预约日期
     * @param appointmentTime 预约时段
     * @return 是否成功
     */
    boolean addAppointment(Integer patientId, Integer doctorId, String appointmentDate, String appointmentTime);
    
    /**
     * 检查患者是否已经预约了该医生该时段
     * @param patientId 患者ID
     * @param doctorId 医生ID
     * @param appointmentDate 预约日期
     * @param appointmentTime 预约时段
     * @return 是否已预约
     */
    boolean hasExistingAppointment(Integer patientId, Integer doctorId, String appointmentDate, String appointmentTime);
    
    /**
     * 删除预约（物理删除）
     * @param appointmentId 预约ID
     * @param patientId 患者ID（用于权限验证）
     * @return 是否成功
     */
    boolean deleteAppointment(Integer appointmentId, Integer patientId);
    
    /**
     * 获取预约信息（用于删除时获取医生和时段信息）
     * @param appointmentId 预约ID
     * @param patientId 患者ID
     * @return 预约信息
     */
    Appointments getAppointmentForDelete(Integer appointmentId, Integer patientId);
}