package com.cxy.service.impl;

import com.cxy.mapper.DepartmentsMapper;
import com.cxy.pojo.Departments;
import com.cxy.service.DepartmentsService;
import com.cxy.util.SqlSessionUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/8 16:32
 */

public class DepartmentsServiceImpl implements DepartmentsService {
    @Override
    public PageInfo<Departments> getDepartments(Integer pageNum, Integer pageSize) {
        try {
            DepartmentsMapper mapper = SqlSessionUtil.getSession().getMapper(DepartmentsMapper.class);
            PageHelper.startPage(pageNum,pageSize);
            List<Departments> departmentsList = mapper.selectDepartmentsByLevel(1);
            PageInfo<Departments> pageInfo = new PageInfo<>(departmentsList);
            return pageInfo;
        }catch (Exception e){
            throw  new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public void addDepartment(Departments departments) {
        try {
            DepartmentsMapper mapper = SqlSessionUtil.getSession().getMapper(DepartmentsMapper.class);
            mapper.addDepartment(departments);
            Departments parentDepartment = null;
            if (departments.getDepartmentPid()!=0){
                parentDepartment = mapper.selectById(departments.getDepartmentPid());
            }
            String path = (parentDepartment !=null? parentDepartment.getDepartmentPath():"")+"|"+departments.getDepartmentId()+"|";
            mapper.changePath(path,departments.getDepartmentId());
            SqlSessionUtil.commit();
        }catch (Exception e){
            SqlSessionUtil.rollback();
            throw  new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public List<Departments> getDepartmentBySecond(){
        try {
            DepartmentsMapper mapper = SqlSessionUtil.getSession().getMapper(DepartmentsMapper.class);
            List<Departments> departmentsList = mapper.selectDepartmentsByLevel(2);
            return departmentsList;
        }catch (Exception e){
            throw  new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public List<Departments> getAllDepartments() {
        try {
            DepartmentsMapper mapper = SqlSessionUtil.getMapper(DepartmentsMapper.class);
            // 获取所有科室（包括一级和二级）
            List<Departments> allDepartments = mapper.getAllDepartments();
            return allDepartments;
        }catch (Exception e){
            throw  new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public List<Departments> getSecondDepartment(Integer departmentFirstId){
        try {
            DepartmentsMapper mapper = SqlSessionUtil.getMapper(DepartmentsMapper.class);
            List<Departments> childList = mapper.selectByPid(departmentFirstId);
            return  childList;
        }catch (Exception e){
            throw new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }
}
