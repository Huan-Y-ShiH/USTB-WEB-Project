package com.cxy.service.impl;

import com.cxy.Vo.DoctorSearchVo;
import com.cxy.mapper.DoctorMapper;
import com.cxy.mapper.ProfessionalTitlesMapper;
import com.cxy.pojo.Doctors;
import com.cxy.pojo.ProfessionalTitles;
import com.cxy.service.DoctorsService;
import com.cxy.util.SqlSessionUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/9 16:09
 */
public class DoctorsServiceImpl implements DoctorsService {
    @Override
    public PageInfo<Doctors> getDoctorsBYPageAndSearch(DoctorSearchVo searchVo, Integer pageNum, Integer pageSize) {
        try {
            DoctorMapper mapper = SqlSessionUtil.getMapper(DoctorMapper.class);
            PageHelper.startPage(pageNum, pageSize);
            List<Doctors>doctorsList = mapper.selectDoctorAll(searchVo);
            PageInfo<Doctors> pageInfo = new PageInfo<>(doctorsList);
            return pageInfo;
        }catch (Exception e){
            throw new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public void addDoctor(Doctors doctors) {
        try {
            DoctorMapper mapper = SqlSessionUtil.getMapper(DoctorMapper.class);
            mapper.addDoctor(doctors);
            SqlSessionUtil.commit();
        }catch (Exception e){
            SqlSessionUtil.rollback();
            throw  new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public void deleteDoctor(String doctorsName) {
        try {
            DoctorMapper mapper = SqlSessionUtil.getMapper(DoctorMapper.class);
            // mapper.deleteAppointmentsByDoctorName(doctorsName);
            mapper.deleteDoctor(doctorsName);
            SqlSessionUtil.commit();
        }catch (Exception e){
            SqlSessionUtil.rollback();
            throw  new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public void updateDoctor(Doctors doctors) {
        try {
            DoctorMapper mapper = SqlSessionUtil.getMapper(DoctorMapper.class);
            mapper.updateDoctor(doctors);
            SqlSessionUtil.commit();
        }catch (Exception e){
            SqlSessionUtil.rollback();
            throw  new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public Doctors getDoctorByName(String name) {
        try {
            DoctorMapper mapper = SqlSessionUtil.getMapper(DoctorMapper.class);
            return mapper.getDoctorByName(name);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public void deleteDoctorsByIds(List<Integer> doctorIds) {
        try {
            DoctorMapper mapper = SqlSessionUtil.getMapper(DoctorMapper.class);
            mapper.deleteDoctorsByIds(doctorIds);
            SqlSessionUtil.commit();
        } catch (Exception e) {
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public List<Doctors> getDoctorsByDepartmentId(Integer departmentId) {
        try {
            DoctorMapper mapper = SqlSessionUtil.getMapper(DoctorMapper.class);
            return mapper.selectDoctorsByDepartmentId(departmentId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public void deleteDoctors(List<Integer> doctorIds){
        try {
            DoctorMapper mapper = SqlSessionUtil.getMapper(DoctorMapper.class);
            mapper.deleteDoctors(doctorIds);
            SqlSessionUtil.commit();
        }catch (Exception e){
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }
    @Override
    public List<Integer> getAllDoctorsId(DoctorSearchVo searchVO){
        try {
            DoctorMapper mapper = SqlSessionUtil.getMapper(DoctorMapper.class);
            List<Doctors> doctorsList = mapper.selectDoctorAll(searchVO);
            List<Integer> allDoctorsId = new ArrayList<>();
            for (Doctors doctor:doctorsList){
                allDoctorsId.add(doctor.getDoctorId());
            }
            return allDoctorsId;
        }catch (Exception e){
            throw new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }
}
