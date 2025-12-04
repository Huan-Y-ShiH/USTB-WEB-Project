package com.cxy.mapper;

import com.cxy.pojo.Appointments;
import com.cxy.Vo.PatientSearchVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/17 21:35
 */
public interface UsersAppointmentMapper {
    // 查询我的门诊预约
    List<Appointments> selectMyAppointments(@Param("patientId") Integer patientId);

    // 取消预约（将appointmentStatus设为cancelled）
    int cancelAppointment(@Param("appointmentId") Integer appointmentId);
    
    // 搜索预约（支持条件查询和分页）
    List<Appointments> searchAppointments(PatientSearchVo searchVo);
    
    // 获取预约总数
    int getAppointmentCount(PatientSearchVo searchVo);
    
    // 获取预约详情
    Appointments getAppointmentDetail(@Param("appointmentId") Integer appointmentId, @Param("patientId") Integer patientId);
    
    /**
     * 添加预约
     * @param patientId 患者ID
     * @param doctorId 医生ID
     * @param appointmentDate 预约日期
     * @param appointmentTime 预约时段
     * @return 影响行数
     */
    int addAppointment(@Param("patientId") Integer patientId, @Param("doctorId") Integer doctorId, 
                      @Param("appointmentDate") String appointmentDate, @Param("appointmentTime") String appointmentTime);
    
    /**
     * 检查是否已存在预约
     * @param patientId 患者ID
     * @param doctorId 医生ID
     * @param appointmentDate 预约日期
     * @param appointmentTime 预约时段
     * @return 预约数量
     */
    int checkExistingAppointment(@Param("patientId") Integer patientId, @Param("doctorId") Integer doctorId, 
                                @Param("appointmentDate") String appointmentDate, @Param("appointmentTime") String appointmentTime);
    
    /**
     * 删除预约（物理删除）
     * @param appointmentId 预约ID
     * @param patientId 患者ID
     * @return 影响行数
     */
    int deleteAppointment(@Param("appointmentId") Integer appointmentId, @Param("patientId") Integer patientId);
    
    /**
     * 获取预约信息（用于删除时获取医生和时段信息）
     * @param appointmentId 预约ID
     * @param patientId 患者ID
     * @return 预约信息
     */
    Appointments getAppointmentForDelete(@Param("appointmentId") Integer appointmentId, @Param("patientId") Integer patientId);
}