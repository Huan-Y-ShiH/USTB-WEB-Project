package com.cxy.service;

import com.cxy.Vo.PatientSearchVo;
import com.cxy.pojo.Patients;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * 患者管理Service
 * @author 王知涵
 * Date  2025/1/10 19:55
 */
public interface PatientsService {
    
    /**
     * 按条件查询患者信息
     * @param searchVo 搜索条件
     * @return 患者列表
     */
    List<Patients> getPatientAll(PatientSearchVo searchVo);
    
    /**
     * 按条件分页查询患者信息
     * @param searchVo 搜索条件
     * @param pageNum 当前页码
     * @param pageSize 每页显示条数
     * @return 分页信息对象
     */
    PageInfo<Patients> getPatientsByPageAndSearch(PatientSearchVo searchVo, Integer pageNum, Integer pageSize);
    
    /**
     * 根据患者ID查询患者详情
     * @param patientId 患者ID
     * @return 患者对象
     */
    Patients getPatientById(Integer patientId);
    
    /**
     * 根据身份证号查询患者
     * @param idCardNumber 身份证号
     * @return 患者对象
     */
    Patients getPatientByIdCard(String idCardNumber);
    
    /**
     * 根据手机号查询患者
     * @param phone 手机号
     * @return 患者对象
     */
    Patients getPatientByPhone(String phone);
    
    /**
     * 查询医生的患者（基于就诊记录）
     * @param doctorId 医生ID
     * @param searchVo 搜索条件
     * @return 患者列表
     */
    List<Patients> getPatientsByDoctor(Integer doctorId, PatientSearchVo searchVo);
    
    /**
     * 分页查询医生的患者
     * @param doctorId 医生ID
     * @param searchVo 搜索条件
     * @param pageNum 当前页码
     * @param pageSize 每页显示条数
     * @return 分页信息对象
     */
    PageInfo<Patients> getPatientsByDoctorAndPage(Integer doctorId, PatientSearchVo searchVo, Integer pageNum, Integer pageSize);
    
    /**
     * 查询科室的患者（基于就诊记录）
     * @param departmentId 科室ID
     * @param searchVo 搜索条件
     * @return 患者列表
     */
    List<Patients> getPatientsByDepartment(Integer departmentId, PatientSearchVo searchVo);
    
    /**
     * 分页查询科室的患者
     * @param departmentId 科室ID
     * @param searchVo 搜索条件
     * @param pageNum 当前页码
     * @param pageSize 每页显示条数
     * @return 分页信息对象
     */
    PageInfo<Patients> getPatientsByDepartmentAndPage(Integer departmentId, PatientSearchVo searchVo, Integer pageNum, Integer pageSize);
    
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
     * @return 是否修改成功
     */
    boolean updatePassword(Integer patientId, String newPassword);

} 