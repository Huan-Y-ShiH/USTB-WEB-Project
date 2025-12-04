package com.cxy.mapper;

import com.cxy.pojo.DoctorSchedule;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * 医生排班Mapper
 * @author 王知涵
 * Date  2025/1/10 18:10
 */
public interface DoctorScheduleMapper {
    
    /**
     * 查询科室排班信息
     * @param departmentId 科室ID
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 排班列表
     */
    List<DoctorSchedule> selectScheduleByDepartment(@Param("departmentId") Integer departmentId,
                                                   @Param("startDate") Date startDate,
                                                   @Param("endDate") Date endDate);
    
    /**
     * 查询医生个人排班信息
     * @param doctorId 医生ID
     * @param startDate 开始日期
     * @param endDate 结束日期
     * @return 排班列表
     */
    List<DoctorSchedule> selectScheduleByDoctor(@Param("doctorId") Integer doctorId,
                                                @Param("startDate") Date startDate,
                                                @Param("endDate") Date endDate);
    
    /**
     * 查询科室在指定日期的排班
     * @param departmentId 科室ID
     * @param date 日期
     * @return 排班列表
     */
    List<DoctorSchedule> selectScheduleByDepartmentAndDate(@Param("departmentId") Integer departmentId,
                                                          @Param("date") Date date);
} 