package com.cxy.service;

import com.cxy.pojo.DoctorSchedule;

import java.util.Date;
import java.util.List;

/**
 * 医生排班Service
 * @author 王知涵
 * Date  2025/1/10 18:20
 */
public interface DoctorScheduleService {
    
    /**
     * 查询科室排班信息
     * @param departmentId 科室ID
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 排班列表
     */
    List<DoctorSchedule> getScheduleByDepartment(Integer departmentId, Date startDate, Date endDate);
    
    /**
     * 查询医生个人排班信息
     * @param doctorId 医生ID
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 排班列表
     */
    List<DoctorSchedule> getScheduleByDoctor(Integer doctorId, Date startDate, Date endDate);
    
    /**
     * 查询科室在指定日期的排班
     * @param departmentId 科室ID
     * @param date 日期
     * @return 排班列表
     */
    List<DoctorSchedule> getScheduleByDepartmentAndDate(Integer departmentId, Date date);
    
    /**
     * 查询科室本周排班信息
     * @param departmentId 科室ID
     * @return 排班列表
     */
    List<DoctorSchedule> getThisWeekScheduleByDepartment(Integer departmentId);
    
    /**
     * 查询科室下周排班信息
     * @param departmentId 科室ID
     * @return 排班列表
     */
    List<DoctorSchedule> getNextWeekScheduleByDepartment(Integer departmentId);
} 