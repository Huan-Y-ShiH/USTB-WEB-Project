package com.cxy.service;

import com.cxy.Vo.PatientSearchVo;
import com.cxy.pojo.Hospitalization;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/17 21:27
 */
public interface UsersHospitalizationService {
    // 查询所有可预约住院信息
    List<Hospitalization> getAvailableHospitalizations();

    // 用户预约住院
    int reserveHospitalization(Integer hospitalizationId, Integer patientId);

    // 查询我的住院信息
    List<Hospitalization> getMyHospitalizations(Integer patientId);

    // 取消预约
    int cancelHospitalization(Integer hospitalizationId);
    
    // 搜索住院信息（支持条件查询和分页）
    List<Hospitalization> searchHospitalizations(PatientSearchVo searchVo);
    
    // 获取住院信息总数
    int getHospitalizationCount(PatientSearchVo searchVo);
    
    // 获取住院信息详情
    Hospitalization getHospitalizationDetail(Integer hospitalizationId, Integer patientId);
}