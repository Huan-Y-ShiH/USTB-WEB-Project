package com.cxy.controller;

import com.cxy.pojo.Schedule;
import com.cxy.service.ScheduleService;
import com.cxy.service.impl.ScheduleServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author 黄江涛
 * Date  2025/7/17 0:21
 */
@WebServlet("/manager/addSchedule.do")
public class ScheduleAddController extends HttpServlet {
    private ScheduleService scheduleService = new ScheduleServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 跳转到添加排班页面
        request.getRequestDispatcher("/manager/addSchedule.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取表单数据
        Integer doctorId = Integer.parseInt(request.getParameter("doctorId"));
        String dateStr = request.getParameter("date");
        String shiftTime = request.getParameter("shiftTime");
        Integer departmentId = Integer.parseInt(request.getParameter("departmentSecondId"));
        Boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable"));
        Integer sumCount = Integer.parseInt(request.getParameter("sumCount"));
        String remarks = request.getParameter("remarks");

        try {
            // 转换日期
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = sdf.parse(dateStr);

            // 创建排班对象
            Schedule schedule = new Schedule();
            schedule.setDoctorId(doctorId);
            schedule.setDate(date);
            schedule.setShiftTime(shiftTime);
            schedule.setDepartmentId(departmentId);
            schedule.setIsAvailable(isAvailable);
            schedule.setSumCount(sumCount);
            schedule.setRemarks(remarks);
            schedule.setVisitCount(0); // 默认就诊人数为0

            // 添加排班
            scheduleService.addSchedule(schedule);

            // 添加成功，跳转到排班列表
            response.sendRedirect(request.getContextPath() + "/manager/scheduleSearch.do?addSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "添加排班失败: " + e.getMessage());
            request.getRequestDispatcher("/manager/addSchedule.jsp").forward(request, response);
        }
    }
}
