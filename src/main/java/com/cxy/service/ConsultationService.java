package com.cxy.service;

import com.cxy.pojo.Consultation;
import com.github.pagehelper.PageInfo;

import java.util.Date;
import java.util.List;

/**
 * 咨询记录Service接口
 * @author 王知涵
 * Date  2025/1/10 23:00
 */
public interface ConsultationService {
    
    /**
     * 根据医生ID查询咨询记录
     * @param doctorId 医生ID
     * @return 咨询记录列表
     */
    List<Consultation> getConsultationsByDoctorId(Integer doctorId);
    
    /**
     * 根据医生ID分页查询咨询记录
     * @param doctorId 医生ID
     * @param pageNum 页码
     * @param pageSize 每页大小
     * @return 分页信息
     */
    PageInfo<Consultation> getConsultationsByDoctorIdAndPage(Integer doctorId, Integer pageNum, Integer pageSize);
    
    /**
     * 根据医生ID和时间范围查询咨询记录
     * @param doctorId 医生ID
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @param pageNum 页码
     * @param pageSize 每页大小
     * @return 分页信息
     */
    PageInfo<Consultation> getConsultationsByDoctorIdAndDateRange(Integer doctorId, Date startDate, Date endDate, 
                                                                 Integer pageNum, Integer pageSize);
    
    /**
     * 根据咨询ID查询咨询详情
     * @param consultationId 咨询ID
     * @return 咨询记录
     */
    Consultation getConsultationById(Integer consultationId);
    
    /**
     * 添加咨询记录
     * @param consultation 咨询记录
     * @return 是否成功
     */
    boolean addConsultation(Consultation consultation);
    
    /**
     * 更新咨询记录
     * @param consultation 咨询记录
     * @return 是否成功
     */
    boolean updateConsultation(Consultation consultation);
    
    /**
     * 根据患者ID查询咨询记录
     * @param patientId 患者ID
     * @return 咨询记录列表
     */
    List<Consultation> getConsultationsByPatientId(Integer patientId);
    
    /**
     * 根据患者ID分页查询咨询记录
     * @param patientId 患者ID
     * @param pageNum 页码
     * @param pageSize 每页大小
     * @return 分页信息
     */
    PageInfo<Consultation> getConsultationsByPatientIdAndPage(Integer patientId, Integer pageNum, Integer pageSize);
    
    /**
     * 删除咨询记录
     * @param consultationId 咨询记录ID
     * @return 是否成功
     */
    boolean deleteConsultation(Integer consultationId);
} 