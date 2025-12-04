package com.cxy.controller;

import com.cxy.service.AppointmentsService;
import com.cxy.service.impl.AppointmentsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/manager/deleteAppointment.do")
public class AppointmentDeleteController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 设置请求编码
        request.setCharacterEncoding("UTF-8");

        try {
            // 获取参数
            String appointmentIdStr = request.getParameter("appointmentId");

            // 验证参数
            if (appointmentIdStr == null || appointmentIdStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/manager/appointments.do?error=参数错误");
                return;
            }

            Integer appointmentId = Integer.parseInt(appointmentIdStr);

            // 创建预约Service对象
            AppointmentsService appointmentsService = new AppointmentsServiceImpl();

            // 删除预约
            boolean result = appointmentsService.deleteAppointment(appointmentId);

            if (result) {
                response.sendRedirect(request.getContextPath() + "/manager/appointments.do?message=预约已删除");
            } else {
                response.sendRedirect(request.getContextPath() + "/manager/appointments.do?error=删除失败");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/manager/appointments.do?error=预约ID格式错误");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/manager/appointments.do?error=系统错误：" + e.getMessage());
        }
    }
}