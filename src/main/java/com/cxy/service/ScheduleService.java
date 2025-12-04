package com.cxy.service;

import com.cxy.Vo.ScheduleSearchVO;
import com.cxy.pojo.Schedule;
import com.github.pagehelper.PageInfo;

import java.util.Date;
import java.util.List;

/**
 * @author 黄江涛
 * Date  2025/7/16 12:49
 */
public interface ScheduleService {
    PageInfo<Schedule> getScheduleBySearchAndPage(ScheduleSearchVO searchVO, Integer pageNum, Integer pageSize);

    void delSchedule(Integer scheduleId);

    void addSchedule(Schedule schedule);

    List<String> getBookedShiftTimes(Integer doctorId, Date date);

    void delScheduleByDoctorId(Integer doctorId);

    void delSchedulesByDoctorIds(List<Integer> doctorIds);

    /**
     * 检查医生在指定日期和时段是否有排班且可预约
     * @param doctorId 医生ID
     * @param date 日期
     * @param shiftTime 时段（上午/下午）
     * @return 是否可以预约
     */
    boolean canBookAppointment(Integer doctorId, Date date, String shiftTime);

    /**
     * 获取医生在指定日期和时段的排班信息
     * @param doctorId 医生ID
     * @param date 日期
     * @param shiftTime 时段（上午/下午）
     * @return 排班信息
     */
    Schedule getScheduleByDoctorAndTime(Integer doctorId, Date date, String shiftTime);
    
    /**
     * 增加预约人数（预约成功后调用）
     * @param doctorId 医生ID
     * @param date 日期
     * @param shiftTime 时段
     * @return 是否成功
     */
    boolean increaseVisitCount(Integer doctorId, Date date, String shiftTime);
    
    /**
     * 减少预约人数（取消预约后调用）
     * @param doctorId 医生ID
     * @param date 日期
     * @param shiftTime 时段
     * @return 是否成功
     */
    boolean decreaseVisitCount(Integer doctorId, Date date, String shiftTime);
}
