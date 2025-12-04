package com.cxy.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 预约实体类
 * @author 王知涵
 * Date  2025/1/10 21:00
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Appointments {
    //appointment_id 预约ID
    private Integer appointmentId;
    
    //patient_id 患者ID
    private Integer patientId;
    
    //doctor_id 医生ID
    private Integer doctorId;
    
    //appointment_date 预约日期
    private Date appointmentDate;
    
    //appointment_time 预约时间段（上午/下午）
    private String appointmentTime;
    
    //status 预约状态（booked已预约/cancelled已取消/completed已完成）
    private String status;
    
    //createtime 创建时间
    private Date createtime;
    
    //关联查询字段
    private Patients patient; //患者信息
    private Doctors doctor; //医生信息
    private Departments department; //科室信息（通过医生关联）
} 