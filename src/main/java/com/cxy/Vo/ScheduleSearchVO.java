package com.cxy.Vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;

/**
 * @author 黄江涛
 * Date  2025/7/15 16:44
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleSearchVO {
    private Integer departmentId;
    private Integer departmentPid;
    private Date date;
}
