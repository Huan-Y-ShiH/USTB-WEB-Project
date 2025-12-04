package com.cxy.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/8 15:06
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Departments {
    private Integer departmentId;
    private String departmentName;
    private Integer departmentPid;
    private Integer departmentLevel;
    private String departmentPath;
    private String departmentDescription;

    private List<Departments> childList;
}
