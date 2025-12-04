package com.cxy.service;

import com.cxy.Vo.DoctorSearchVo;
import com.cxy.pojo.Doctors;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * 医生层
 * @author 陈翔宇
 * Date  2025/7/16 14:50
 */
public interface AdminDoctorsService {
    /**
     * 按条件查询医生的信息
     * @param searchVo
     * @return
     */
    List<Doctors> selectDoctorAll(DoctorSearchVo searchVo);

    /**
     * 按条件分页查询医生信息
     * @param searchVo 条件对象
     * @param pageNum 当前页码
     * @param pageSize 每页显示条数
     * @return 分页信息对象
     */
    PageInfo<Doctors> getDoctorByPageAndSearch(DoctorSearchVo searchVo, Integer pageNum, Integer pageSize);

    /**
     * 医生登录验证
     * @param jobNumber 工号
     * @param password 密码
     * @return 医生对象，如果验证失败返回null
     */
    Doctors login(String jobNumber, String password);

    /**
     * 更新医生个人信息
     * @param doctorId 医生ID
     * @param name 姓名
     * @param phone 联系电话
     * @param email 邮箱
     * @return 更新结果
     */
    boolean updateDoctorInfo(Integer doctorId, String name, String phone, String email);

    /**
     * 修改医生密码
     * @param doctorId 医生ID
     * @param oldPassword 旧密码
     * @param newPassword 新密码
     * @return 修改结果
     */
    boolean updateDoctorPassword(Integer doctorId, String oldPassword, String newPassword);
}
