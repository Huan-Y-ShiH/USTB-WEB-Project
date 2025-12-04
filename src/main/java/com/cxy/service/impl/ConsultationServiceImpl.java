package com.cxy.service.impl;

import com.cxy.mapper.ConsultationMapper;
import com.cxy.pojo.Consultation;
import com.cxy.service.ConsultationService;
import com.cxy.util.SqlSessionUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/17 13:53
 */
public class ConsultationServiceImpl implements ConsultationService {
    @Override
    public List<Consultation> getConsultationsByDoctorId(Integer doctorId) {
        try {
            ConsultationMapper mapper = SqlSessionUtil.getMapper(ConsultationMapper.class);
            return mapper.selectConsultationsByDoctorId(doctorId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public PageInfo<Consultation> getConsultationsByDoctorIdAndPage(Integer doctorId, Integer pageNum, Integer pageSize) {
        try {
            ConsultationMapper mapper = SqlSessionUtil.getMapper(ConsultationMapper.class);

            // 使用pageHelper进行分页
            PageHelper.startPage(pageNum, pageSize);

            // 调用mapper查询方法
            List<Consultation> consultationsList = mapper.selectConsultationsByDoctorId(doctorId);

            // 返回pageInfo对象
            return new PageInfo<>(consultationsList);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public PageInfo<Consultation> getConsultationsByDoctorIdAndDateRange(Integer doctorId, Date startDate, Date endDate,
                                                                         Integer pageNum, Integer pageSize) {
        try {
            ConsultationMapper mapper = SqlSessionUtil.getMapper(ConsultationMapper.class);

            // 使用pageHelper进行分页
            PageHelper.startPage(pageNum, pageSize);

            // 调用mapper查询方法
            List<Consultation> consultationsList = mapper.selectConsultationsByDoctorIdAndDate(doctorId, startDate, endDate);

            // 返回pageInfo对象
            return new PageInfo<>(consultationsList);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public Consultation getConsultationById(Integer consultationId) {
        try {
            ConsultationMapper mapper = SqlSessionUtil.getMapper(ConsultationMapper.class);
            return mapper.selectConsultationById(consultationId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public boolean addConsultation(Consultation consultation) {
        try {
            ConsultationMapper mapper = SqlSessionUtil.getMapper(ConsultationMapper.class);

            // 如果没有设置consultationId，生成一个新的ID
            if (consultation.getConsultationId() == null) {
                // 获取当前最大ID并+1
                Integer maxId = mapper.getMaxConsultationId();
                consultation.setConsultationId(maxId + 1);
            }

            // 设置咨询时间
            if (consultation.getConsultationTime() == null) {
                consultation.setConsultationTime(new Date());
            }

            int result = mapper.insertConsultation(consultation);
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
    public boolean updateConsultation(Consultation consultation) {
        try {
            ConsultationMapper mapper = SqlSessionUtil.getMapper(ConsultationMapper.class);
            int result = mapper.updateConsultation(consultation);
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
    public List<Consultation> getConsultationsByPatientId(Integer patientId) {
        try {
            ConsultationMapper mapper = SqlSessionUtil.getMapper(ConsultationMapper.class);
            return mapper.selectConsultationsByPatientId(patientId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public PageInfo<Consultation> getConsultationsByPatientIdAndPage(Integer patientId, Integer pageNum, Integer pageSize) {
        try {
            ConsultationMapper mapper = SqlSessionUtil.getMapper(ConsultationMapper.class);

            // 使用pageHelper进行分页
            PageHelper.startPage(pageNum, pageSize);

            // 调用mapper查询方法
            List<Consultation> consultationsList = mapper.selectConsultationsByPatientId(patientId);

            // 返回pageInfo对象
            return new PageInfo<>(consultationsList);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public boolean deleteConsultation(Integer consultationId) {
        try {
            ConsultationMapper mapper = SqlSessionUtil.getMapper(ConsultationMapper.class);
            int result = mapper.deleteConsultation(consultationId);
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