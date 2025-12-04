package com.cxy.mapper;

import com.cxy.Vo.PatientSearchVo;
import com.cxy.pojo.Hospitalization;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/17 21:25
 */
public interface UsersHospitalizationMapper {
    // 查询所有可预约住院信息
    List<Hospitalization> selectAvailableHospitalizations();

    // 用户预约住院（更新patient_id和状态）
    int reserveHospitalization(@Param("hospitalizationId") Integer hospitalizationId, @Param("patientId") Integer patientId);

    // 查询我的住院信息
    List<Hospitalization> selectMyHospitalizations(@Param("patientId") Integer patientId);

    // 取消预约（将patient_id置为NULL，状态设为cancelled）
    int cancelHospitalization(@Param("hospitalizationId") Integer hospitalizationId);
    
    // 搜索住院信息（支持条件查询和分页）
    List<Hospitalization> searchHospitalizations(PatientSearchVo searchVo);
    
    // 获取住院信息总数
    int getHospitalizationCount(PatientSearchVo searchVo);
    
    // 获取住院信息详情
    Hospitalization getHospitalizationDetail(@Param("hospitalizationId") Integer hospitalizationId, @Param("patientId") Integer patientId);
}