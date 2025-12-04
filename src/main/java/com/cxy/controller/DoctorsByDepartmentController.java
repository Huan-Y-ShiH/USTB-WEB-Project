package com.cxy.controller;

import com.cxy.pojo.Doctors;
import com.cxy.service.DoctorsService;
import com.cxy.service.impl.DoctorsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @author 黄江涛
 * Date  2025/7/17 13:26
 */
@WebServlet("/manager/getDoctorsByDepartment.do")
public class DoctorsByDepartmentController extends HttpServlet {
    private DoctorsService doctorsService = new DoctorsServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer departmentId = Integer.parseInt(request.getParameter("departmentId"));
        List<Doctors> doctors = doctorsService.getDoctorsByDepartmentId(departmentId);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 手动拼接JSON
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < doctors.size(); i++) {
            Doctors doctor = doctors.get(i);
            json.append("{")
                    .append("\"doctorId\":").append(doctor.getDoctorId()).append(",")
                    .append("\"name\":\"").append(doctor.getName()).append("\"");

            // 最后一个元素不加逗号
            if (i < doctors.size() - 1) {
                json.append("},");
            } else {
                json.append("}");
            }
        }
        json.append("]");

        response.getWriter().write(json.toString());
    }
}
