package com.cxy.mapper;

import com.cxy.pojo.Departments;
import com.cxy.util.SqlSessionUtil;
import org.junit.Test;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/8 15:12
 */
public class DepartmentsMapperTest {
    @Test
    public void getDepartments() {
        DepartmentsMapper mapper = SqlSessionUtil.getMapper(DepartmentsMapper.class);
        List<Departments> departments = mapper.selectDepartmentsByLevel(1);
        for (Departments department:departments){
            System.out.println(department);
        }
    }
    @Test
    public void addDepartment() {
        DepartmentsMapper mapper = SqlSessionUtil.getMapper(DepartmentsMapper.class);
        Departments departments = new Departments();

        departments.setDepartmentName("测试7-9");
        departments.setDepartmentPid(45);
        departments.setDepartmentLevel(2);
        departments.setDepartmentDescription("7-0测试科室");

        System.out.println("添加前的科室信息"+departments);
        mapper.addDepartment(departments);
        System.out.println("添加后的科室信息"+departments);

        Departments depart = null;
        if (departments.getDepartmentPid() !=0){
            depart = mapper.selectById(departments.getDepartmentPid());
        }

        String departmentPath =(depart!=null?depart.getDepartmentPath():"")+"|"+departments.getDepartmentId()+"|";
        mapper.changePath(departmentPath,departments.getDepartmentId());
        SqlSessionUtil.commit();
        SqlSessionUtil.closeSession();

    }
}
