package com.cxy.service;

import com.cxy.pojo.Appointments;
import com.github.pagehelper.PageInfo;

import java.util.Date;
import java.util.List;

/**
 * 预约管理service接口
 * @author 王知涵
 * Date  2025/1/10 21:00
 */
public interface AppointmentsService {
    
    /**
     * 查询所有预约信息（支持条件查询）
     * @param patientName 患者姓名
     * @param doctorName 医生姓名
     * @param status 预约状态
     * @param appointmentDate 预约日期
     * @return 预约列表
     */
    List<Appointments> selectAllAppointments(String patientName, String doctorName,
                                             String status, Date appointmentDate);
    
    /**
     * 分页查询预约信息（支持条件查询）
     * @param patientName 患者姓名
     * @param doctorName 医生姓名
     * @param status 预约状态
     * @param appointmentDate 预约日期
     * @param pageNum 当前页码
     * @param pageSize 每页大小
     * @return 分页信息
     */
    PageInfo<Appointments> getAppointmentsByPageAndSearch(String patientName, String doctorName, 
                                                         String status, Date appointmentDate,
                                                         Integer pageNum, Integer pageSize);
    
    /**
     * 添加预约（包括临时加号）
     * @param appointment 预约信息
     * @return 添加结果
     */
    int addAppointment(Appointments appointment);
    
    /**
     * 更新预约状态
     * @param appointmentId 预约ID
     * @param status 新状态
     * @return 更新结果
     */
    boolean updateAppointmentStatus(Integer appointmentId, String status);
    
    /**
     * 根据ID查询预约详情
     * @param appointmentId 预约ID
     * @return 预约信息
     */
    Appointments getAppointmentById(Integer appointmentId);
    
    /**
     * 检查指定医生和日期时间的预约数量（用于临时加号判断）
     * @param doctorId 医生ID
     * @param appointmentDate 预约日期
     * @param appointmentTime 预约时间段
     * @return 预约数量
     */
    int getAppointmentCount(Integer doctorId, Date appointmentDate, String appointmentTime);
    
    /**
     * 查询指定医生的预约信息（用于医生端查看自己的预约）
     * @param doctorId 医生ID
     * @param status 预约状态（可选）
     * @return 预约列表
     */
    List<Appointments> getAppointmentsByDoctorId(Integer doctorId, String status);
    
    /**
     * 分页查询指定医生的预约信息
     * @param doctorId 医生ID
     * @param status 预约状态（可选）
     * @param pageNum 当前页码
     * @param pageSize 每页大小
     * @return 分页信息
     */
    PageInfo<Appointments> getAppointmentsByDoctorIdAndPage(Integer doctorId, String status, 
                                                           Integer pageNum, Integer pageSize);

    boolean deleteAppointment(Integer appointmentId);
} 