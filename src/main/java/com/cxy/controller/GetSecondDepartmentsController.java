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
import java.io.PrintWriter;
import java.util.List;

/**
 * @author 黄江涛
 * Date  2025/7/16 15:28
 */
@WebServlet("/manager/getSecondDepartments.do")
public class GetSecondDepartmentsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=utf-8");
        Integer departmentFirstId = null;
        String strDepartmentFirstId = request.getParameter("departmentFirstId");
        if (strDepartmentFirstId!=null && strDepartmentFirstId.length()>0){
            departmentFirstId = Integer.parseInt(strDepartmentFirstId);
        }
        DepartmentsService departmentsService = new DepartmentsServiceImpl();
        List<Departments> secondDepartments = departmentsService.getSecondDepartment(departmentFirstId);
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < secondDepartments.size(); i++) {
            Departments dept = secondDepartments.get(i);
            json.append(String.format(
                    "{\"departmentId\":\"%d\",\"departmentName\":\"%s\"}",
                    dept.getDepartmentId(), dept.getDepartmentName()
            ));
            if (i < secondDepartments.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
        out.close();
    }
}
