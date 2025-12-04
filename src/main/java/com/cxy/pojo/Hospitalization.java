package com.cxy.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

/**
 * 住院记录实体类
 * @author 王知涵
 * Date  2025/1/10 20:00
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Hospitalization {
    // hospitalization_id 住院记录ID (主键)
    private Integer hospitalizationId;
    
    // patient_id 患者ID
    private Integer patientId;
    
    // room_number 房间号 (varchar 255)
    private String roomNumber;
    
    // cost 费用 (decimal 10,2)
    private BigDecimal cost;
    
    // payment_status 支付状态 (enum: 已支付、未支付、部分支付)
    private String paymentStatus;
    
    // is_insured 是否有保险 (tinyint 1: 0-无保险, 1-有保险)
    private Boolean isInsured;
    
    // hospitalization_status 住院状态 (enum: 已入院、已出院、进行中)
    private String hospitalizationStatus;
    
    // 关联查询字段
    private Patients patient; // 患者信息
} 