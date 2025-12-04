package com.cxy.mapper;

import com.cxy.Vo.DoctorSearchVo;
import com.cxy.pojo.Doctors;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/9 15:24
 */
public interface DoctorMapper {
    /**
     * 管理层
     * 按条件查询医生的信息
     * @param searchVo
     * @return
     */
    List<Doctors> selectDoctorAll(DoctorSearchVo searchVo);

    void addDoctor(Doctors doctors);

    void deleteDoctor(String name);

    void updateDoctor(Doctors doctors);

    void deleteDoctorsByIds(List<Integer> doctorIds);

    Doctors getDoctorByName(String name);

    List<Doctors> selectDoctorsByDepartmentId(Integer departmentId);

    void deleteDoctors(List<Integer> doctorIds);

}
