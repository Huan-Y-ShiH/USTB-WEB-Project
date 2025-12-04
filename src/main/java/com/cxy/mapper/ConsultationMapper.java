package com.cxy.mapper;

import com.cxy.pojo.Consultation;
import org.apache.ibatis.annotations.Param;
import java.util.Date;
import java.util.List;

/**
 * 咨询记录Mapper接口
 * @author 王知涵
 * Date  2025/1/10 23:00
 */
public interface ConsultationMapper {
    
    /**
     * 根据医生ID查询咨询记录
     * @param doctorId 医生ID
     * @return 咨询记录列表
     */
    List<Consultation> selectConsultationsByDoctorId(Integer doctorId);
    
    /**
     * 根据医生ID分页查询咨询记录
     * @param doctorId 医生ID
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @return 咨询记录列表
     */
    List<Consultation> selectConsultationsByDoctorIdAndDate(@Param("doctorId") Integer doctorId,
                                                           @Param("startDate") Date startDate,
                                                           @Param("endDate") Date endDate);
    
    /**
     * 根据咨询ID查询咨询详情
     * @param consultationId 咨询ID
     * @return 咨询记录
     */
    Consultation selectConsultationById(Integer consultationId);
    
    /**
     * 添加咨询记录
     * @param consultation 咨询记录
     * @return 影响行数
     */
    int insertConsultation(Consultation consultation);
    
    /**
     * 更新咨询记录
     * @param consultation 咨询记录
     * @return 影响行数
     */
    int updateConsultation(Consultation consultation);
    
    /**
     * 根据患者ID查询咨询记录
     * @param patientId 患者ID
     * @return 咨询记录列表
     */
    List<Consultation> selectConsultationsByPatientId(Integer patientId);
    
    /**
     * 删除咨询记录
     * @param consultationId 咨询记录ID
     * @return 影响行数
     */
    int deleteConsultation(Integer consultationId);
    
    /**
     * 获取当前最大的咨询记录ID
     * @return 最大ID
     */
    Integer getMaxConsultationId();
} 