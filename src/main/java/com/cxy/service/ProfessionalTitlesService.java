package com.cxy.service;

import com.cxy.pojo.Departments;
import com.cxy.pojo.ProfessionalTitles;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/9 14:25
 */
public interface ProfessionalTitlesService  {

    List<ProfessionalTitles> selectAll();

    void addProfession(ProfessionalTitles professionalTitles);

    PageInfo<ProfessionalTitles> getProfession(Integer pageNum, Integer pageSize);

    void deleteProfession(String titleName);

    void updateProfession(ProfessionalTitles professionalTitles);

    ProfessionalTitles searchProfession(String titleName);
}
