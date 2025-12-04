package com.cxy.patientController;

import com.cxy.pojo.Appointments;
import com.cxy.service.ScheduleService;
import com.cxy.service.UsersAppointmentsService;
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

@WebServlet("/user/deleteAppointment.do")
public class DeleteAppointmentController extends HttpServlet {
    private UsersAppointmentsService appointmentsService = new UsersAppointmentsServiceImpl();
    private ScheduleService scheduleService = new ScheduleServiceImpl();

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
            String appointmentIdStr = request.getParameter("appointmentId");
            if (appointmentIdStr == null || appointmentIdStr.trim().isEmpty()) {
                response.getWriter().write("{\"success\":false,\"message\":\"预约ID不能为空\"}");
                return;
            }

            Integer appointmentId = Integer.parseInt(appointmentIdStr);

            // 1. 获取预约信息（用于获取医生和时段信息）
            Appointments appointment = appointmentsService.getAppointmentForDelete(appointmentId, patientId);
            if (appointment == null) {
                response.getWriter().write("{\"success\":false,\"message\":\"预约不存在或无权限删除\"}");
                return;
            }

            // 2. 删除预约
            boolean success = appointmentsService.deleteAppointment(appointmentId, patientId);
            
            if (success) {
                // 3. 减少排班表中的预约人数
                scheduleService.decreaseVisitCount(appointment.getDoctorId(), appointment.getAppointmentDate(), appointment.getAppointmentTime());
                
                response.getWriter().write("{\"success\":true,\"message\":\"删除成功！\"}");
            } else {
                response.getWriter().write("{\"success\":false,\"message\":\"删除失败，请重试\"}");
            }

        } catch (NumberFormatException e) {
            response.getWriter().write("{\"success\":false,\"message\":\"预约ID格式错误\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\":false,\"message\":\"删除失败：" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
} 