package com.cxy.service.impl;

import com.cxy.Vo.PatientSearchVo;
import com.cxy.mapper.UsersHospitalizationMapper;
import com.cxy.pojo.Hospitalization;
import com.cxy.service.UsersHospitalizationService;
import com.cxy.util.SqlSessionUtil;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/17 21:28
 */
public class UsersHospitalizationServiceImpl implements UsersHospitalizationService {
    @Override
    public List<Hospitalization> getAvailableHospitalizations() {
        UsersHospitalizationMapper mapper = SqlSessionUtil.getMapper(UsersHospitalizationMapper.class);
        return mapper.selectAvailableHospitalizations();
    }

    @Override
    public int reserveHospitalization(Integer hospitalizationId, Integer patientId) {
        UsersHospitalizationMapper mapper = SqlSessionUtil.getMapper(UsersHospitalizationMapper.class);
        int result = mapper.reserveHospitalization(hospitalizationId, patientId);
        SqlSessionUtil.commit();
        return result;
    }

    @Override
    public List<Hospitalization> getMyHospitalizations(Integer patientId) {
        UsersHospitalizationMapper mapper = SqlSessionUtil.getMapper(UsersHospitalizationMapper.class);
        return mapper.selectMyHospitalizations(patientId);
    }

    @Override
    public int cancelHospitalization(Integer hospitalizationId) {
        UsersHospitalizationMapper mapper = SqlSessionUtil.getMapper(UsersHospitalizationMapper.class);
        int result = mapper.cancelHospitalization(hospitalizationId);
        SqlSessionUtil.commit();
        return result;
    }
    
    @Override
    public List<Hospitalization> searchHospitalizations(PatientSearchVo searchVo) {
        UsersHospitalizationMapper mapper = SqlSessionUtil.getMapper(UsersHospitalizationMapper.class);
        return mapper.searchHospitalizations(searchVo);
    }
    
    @Override
    public int getHospitalizationCount(PatientSearchVo searchVo) {
        UsersHospitalizationMapper mapper = SqlSessionUtil.getMapper(UsersHospitalizationMapper.class);
        return mapper.getHospitalizationCount(searchVo);
    }
    
    @Override
    public Hospitalization getHospitalizationDetail(Integer hospitalizationId, Integer patientId) {
        UsersHospitalizationMapper mapper = SqlSessionUtil.getMapper(UsersHospitalizationMapper.class);
        return mapper.getHospitalizationDetail(hospitalizationId, patientId);
    }
}
