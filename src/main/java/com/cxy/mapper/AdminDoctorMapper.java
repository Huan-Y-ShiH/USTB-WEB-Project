package com.cxy.mapper;

import com.cxy.Vo.DoctorSearchVo;
import com.cxy.pojo.Doctors;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 医生层
 * @author 陈翔宇
 * Date  2025/7/16 14:59
 */
public interface AdminDoctorMapper {
    /**
     * 按条件查询医生的信息
     * @param searchVo
     * @return
     */
    List<Doctors> selectDoctorAll(DoctorSearchVo searchVo);

    /**
     * 根据工号查询医生信息
     * @param jobNumber 工号
     * @return 医生对象
     */
    Doctors selectDoctorByJobNumber(String jobNumber);

    /**
     * 更新医生个人信息
     * @param doctorId 医生ID
     * @param name 姓名
     * @param phone 联系电话
     * @param email 邮箱
     * @return 更新行数
     */
    int updateDoctorInfo(@Param("doctorId") Integer doctorId,
                         @Param("name") String name,
                         @Param("phone") String phone,
                         @Param("email") String email);

    /**
     * 更新医生密码
     * @param doctorId 医生ID
     * @param newPassword 新密码
     * @return 更新行数
     */
    int updateDoctorPassword(@Param("doctorId") Integer doctorId,
                             @Param("newPassword") String newPassword);
}