package com.cxy.controller;

import com.cxy.Vo.DoctorSearchVo;
import com.cxy.pojo.Doctors;
import com.cxy.service.DoctorsService;
import com.cxy.service.impl.DoctorsServiceImpl;
import com.github.pagehelper.PageInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author 陈翔宇
 * Date  2025/7/9 16:12
 */
@WebServlet("/manager/doctorsSearch.do")
public class DoctorsSearchController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer pageNum = 1;
        Integer pageSize = 5;
        String page = request.getParameter("page");
        if (page != null && page.length() > 0) {
            pageNum = Integer.parseInt(page);
        }
        Integer departmentId=null;
        String strDepartmentId = request.getParameter("departmentId");
        if (strDepartmentId != null && strDepartmentId.length() > 0) {
            departmentId = Integer.parseInt(strDepartmentId);
        }
        Integer titleId=null;
        String strTitleId = request.getParameter("titleId");
        if (strTitleId != null && strTitleId.length() > 0) {
            titleId = Integer.parseInt(strTitleId);
        }

        String jobNumber = request.getParameter("jobNumber");

        String doctorName = request.getParameter("doctorName");

        DoctorSearchVo searchVo = new DoctorSearchVo(departmentId,titleId,doctorName,jobNumber);
        DoctorsService doctorsService = new DoctorsServiceImpl();
        PageInfo<Doctors> pageInfo = doctorsService.getDoctorsBYPageAndSearch(searchVo,pageNum,pageSize);
        request.setAttribute("pageInfo",pageInfo);
        request.getRequestDispatcher("/manager/doctorList.jsp").forward(request,response);
    }
}
