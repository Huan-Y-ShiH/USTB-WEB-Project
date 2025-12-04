package com.cxy.service;

import com.cxy.pojo.Hospitalization;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * 住院记录Service接口
 * @author 王知涵
 * Date  2025/1/11 10:10
 */
public interface HospitalizationService {
    
    /**
     * 根据患者ID查询住院记录
     * @param patientId 患者ID
     * @return 住院记录列表
     */
    List<Hospitalization> getHospitalizationsByPatientId(Integer patientId);
    
    /**
     * 根据患者ID分页查询住院记录
     * @param patientId 患者ID
     * @param pageNum 页码
     * @param pageSize 每页大小
     * @return 分页信息
     */
    PageInfo<Hospitalization> getHospitalizationsByPatientIdAndPage(Integer patientId, Integer pageNum, Integer pageSize);
    
    /**
     * 根据住院ID查询住院记录详情
     * @param hospitalizationId 住院ID
     * @return 住院记录
     */
    Hospitalization getHospitalizationById(Integer hospitalizationId);
    
    /**
     * 添加住院记录
     * @param hospitalization 住院记录
     * @return 是否成功
     */
    boolean addHospitalization(Hospitalization hospitalization);
    
    /**
     * 更新住院记录
     * @param hospitalization 住院记录
     * @return 是否成功
     */
    boolean updateHospitalization(Hospitalization hospitalization);
    
    /**
     * 删除住院记录
     * @param hospitalizationId 住院ID
     * @return 是否成功
     */
    boolean deleteHospitalization(Integer hospitalizationId);
    
    /**
     * 根据医生ID查询其负责的住院记录
     * @param doctorId 医生ID
     * @return 住院记录列表
     */
    List<Hospitalization> getHospitalizationsByDoctorId(Integer doctorId);
    
    /**
     * 根据住院状态查询记录
     * @param status 住院状态
     * @return 住院记录列表
     */
    List<Hospitalization> getHospitalizationsByStatus(String status);
    
    /**
     * 更新住院状态并同步更新咨询记录中的住院状态
     * @param hospitalizationId 住院ID
     * @param newStatus 新状态
     * @return 是否成功
     */
    boolean updateHospitalizationStatusAndSyncConsultation(Integer hospitalizationId, String newStatus);
} 