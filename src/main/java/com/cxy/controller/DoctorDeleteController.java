package com.cxy.controller;

import com.cxy.pojo.Doctors;
import com.cxy.service.DoctorsService;
import com.cxy.service.ScheduleService;
import com.cxy.service.impl.DoctorsServiceImpl;
import com.cxy.service.impl.ScheduleServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author 陈翔宇
 * Date  2025/7/14 14:31
 */
@WebServlet("/manager/deleteDoctor.do")
public class DoctorDeleteController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String Name = request.getParameter("name");

        DoctorsService doctorsService = new DoctorsServiceImpl();
        ScheduleService scheduleService = new ScheduleServiceImpl();
        Doctors doctors = doctorsService.getDoctorByName(Name);
        Integer doctorId = doctors.getDoctorId();
        scheduleService.delScheduleByDoctorId(doctorId);
        doctorsService.deleteDoctor(Name);
        response.sendRedirect(request.getContextPath()+"/manager/doctorsSearch.do");
    }
}
