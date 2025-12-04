package com.cxy.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @author 黄江涛
 * Date  2025/7/15 15:53
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Schedule {
    private Integer scheduleId;
    private Integer doctorId;
    private Date date;
    private String shiftTime;
    private Integer departmentId;
    private Boolean isAvailable;
    private Integer visitCount;
    private Integer sumCount;
    private String remarks;
    private Doctors doctors;
    private Departments departments;
}
