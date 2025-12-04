package com.cxy.patientController;

import com.cxy.pojo.Appointments;
import com.cxy.service.UsersAppointmentsService;
import com.cxy.service.impl.UsersAppointmentsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/appointmentDetail.do")
public class AppointmentDetailController extends HttpServlet {
    private UsersAppointmentsService usersAppointmentsService = new UsersAppointmentsServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");
        
        if (patientId == null) {
            response.sendRedirect(request.getContextPath() + "/user/userLogin.jsp");
            return;
        }

        String appointmentIdStr = request.getParameter("appointmentId");
        if (appointmentIdStr == null || appointmentIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/appointment.do");
            return;
        }

        try {
            Integer appointmentId = Integer.parseInt(appointmentIdStr);
            Appointments appointment = usersAppointmentsService.getAppointmentDetail(appointmentId, patientId);
            
            if (appointment == null) {
                request.setAttribute("error", "预约不存在或无权限查看");
                request.getRequestDispatcher("/user/error.jsp").forward(request, response);
                return;
            }
            
            request.setAttribute("appointment", appointment);
            request.getRequestDispatcher("/user/appointmentDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "预约ID格式错误");
            request.getRequestDispatcher("/user/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 