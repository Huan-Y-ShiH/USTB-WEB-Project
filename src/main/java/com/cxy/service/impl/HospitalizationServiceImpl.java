package com.cxy.service.impl;

import com.cxy.mapper.ConsultationMapper;
import com.cxy.mapper.HospitalizationMapper;
import com.cxy.pojo.Consultation;
import com.cxy.pojo.Hospitalization;
import com.cxy.service.HospitalizationService;
import com.cxy.util.SqlSessionUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.util.Collections;
import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/17 16:04
 */
public class HospitalizationServiceImpl implements HospitalizationService {
    @Override
    public List<Hospitalization> getHospitalizationsByPatientId(Integer patientId) {
        try {
            HospitalizationMapper mapper = SqlSessionUtil.getMapper(HospitalizationMapper.class);
            return mapper.selectHospitalizationsByPatientId(patientId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public PageInfo<Hospitalization> getHospitalizationsByPatientIdAndPage(Integer patientId, Integer pageNum, Integer pageSize) {
        try {
            HospitalizationMapper mapper = SqlSessionUtil.getMapper(HospitalizationMapper.class);

            // 使用pageHelper进行分页
            PageHelper.startPage(pageNum, pageSize);

            // 调用mapper查询方法
            List<Hospitalization> hospitalizationsList = mapper.selectHospitalizationsByPatientId(patientId);

            // 返回pageInfo对象
            return new PageInfo<>(hospitalizationsList);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public Hospitalization getHospitalizationById(Integer hospitalizationId) {
        try {
            HospitalizationMapper mapper = SqlSessionUtil.getMapper(HospitalizationMapper.class);
            return mapper.selectHospitalizationById(hospitalizationId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public boolean addHospitalization(Hospitalization hospitalization) {
        try {
            HospitalizationMapper mapper = SqlSessionUtil.getMapper(HospitalizationMapper.class);

            // 如果没有设置hospitalizationId，生成一个新的ID
            if (hospitalization.getHospitalizationId() == null) {
                // 获取当前最大ID并+1
                Integer maxId = mapper.getMaxHospitalizationId();
                hospitalization.setHospitalizationId(maxId + 1);
            }

            int result = mapper.insertHospitalization(hospitalization);
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
    public boolean updateHospitalization(Hospitalization hospitalization) {
        try {
            HospitalizationMapper mapper = SqlSessionUtil.getMapper(HospitalizationMapper.class);
            int result = mapper.updateHospitalization(hospitalization);
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
    public boolean deleteHospitalization(Integer hospitalizationId) {
        try {
            HospitalizationMapper mapper = SqlSessionUtil.getMapper(HospitalizationMapper.class);
            int result = mapper.deleteHospitalization(hospitalizationId);
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
    public List<Hospitalization> getHospitalizationsByDoctorId(Integer doctorId) {
        try {
            HospitalizationMapper mapper = SqlSessionUtil.getMapper(HospitalizationMapper.class);
            return mapper.selectHospitalizationsByDoctorId(doctorId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public List<Hospitalization> getHospitalizationsByStatus(String status) {
        try {
            HospitalizationMapper mapper = SqlSessionUtil.getMapper(HospitalizationMapper.class);
            return mapper.selectHospitalizationsByStatus(status);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public boolean updateHospitalizationStatusAndSyncConsultation(Integer hospitalizationId, String newStatus) {
        try {
            HospitalizationMapper hospitalizationMapper = SqlSessionUtil.getMapper(HospitalizationMapper.class);
            ConsultationMapper consultationMapper = SqlSessionUtil.getMapper(ConsultationMapper.class);

            // 获取住院记录
            Hospitalization hospitalization = hospitalizationMapper.selectHospitalizationById(hospitalizationId);
            if (hospitalization == null) {
                return false;
            }

            // 更新住院状态
            hospitalization.setHospitalizationStatus(newStatus);
            int result1 = hospitalizationMapper.updateHospitalization(hospitalization);

            // 根据住院状态更新咨询记录中的住院状态
            boolean isHospitalized = "admitted".equals(newStatus) || "in_progress".equals(newStatus);

            // 获取该患者的所有咨询记录并更新住院状态
            List<Consultation> consultations = consultationMapper.selectConsultationsByPatientId(hospitalization.getPatientId());
            int result2 = 0;
            for (Consultation consultation : consultations) {
                consultation.setIsHospitalized(isHospitalized);
                result2 += consultationMapper.updateConsultation(consultation);
            }

            SqlSessionUtil.commit();
            return result1 > 0;
        } catch (Exception e) {
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
}