package com.cxy.mapper;

import com.cxy.Vo.ScheduleSearchVO;
import com.cxy.pojo.Schedule;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * @author 黄江涛
 * Date  2025/7/15 16:06
 */
public interface ScheduleMapper {
    List<Schedule> selectScheduleAll(ScheduleSearchVO searchVO);

    void delSchedule(Integer scheduleId);

    List<Schedule> selectScheduleByParentId(ScheduleSearchVO searchVO);

    void addSchedule(Schedule schedule);

    List<String> selectBookedShiftTimes(@Param("doctorId") Integer doctorId, @Param("date") Date date);

    void delScheduleByDoctorId(Integer doctorId);

    void delSchedulesByDoctorIds(List<Integer> doctorIds);

    /**
     * 根据医生ID、日期和时段查询排班信息
     * @param doctorId 医生ID
     * @param date 日期
     * @param shiftTime 时段
     * @return 排班信息
     */
    Schedule selectScheduleByDoctorAndTime(@Param("doctorId") Integer doctorId, @Param("date") Date date, @Param("shiftTime") String shiftTime);
    
    /**
     * 增加预约人数
     * @param doctorId 医生ID
     * @param date 日期
     * @param shiftTime 时段
     * @return 影响行数
     */
    int increaseVisitCount(@Param("doctorId") Integer doctorId, @Param("date") Date date, @Param("shiftTime") String shiftTime);
    
    /**
     * 减少预约人数
     * @param doctorId 医生ID
     * @param date 日期
     * @param shiftTime 时段
     * @return 影响行数
     */
    int decreaseVisitCount(@Param("doctorId") Integer doctorId, @Param("date") Date date, @Param("shiftTime") String shiftTime);
}
