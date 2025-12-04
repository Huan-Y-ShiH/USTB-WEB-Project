package com.cxy.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 陈翔宇
 * Date  2025/7/9 15:37
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class DoctorSearchVo {
    private Integer departmentId;
    private Integer titleId;
    private String doctorName;
    private String jobNumber;
}
