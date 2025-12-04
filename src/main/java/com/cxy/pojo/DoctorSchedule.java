package com.cxy.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 医生排班实体类
 * @author 王知涵
 * Date  2025/1/10 18:00
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class DoctorSchedule {
    //schedule_id
    private Integer scheduleId;
    
    //doctor_id
    private Integer doctorId;
    
    //date
    private Date date;
    
    //shift_time
    private String shiftTime;
    
    //department_id
    private Integer departmentId;
    
    //is_available
    private Integer isAvailable;
    
    //visit_count
    private Integer visitCount;
    
    //sum_count
    private Integer sumCount;
    
    //remarks
    private String remarks;
    
    //关联查询条件变量
    private Doctors doctor; //医生信息
    private Departments department; //科室信息
} 