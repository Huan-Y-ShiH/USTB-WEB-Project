package com.cxy.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 咨询记录实体类
 * @author 王知涵
 * Date  2025/1/10 19:40
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Consultation {
    // consultation_id 咨询记录ID
    private Integer consultationId;
    
    // patient_id 患者ID
    private Integer patientId;
    
    // doctor_id 医生ID
    private Integer doctorId;
    
    // consultation_time 咨询时间
    private Date consultationTime;
    
    // is_hospital_registered 是否医院注册
    private Boolean isHospitalRegistered;
    
    // is_hospitalized 是否住院
    private Boolean isHospitalized;
    
    // medical_advice_case 医疗建议情况
    private String medicalAdviceCase;
    
    // 关联查询字段
    private Patients patient; // 患者信息
    private Doctors doctor; // 医生信息
} 