package com.cxy.service;

import com.cxy.Vo.DoctorSearchVo;
import com.cxy.pojo.Doctors;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * 管理层
 * @author 陈翔宇
 * Date  2025/7/9 16:06
 */
public interface DoctorsService {
    PageInfo<Doctors> getDoctorsBYPageAndSearch(DoctorSearchVo searchVo,Integer pageNum,Integer pageSize);

    void addDoctor(Doctors doctors);

    void deleteDoctor(String name);

    void updateDoctor(Doctors doctor);

    void deleteDoctorsByIds(List<Integer> doctorIds);

    Doctors getDoctorByName(String name);

    List<Doctors> getDoctorsByDepartmentId(Integer departmentId);

    void deleteDoctors(List<Integer> doctorIds);

    List<Integer> getAllDoctorsId(DoctorSearchVo searchVO);
}
