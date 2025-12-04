package com.cxy.controller;

import com.cxy.service.ScheduleService;
import com.cxy.service.impl.ScheduleServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author 黄江涛
 * Date  2025/7/16 17:25
 */
@WebServlet("/manager/delSchedule.do")
public class ScheduleDeleteController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        Integer scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
        ScheduleService scheduleService = new ScheduleServiceImpl();
        scheduleService.delSchedule(scheduleId);
        response.sendRedirect(request.getContextPath()+"/manager/scheduleSearch.do");
    }
}
