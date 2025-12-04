package com.cxy.mapper;

import com.cxy.pojo.ProfessionalTitles;

import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/9 14:22
 */
public interface ProfessionalTitlesMapper {
    /**
     * 查询所有医生信息
     * @return
     */
    List<ProfessionalTitles> selectAll();

    void addProfession(ProfessionalTitles professionalTitles);

    void deleteProfession(String titleName);

    void updateProfession(ProfessionalTitles professionalTitles);

    ProfessionalTitles searchProfession(String titleName);
}
