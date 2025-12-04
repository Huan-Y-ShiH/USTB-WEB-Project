package com.cxy.mapper;

import com.cxy.Vo.DoctorSearchVo;
import com.cxy.pojo.Doctors;
import com.cxy.util.SqlSessionUtil;
import org.junit.Test;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/9 15:43
 */
public class DoctorMapperTest {
    @Test
    public void selectDoctor() {
        DoctorMapper mapper = SqlSessionUtil.getMapper(DoctorMapper.class);
        DoctorSearchVo searchVo = new DoctorSearchVo();
        searchVo.setDepartmentId(6);
        searchVo.setTitleId(2);
        List<Doctors> doctorsList = mapper.selectDoctorAll(searchVo);
        for (Doctors doctors : doctorsList) {
            System.out.println(doctors);
        }
    }
}
