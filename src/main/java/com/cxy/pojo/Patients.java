package com.cxy.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 患者实体类
 * @author 王知涵
 * Date  2025/1/10 19:30
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Patients {
    //patient_id
    private Integer patientId;
    
    //id_card_number 身份证号
    private String idCardNumber;
    
    //password 密码
    private String password;
    
    //pname 患者姓名
    private String pname;
    
    //avatar 头像
    private String avatar;
    
    //phone 联系电话
    private String phone;
    
    //email 邮箱
    private String email;
    
    //balance 账户余额
    private Double balance;
    
    //registration_date 注册日期（可能不在原表中，作为扩展字段）
    private Date registrationDate;
    
    //gender 性别（扩展字段）
    private String gender;
    
    //age 年龄（扩展字段）
    private Integer age;
    
    //address 地址（扩展字段）
    private String address;
    
    //emergency_contact 紧急联系人（扩展字段）
    private String emergencyContact;
    
    //emergency_phone 紧急联系电话（扩展字段）
    private String emergencyPhone;
} 