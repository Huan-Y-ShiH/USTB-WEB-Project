package com.cxy.service;

import com.cxy.pojo.Departments;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/8 16:31
 */

public interface DepartmentsService {

    PageInfo<Departments> getDepartments(Integer pageNum, Integer pageSize);

    void addDepartment(Departments departments);

    List<Departments> getDepartmentBySecond();

    List<Departments> getAllDepartments();

    List<Departments> getSecondDepartment(Integer departmentId);
}
