package com.cxy.service.impl;

import com.cxy.Vo.ScheduleSearchVO;
import com.cxy.mapper.ScheduleMapper;
import com.cxy.pojo.Schedule;
import com.cxy.service.ScheduleService;
import com.cxy.util.SqlSessionUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/17 16:22
 */
public class ScheduleServiceImpl implements ScheduleService {
    @Override
    public PageInfo<Schedule> getScheduleBySearchAndPage(ScheduleSearchVO searchVO, Integer pageNum, Integer pageSize) {
        try {
            ScheduleMapper mapper = SqlSessionUtil.getMapper(ScheduleMapper.class);
            if (searchVO.getDepartmentPid()!=0){
                PageHelper.startPage(pageNum,pageSize);
                List<Schedule> scheduleList = mapper.selectScheduleAll(searchVO);
                PageInfo<Schedule> pageInfo = new PageInfo<>(scheduleList);
                return pageInfo;
            }else {
                PageHelper.startPage(pageNum,pageSize);
                List<Schedule> scheduleList = mapper.selectScheduleByParentId(searchVO);
                PageInfo<Schedule> pageInfo = new PageInfo<>(scheduleList);
                return pageInfo;
            }
        }catch (Exception e){
            throw new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }
    @Override
    public void delSchedule(Integer scheduleId){
        try {
            ScheduleMapper mapper = SqlSessionUtil.getMapper(ScheduleMapper.class);
            mapper.delSchedule(scheduleId);
            SqlSessionUtil.commit();
        }catch (Exception e){
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }
    @Override
    public void addSchedule(Schedule schedule){
        try {
            ScheduleMapper mapper = SqlSessionUtil.getMapper(ScheduleMapper.class);
            mapper.addSchedule(schedule);
            SqlSessionUtil.commit();
        }catch (Exception e){
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }
    @Override
    public List<String> getBookedShiftTimes(Integer doctorId, Date date) {
        try {
            ScheduleMapper mapper = SqlSessionUtil.getMapper(ScheduleMapper.class);
            return mapper.selectBookedShiftTimes(doctorId, date);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public void delScheduleByDoctorId(Integer doctorId) {
        try {
            ScheduleMapper mapper = SqlSessionUtil.getMapper(ScheduleMapper.class);
            mapper.delScheduleByDoctorId(doctorId);
            SqlSessionUtil.commit();
        }catch (Exception e){
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public void delSchedulesByDoctorIds(List<Integer> doctorIds){
        try {
            ScheduleMapper mapper = SqlSessionUtil.getMapper(ScheduleMapper.class);
            mapper.delSchedulesByDoctorIds(doctorIds);
            SqlSessionUtil.commit();
        }catch (Exception e){
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public boolean canBookAppointment(Integer doctorId, Date date, String shiftTime) {
        try {
            ScheduleMapper mapper = SqlSessionUtil.getMapper(ScheduleMapper.class);
            Schedule schedule = mapper.selectScheduleByDoctorAndTime(doctorId, date, shiftTime);
            
            if (schedule == null) {
                return false; // 没有排班
            }
            
            if (!schedule.getIsAvailable()) {
                return false; // 排班不可用
            }
            
            // 检查预约人数是否已满
            if (schedule.getVisitCount() >= schedule.getSumCount()) {
                return false; // 预约人数已满
            }
            
            return true;
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public Schedule getScheduleByDoctorAndTime(Integer doctorId, Date date, String shiftTime) {
        try {
            ScheduleMapper mapper = SqlSessionUtil.getMapper(ScheduleMapper.class);
            return mapper.selectScheduleByDoctorAndTime(doctorId, date, shiftTime);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public boolean increaseVisitCount(Integer doctorId, Date date, String shiftTime) {
        try {
            ScheduleMapper mapper = SqlSessionUtil.getMapper(ScheduleMapper.class);
            int result = mapper.increaseVisitCount(doctorId, date, shiftTime);
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
    public boolean decreaseVisitCount(Integer doctorId, Date date, String shiftTime) {
        try {
            ScheduleMapper mapper = SqlSessionUtil.getMapper(ScheduleMapper.class);
            int result = mapper.decreaseVisitCount(doctorId, date, shiftTime);
            SqlSessionUtil.commit();
            return result > 0;
        } catch (Exception e) {
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
}
