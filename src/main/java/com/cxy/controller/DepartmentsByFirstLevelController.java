package com.cxy.controller;

import com.cxy.pojo.Departments;
import com.cxy.service.DepartmentsService;
import com.cxy.service.impl.DepartmentsServiceImpl;
import com.github.pagehelper.PageInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author 陈翔宇
 * Date  2025/7/8 16:36
 */
@WebServlet("/manager/departmentByFirst.do")
public class DepartmentsByFirstLevelController extends HttpServlet {
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
        DepartmentsService departmentsService = new DepartmentsServiceImpl();
        PageInfo<Departments> pageInfo = departmentsService.getDepartments(pageNum, pageSize);
        request.setAttribute("pageInfo",pageInfo);
        request.getRequestDispatcher("/manager/departmentList.jsp").forward(request,response);
    }
}
