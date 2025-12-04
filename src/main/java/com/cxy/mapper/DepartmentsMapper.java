package com.cxy.mapper;

import com.cxy.pojo.Departments;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/8 15:10
 */
public interface DepartmentsMapper {
    /**
     * 查询所有一级科室信息
     * @return
     */
    List<Departments> selectDepartmentsByLevel(Integer departmentLevel);
    /**
     * 添加新科室
     * @param departments
     */
    void addDepartment(Departments departments);
    /**
     * 修改指定科室的路径
     * @param departmentId
     * @param departmentPath
     */
    void changePath(@Param("departmentPath") String departmentPath,@Param("departmentId") Integer departmentId);
    /**
     * 查询指定科室的科室信息
     * @param departmentId
     * @ return
     */
    Departments selectById(Integer departmentId);

    List<Departments> selectByPid(Integer pid);

    List<Departments> getAllDepartments();
}
