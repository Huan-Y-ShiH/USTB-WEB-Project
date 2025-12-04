package com.cxy.controller;

import com.cxy.pojo.Appointments;
import com.cxy.service.AppointmentsService;
import com.cxy.service.impl.AppointmentsServiceImpl;
import com.github.pagehelper.PageInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 预约管理控制器
 * @author 陈翔宇
 * Date  2025/1/10 21:00
 */
@WebServlet("/manager/appointments.do")
public class AppointmentsController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 设置分页参数
        Integer pageSize = 10;
        Integer pageNum = 1;
        String page = request.getParameter("page");
        if (page != null && page.length() != 0) {
            pageNum = Integer.parseInt(page);
        }
        
        // 获取搜索参数
        String patientName = request.getParameter("patientName");
        String doctorName = request.getParameter("doctorName");
        String status = request.getParameter("status");
        String appointmentDateStr = request.getParameter("appointmentDate");
        
        // 处理日期参数
        Date appointmentDate = null;
        if (appointmentDateStr != null && !appointmentDateStr.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                appointmentDate = sdf.parse(appointmentDateStr);
            } catch (ParseException e) {
                // 日期格式错误，忽略这个条件
                appointmentDate = null;
            }
        }
        
        // 创建预约Service对象
        AppointmentsService appointmentsService = new AppointmentsServiceImpl();
        
        // 分页查询预约信息
        PageInfo<Appointments> pageInfo = appointmentsService.getAppointmentsByPageAndSearch(
                patientName, doctorName, status, appointmentDate, pageNum, pageSize);
        
        // 存储结果到请求域
        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("patientName", patientName);
        request.setAttribute("doctorName", doctorName);
        request.setAttribute("status", status);
        request.setAttribute("appointmentDate", appointmentDateStr);
        
        // 转发到预约列表JSP页面
        request.getRequestDispatcher("/manager/appointmentsList.jsp").forward(request, response);
    }
} 