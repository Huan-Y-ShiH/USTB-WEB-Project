package com.cxy.doctorController;

import com.cxy.pojo.Appointments;
import com.cxy.pojo.Doctors;
import com.cxy.service.AppointmentsService;
import com.cxy.service.impl.AppointmentsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 医生端更新预约状态控制器
 * @author 王知涵
 * Date  2025/1/10 21:30
 */
@WebServlet("/doctor/updateAppointmentStatus.do")
public class DoctorUpdateAppointmentStatusController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 检查医生登录状态
        HttpSession session = request.getSession();
        Doctors doctor = (Doctors) session.getAttribute("doctor");
        
        if (doctor == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // 设置请求编码
        request.setCharacterEncoding("UTF-8");
        
        try {
            // 获取参数
            String appointmentIdStr = request.getParameter("appointmentId");
            String status = request.getParameter("status");
            
            // 验证参数
            if (appointmentIdStr == null || appointmentIdStr.trim().isEmpty() ||
                status == null || status.trim().isEmpty()) {
                
                response.sendRedirect(request.getContextPath() + "/doctor/appointments.do?error=参数错误");
                return;
            }
            
            // 验证状态值
            if (!"completed".equals(status) && !"cancelled".equals(status)) {
                response.sendRedirect(request.getContextPath() + "/doctor/appointments.do?error=状态值无效");
                return;
            }
            
            Integer appointmentId = Integer.parseInt(appointmentIdStr);
            
            // 创建预约Service对象
            AppointmentsService appointmentsService = new AppointmentsServiceImpl();
            
            // 验证预约是否属于当前医生
            Appointments appointment = appointmentsService.getAppointmentById(appointmentId);
            if (appointment == null) {
                response.sendRedirect(request.getContextPath() + "/doctor/appointments.do?error=预约不存在");
                return;
            }
            
            if (!appointment.getDoctorId().equals(doctor.getDoctorId())) {
                response.sendRedirect(request.getContextPath() + "/doctor/appointments.do?error=无权限操作此预约");
                return;
            }
            
            // 更新预约状态
            boolean result = appointmentsService.updateAppointmentStatus(appointmentId, status);
            
            if (result) {
                // 更新成功
                String message = "completed".equals(status) ? "预约已标记为完成" : "预约已取消";
                response.sendRedirect(request.getContextPath() + "/doctor/appointments.do?message=" + message);
            } else {
                // 更新失败
                response.sendRedirect(request.getContextPath() + "/doctor/appointments.do?error=状态更新失败");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/doctor/appointments.do?error=预约ID格式错误");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/doctor/appointments.do?error=系统错误：" + e.getMessage());
        }
    }
} 