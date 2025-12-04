package com.cxy.mapper;

import com.cxy.pojo.Patients;
import com.cxy.Vo.PatientSearchVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 患者Mapper
 * @author 王知涵
 * Date  2025/1/10 19:45
 */
public interface PatientsMapper {
    
    /**
     * 按条件查询患者信息
     * @param searchVo 搜索条件
     * @return 患者列表
     */
    List<Patients> selectPatientAll(PatientSearchVo searchVo);
    
    /**
     * 根据患者ID查询患者详情
     * @param patientId 患者ID
     * @return 患者对象
     */
    Patients selectPatientById(Integer patientId);
    
    /**
     * 根据身份证号查询患者
     * @param idCardNumber 身份证号
     * @return 患者对象
     */
    Patients selectPatientByIdCard(String idCardNumber);
    
    /**
     * 根据手机号查询患者
     * @param phone 手机号
     * @return 患者对象
     */
    Patients selectPatientByPhone(String phone);
    
    /**
     * 查询医生的患者（基于就诊记录）
     * @param doctorId 医生ID
     * @param searchVo 搜索条件
     * @return 患者列表
     */
    List<Patients> selectPatientsByDoctor(@Param("doctorId") Integer doctorId, 
                                         @Param("searchVo") PatientSearchVo searchVo);
    
    /**
     * 查询科室的患者（基于就诊记录）
     * @param departmentId 科室ID
     * @param searchVo 搜索条件
     * @return 患者列表
     */
    List<Patients> selectPatientsByDepartment(@Param("departmentId") Integer departmentId, 
                                             @Param("searchVo") PatientSearchVo searchVo);
    
    /**
     * 统计患者总数
     * @param searchVo 搜索条件
     * @return 患者总数
     */
    int countPatients(PatientSearchVo searchVo);
    
    /**
     * 统计医生的患者数
     * @param doctorId 医生ID
     * @return 患者数
     */
    int countPatientsByDoctor(Integer doctorId);

    /**
     * 修改患者密码
     * @param patientId 患者ID
     * @param newPassword 新密码
     * @return 影响行数
     */
    int updatePassword(@Param("patientId") Integer patientId, @Param("newPassword") String newPassword);

} 