package com.cxy.controller;

import com.cxy.pojo.Departments;
import com.cxy.service.DepartmentsService;
import com.cxy.service.impl.DepartmentsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author 陈翔宇
 * Date  2025/7/9 10:45
 */
@WebServlet("/manager/addDepartment.do")
public class DepartmentAddController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String departmentName = request.getParameter("departmentName");
        Integer departmentPid = Integer.parseInt(request.getParameter("departmentPid"));
        Integer departmentLevel = Integer.parseInt(request.getParameter("departmentLevel"));
        String departmentDescription = request.getParameter("departmentDescription");

        Departments departments = new Departments();
        departments.setDepartmentName(departmentName);
        departments.setDepartmentPid(departmentPid);
        departments.setDepartmentLevel(departmentLevel);
        departments.setDepartmentDescription(departmentDescription);

        DepartmentsService departmentsService = new DepartmentsServiceImpl();
        departmentsService.addDepartment(departments);
        response.sendRedirect(request.getContextPath()+"/manager/departmentByFirst.do");
    }

}
