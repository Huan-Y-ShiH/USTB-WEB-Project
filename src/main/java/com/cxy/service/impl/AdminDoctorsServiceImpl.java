package com.cxy.service.impl;

import com.cxy.Vo.DoctorSearchVo;
import com.cxy.mapper.AdminDoctorMapper;
import com.cxy.pojo.Doctors;
import com.cxy.service.AdminDoctorsService;
import com.cxy.util.SqlSessionUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.util.Collections;
import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/16 14:52
 */
public class AdminDoctorsServiceImpl implements AdminDoctorsService {
    @Override
    public List<Doctors> selectDoctorAll(DoctorSearchVo searchVo) {
        try {
            //创建mapper对象
            AdminDoctorMapper mapper = SqlSessionUtil.getMapper(AdminDoctorMapper.class);
            //调用查询方法
            List<Doctors> doctorsList = mapper.selectDoctorAll(searchVo);
            //返回查询结果
            return doctorsList;
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            //释放资源
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public PageInfo<Doctors> getDoctorByPageAndSearch(DoctorSearchVo searchVo, Integer pageNum, Integer pageSize) {
        try {
            //创建mapper对象
            AdminDoctorMapper mapper = SqlSessionUtil.getMapper(AdminDoctorMapper.class);

            //使用pageHelper中的查询方法
            PageHelper.startPage(pageNum, pageSize);

            //调用mapper中的查询方法
            List<Doctors> doctorsList = mapper.selectDoctorAll(searchVo);

            //返回pageInfo对象
            PageInfo<Doctors> pageInfo = new PageInfo<>(doctorsList);
            //返回查询结果
            return pageInfo;
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public Doctors login(String jobNumber, String password) {
        try {
            //创建mapper对象
            AdminDoctorMapper mapper = SqlSessionUtil.getMapper(AdminDoctorMapper.class);
            //通过工号查询医生信息
            Doctors doctor = mapper.selectDoctorByJobNumber(jobNumber);
            //验证医生信息、密码和状态
            if(doctor != null && doctor.getPassword().equals(password) && doctor.getState() == 0){
                return doctor;
            }
            return null;
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            //释放资源
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public boolean updateDoctorInfo(Integer doctorId, String name, String phone, String email) {
        try {
            //创建mapper对象
            AdminDoctorMapper mapper = SqlSessionUtil.getMapper(AdminDoctorMapper.class);
            //调用更新方法
            int result = mapper.updateDoctorInfo(doctorId, name, phone, email);
            //提交事务
            SqlSessionUtil.commit();
            //返回更新结果
            return result > 0;
        } catch (Exception e) {
            //回滚事务
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        } finally {
            //释放资源
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public boolean updateDoctorPassword(Integer doctorId, String oldPassword, String newPassword) {
        try {
            //创建mapper对象
            AdminDoctorMapper mapper = SqlSessionUtil.getMapper(AdminDoctorMapper.class);

            // 先查询当前医生信息以验证旧密码
            // 由于selectDoctorByJobNumber需要工号，我们需要先通过ID查询医生信息
            // 这里我们通过条件查询来获取医生信息
            DoctorSearchVo searchVo = new DoctorSearchVo();
            List<Doctors> doctorsList = mapper.selectDoctorAll(searchVo);
            Doctors currentDoctor = null;

            // 查找对应ID的医生
            for (Doctors doctor : doctorsList) {
                if (doctor.getDoctorId().equals(doctorId)) {
                    currentDoctor = doctor;
                    break;
                }
            }

            if (currentDoctor == null) {
                return false; // 医生不存在
            }

            // 验证旧密码
            if (!currentDoctor.getPassword().equals(oldPassword)) {
                return false; // 旧密码不正确
            }

            //调用更新密码方法
            int result = mapper.updateDoctorPassword(doctorId, newPassword);
            //提交事务
            SqlSessionUtil.commit();
            //返回更新结果
            return result > 0;
        } catch (Exception e) {
            //回滚事务
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        } finally {
            //释放资源
            SqlSessionUtil.closeSession();
        }
    }
}
