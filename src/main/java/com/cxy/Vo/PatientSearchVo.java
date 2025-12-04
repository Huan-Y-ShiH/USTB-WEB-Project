package com.cxy.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 患者搜索条件VO
 * @author 王知涵
 * Date  2025/1/10 19:35
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PatientSearchVo {
    
    //患者姓名
    private String patientName;
    
    //身份证号
    private String idCardNumber;
    
    //联系电话
    private String phone;
    
    //性别
    private String gender;
    
    //年龄范围
    private Integer minAge;
    private Integer maxAge;
    
    //余额范围
    private Double minBalance;
    private Double maxBalance;

    // 预约搜索相关字段
    private Integer patientId; // 患者ID
    private String startDate; // 开始日期
    private String endDate; // 结束日期
    private String status; // 预约状态
    private String doctorName; // 医生姓名
    private String departmentName; // 科室名称

    // 住院信息搜索相关字段
    private String roomNumber; // 房间号
    private String hospitalizationStatus; // 住院状态
    private String paymentStatus; // 支付状态
    private String isInsured; // 医保状态
    private String minCost; // 最小费用
    private String maxCost; // 最大费用

    // 分页参数
    private Integer page = 1; // 当前页码
    private Integer size = 10; // 每页大小

    // 计算偏移量
    public Integer getOffset() {
        return (page - 1) * size;
    }
} 