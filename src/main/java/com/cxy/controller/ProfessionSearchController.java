package com.cxy.controller;

import com.cxy.pojo.ProfessionalTitles;
import com.cxy.service.ProfessionalTitlesService;
import com.cxy.service.impl.ProfessionalTitlesServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author 陈翔宇
 * Date  2025/7/10 14:52
 */
@WebServlet("/manager/searchProfession.do")
public class ProfessionSearchController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        String titleName = request.getParameter("titleName");

        ProfessionalTitlesService professionalTitlesService = new ProfessionalTitlesServiceImpl();
        ProfessionalTitles professionalTitles = professionalTitlesService.searchProfession(titleName);

        request.setAttribute("ProfessionalTitles",professionalTitles);
        request.getRequestDispatcher("/manager/updateProfession.jsp").forward(request, response);
    }
}
