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
import java.util.List;

@WebServlet("/user/appointment.do")
public class AppointmentController extends HttpServlet {
    private UsersAppointmentsService usersAppointmentsService = new UsersAppointmentsServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");
        List<Appointments> list = usersAppointmentsService.getMyAppointments(patientId);
        request.setAttribute("appointments", list);
        request.getRequestDispatcher("/user/myAppointments.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("cancel".equals(action)) {
            Integer appointmentId = Integer.valueOf(request.getParameter("appointmentId"));
            usersAppointmentsService.cancelAppointment(appointmentId);
        }
        response.sendRedirect(request.getContextPath() + "/user/appointment.do");
    }
} 