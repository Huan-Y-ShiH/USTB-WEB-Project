package com.cxy.patientController;

import com.cxy.pojo.Departments;
import com.cxy.pojo.Schedule;
import com.cxy.service.DepartmentsService;
import com.cxy.service.ScheduleService;
import com.cxy.service.UsersAppointmentsService;
import com.cxy.service.impl.DepartmentsServiceImpl;
import com.cxy.service.impl.ScheduleServiceImpl;
import com.cxy.service.impl.UsersAppointmentsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/user/addAppointment.do")
public class AddAppointmentController extends HttpServlet {
    private DepartmentsService departmentsService = new DepartmentsServiceImpl();
    private ScheduleService scheduleService = new ScheduleServiceImpl();
    private UsersAppointmentsService appointmentsService = new UsersAppointmentsServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");
        
        if (patientId == null) {
            response.sendRedirect(request.getContextPath() + "/user/userLogin.jsp");
            return;
        }

        try {
            // 获取所有科室列表
            List<Departments> departments = departmentsService.getAllDepartments();
            request.setAttribute("departments", departments);
            
            // 设置最小日期为今天
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String minDate = sdf.format(new Date());
            request.setAttribute("minDate", minDate);
            
            // 转发到新增预约页面
            request.getRequestDispatcher("/user/addAppointment.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "加载页面失败：" + e.getMessage());
            request.getRequestDispatcher("/user/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");
        
        if (patientId == null) {
            response.sendRedirect(request.getContextPath() + "/user/userLogin.jsp");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // 获取表单参数
            String doctorIdStr = request.getParameter("doctorId");
            String appointmentDate = request.getParameter("appointmentDate");
            String appointmentTime = request.getParameter("appointmentTime");

            // 参数校验
            if (doctorIdStr == null || doctorIdStr.trim().isEmpty()) {
                response.getWriter().write("{\"success\":false,\"message\":\"请选择医生\"}");
                return;
            }
            if (appointmentDate == null || appointmentDate.trim().isEmpty()) {
                response.getWriter().write("{\"success\":false,\"message\":\"请选择预约日期\"}");
                return;
            }
            if (appointmentTime == null || appointmentTime.trim().isEmpty()) {
                response.getWriter().write("{\"success\":false,\"message\":\"请选择预约时段\"}");
                return;
            }

            Integer doctorId = Integer.parseInt(doctorIdStr);

            // 1. 检查是否已经预约过该医生该时段
            if (appointmentsService.hasExistingAppointment(patientId, doctorId, appointmentDate, appointmentTime)) {
                response.getWriter().write("{\"success\":false,\"message\":\"您已经预约过该医生该时段，请勿重复预约\"}");
                return;
            }

            // 2. 检查医生排班
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
            java.util.Date date = sdf.parse(appointmentDate);
            
            if (!scheduleService.canBookAppointment(doctorId, date, appointmentTime)) {
                Schedule schedule = scheduleService.getScheduleByDoctorAndTime(doctorId, date, appointmentTime);
                if (schedule == null) {
                    response.getWriter().write("{\"success\":false,\"message\":\"该医生该时段无排班\"}");
                } else if (!schedule.getIsAvailable()) {
                    response.getWriter().write("{\"success\":false,\"message\":\"该医生该时段排班不可用\"}");
                } else {
                    response.getWriter().write("{\"success\":false,\"message\":\"该时段预约人数已满\"}");
                }
                return;
            }

            // 3. 添加预约
            boolean success = appointmentsService.addAppointment(patientId, doctorId, appointmentDate, appointmentTime);
            
            if (success) {
                // 4. 增加排班表中的预约人数
                scheduleService.increaseVisitCount(doctorId, date, appointmentTime);
                response.getWriter().write("{\"success\":true,\"message\":\"预约成功！\"}");
            } else {
                response.getWriter().write("{\"success\":false,\"message\":\"预约失败，请重试\"}");
            }

        } catch (NumberFormatException e) {
            response.getWriter().write("{\"success\":false,\"message\":\"医生ID格式错误\"}");
        } catch (java.text.ParseException e) {
            response.getWriter().write("{\"success\":false,\"message\":\"日期格式错误\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\":false,\"message\":\"预约失败：" + e.getMessage() + "\"}");
        }
    }
} 