package com.cxy.mapper;

import com.cxy.pojo.Hospitalization;

import java.util.List;

/**
 * 住院记录Mapper接口
 * @author 王知涵
 * Date  2025/1/11 10:00
 */
public interface HospitalizationMapper {
    
    /**
     * 根据患者ID查询住院记录
     * @param patientId 患者ID
     * @return 住院记录列表
     */
    List<Hospitalization> selectHospitalizationsByPatientId(Integer patientId);
    
    /**
     * 根据住院ID查询住院记录详情
     * @param hospitalizationId 住院ID
     * @return 住院记录
     */
    Hospitalization selectHospitalizationById(Integer hospitalizationId);
    
    /**
     * 添加住院记录
     * @param hospitalization 住院记录
     * @return 影响行数
     */
    int insertHospitalization(Hospitalization hospitalization);
    
    /**
     * 更新住院记录
     * @param hospitalization 住院记录
     * @return 影响行数
     */
    int updateHospitalization(Hospitalization hospitalization);
    
    /**
     * 删除住院记录
     * @param hospitalizationId 住院ID
     * @return 影响行数
     */
    int deleteHospitalization(Integer hospitalizationId);
    
    /**
     * 获取当前最大的住院记录ID
     * @return 最大ID
     */
    Integer getMaxHospitalizationId();
    
    /**
     * 根据医生ID查询其负责的住院记录
     * @param doctorId 医生ID
     * @return 住院记录列表
     */
    List<Hospitalization> selectHospitalizationsByDoctorId(Integer doctorId);
    
    /**
     * 根据住院状态查询记录
     * @param status 住院状态
     * @return 住院记录列表
     */
    List<Hospitalization> selectHospitalizationsByStatus(String status);
} 