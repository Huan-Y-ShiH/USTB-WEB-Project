package com.cxy.mapper;

import com.cxy.pojo.Appointments;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * 预约Mapper接口
 * @author 王知涵
 * Date  2025/1/10 21:00
 */
public interface AppointmentsMapper {
    
    /**
     * 查询所有预约信息（支持条件查询）
     * @param patientName 患者姓名
     * @param doctorName 医生姓名
     * @param status 预约状态
     * @param appointmentDate 预约日期
     * @return 预约列表
     */
    List<Appointments> selectAllAppointments(@Param("patientName") String patientName,
                                           @Param("doctorName") String doctorName,
                                           @Param("status") String status,
                                           @Param("appointmentDate") Date appointmentDate);
    
    /**
     * 添加预约
     * @param appointment 预约信息
     * @return 添加结果
     */
    int insertAppointment(Appointments appointment);
    
    /**
     * 更新预约状态
     * @param appointmentId 预约ID
     * @param status 新状态
     * @return 更新结果
     */
    int updateAppointmentStatus(@Param("appointmentId") Integer appointmentId, 
                               @Param("status") String status);
    
    /**
     * 根据预约ID查询预约详情
     * @param appointmentId 预约ID
     * @return 预约信息
     */
    Appointments selectAppointmentById(Integer appointmentId);
    
    /**
     * 查询指定医生和日期的预约数量
     * @param doctorId 医生ID
     * @param appointmentDate 预约日期
     * @param appointmentTime 预约时间段
     * @return 预约数量
     */
    int countAppointmentsByDoctorAndDateTime(@Param("doctorId") Integer doctorId,
                                           @Param("appointmentDate") Date appointmentDate,
                                           @Param("appointmentTime") String appointmentTime);
    
    /**
     * 查询指定医生的预约信息
     * @param doctorId 医生ID
     * @param status 预约状态（可选）
     * @return 预约列表
     */
    List<Appointments> selectAppointmentsByDoctorId(@Param("doctorId") Integer doctorId,
                                                   @Param("status") String status);

    int deleteAppointment(@Param("appointmentId") Integer appointmentId);
} 