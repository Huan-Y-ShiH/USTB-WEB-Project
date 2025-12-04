package com.cxy.service.impl;

import com.cxy.mapper.ProfessionalTitlesMapper;
import com.cxy.pojo.ProfessionalTitles;
import com.cxy.service.ProfessionalTitlesService;
import com.cxy.util.SqlSessionUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/9 14:25
 */
public class ProfessionalTitlesServiceImpl implements ProfessionalTitlesService {
    @Override
    public List<ProfessionalTitles> selectAll(){
        try {
            ProfessionalTitlesMapper mapper = SqlSessionUtil.getMapper(ProfessionalTitlesMapper.class);
            List<ProfessionalTitles> titlesList = mapper.selectAll();
            System.out.println("查询到的职称: " + titlesList);
            return titlesList;
        }catch (Exception e){
            throw new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public PageInfo<ProfessionalTitles> getProfession(Integer pageNum, Integer pageSize) {
        try {

            ProfessionalTitlesMapper mapper = SqlSessionUtil.getMapper(ProfessionalTitlesMapper.class);
            PageHelper.startPage(pageNum,pageSize);
            List<ProfessionalTitles> professionList = mapper.selectAll();
            PageInfo<ProfessionalTitles> pageInfo = new PageInfo<>(professionList);
            return pageInfo;
        }catch (Exception e){
            throw  new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public void addProfession(ProfessionalTitles professionalTitles) {
        try {
            ProfessionalTitlesMapper mapper = SqlSessionUtil.getMapper(ProfessionalTitlesMapper.class);
            mapper.addProfession(professionalTitles);
            SqlSessionUtil.commit();

        }catch (Exception e){
            SqlSessionUtil.rollback();
            throw  new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public void deleteProfession(String titleName) {
        try {
            ProfessionalTitlesMapper mapper = SqlSessionUtil.getMapper(ProfessionalTitlesMapper.class);
            mapper.deleteProfession(titleName);
            SqlSessionUtil.commit();
        }catch (Exception e){
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public void updateProfession(ProfessionalTitles professionalTitles) {
        try {
            ProfessionalTitlesMapper mapper = SqlSessionUtil.getMapper(ProfessionalTitlesMapper.class);
            mapper.updateProfession(professionalTitles);
            SqlSessionUtil.commit();
        }catch (Exception e){
            SqlSessionUtil.rollback();
            throw  new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public ProfessionalTitles searchProfession(String titleName) {
        try {
            ProfessionalTitlesMapper mapper = SqlSessionUtil.getMapper(ProfessionalTitlesMapper.class);
            ProfessionalTitles professionalTitles = mapper.searchProfession(titleName);
            return professionalTitles;
        }catch (Exception e){
            throw  new RuntimeException(e);
        }finally {
            SqlSessionUtil.closeSession();
        }
    }
}
