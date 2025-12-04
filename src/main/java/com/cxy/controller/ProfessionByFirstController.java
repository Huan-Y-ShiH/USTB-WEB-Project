package com.cxy.controller;

import com.cxy.pojo.ProfessionalTitles;
import com.cxy.service.ProfessionalTitlesService;
import com.cxy.service.impl.ProfessionalTitlesServiceImpl;
import com.github.pagehelper.PageInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author 陈翔宇
 * Date  2025/7/10 09:52
 */
@WebServlet("/manager/professionByFirst.do")
public class ProfessionByFirstController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer pageSize = 5;
        Integer pageNum = 1;
        String page = request.getParameter("page");
        if(page != null && page.length() > 0){
            pageNum = Integer.parseInt(page);
        }
        ProfessionalTitlesService professionalTitlesService = new ProfessionalTitlesServiceImpl();
        PageInfo<ProfessionalTitles> pageInfo = professionalTitlesService.getProfession(pageNum, pageSize);
        request.setAttribute("pageInfo",pageInfo);
        request.getRequestDispatcher("/manager/profession.jsp").forward(request,response);
    }
}
