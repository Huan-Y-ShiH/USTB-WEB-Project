package com.cxy.service.impl;

import com.cxy.mapper.DoctorScheduleMapper;
import com.cxy.pojo.DoctorSchedule;
import com.cxy.service.DoctorScheduleService;
import com.cxy.util.SqlSessionUtil;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 医生排班Service实现类
 * @author 王知涵
 * Date  2025/1/10 18:30
 */
public class DoctorScheduleServiceImpl implements DoctorScheduleService {
    
    @Override
    public List<DoctorSchedule> getScheduleByDepartment(Integer departmentId, Date startDate, Date endDate) {
        try {
            DoctorScheduleMapper mapper = SqlSessionUtil.getMapper(DoctorScheduleMapper.class);
            return mapper.selectScheduleByDepartment(departmentId, startDate, endDate);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public List<DoctorSchedule> getScheduleByDoctor(Integer doctorId, Date startDate, Date endDate) {
        try {
            DoctorScheduleMapper mapper = SqlSessionUtil.getMapper(DoctorScheduleMapper.class);
            return mapper.selectScheduleByDoctor(doctorId, startDate, endDate);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public List<DoctorSchedule> getScheduleByDepartmentAndDate(Integer departmentId, Date date) {
        try {
            DoctorScheduleMapper mapper = SqlSessionUtil.getMapper(DoctorScheduleMapper.class);
            return mapper.selectScheduleByDepartmentAndDate(departmentId, date);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
    
    @Override
    public List<DoctorSchedule> getThisWeekScheduleByDepartment(Integer departmentId) {
        Calendar cal = Calendar.getInstance();
        
        // 获取本周一
        cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        Date startDate = cal.getTime();
        
        // 获取本周日
        cal.add(Calendar.DAY_OF_WEEK, 6);
        Date endDate = cal.getTime();
        
        return getScheduleByDepartment(departmentId, startDate, endDate);
    }
    
    @Override
    public List<DoctorSchedule> getNextWeekScheduleByDepartment(Integer departmentId) {
        Calendar cal = Calendar.getInstance();
        
        // 获取下周一
        cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        cal.add(Calendar.WEEK_OF_YEAR, 1);
        Date startDate = cal.getTime();
        
        // 获取下周日
        cal.add(Calendar.DAY_OF_WEEK, 6);
        Date endDate = cal.getTime();
        
        return getScheduleByDepartment(departmentId, startDate, endDate);
    }
} 