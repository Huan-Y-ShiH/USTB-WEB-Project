package com.cxy.patientController;

import com.cxy.pojo.Hospitalization;
import com.cxy.service.UsersHospitalizationService;
import com.cxy.service.impl.UsersHospitalizationServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/hospitalization.do")
public class HospitalizationController extends HttpServlet {
    private UsersHospitalizationService usersHospitalizationService = new UsersHospitalizationServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");
        if ("available".equals(action)) {
            // 查询可预约住院信息
            List<Hospitalization> list = usersHospitalizationService.getAvailableHospitalizations();
            request.setAttribute("hospitalizations", list);
            request.getRequestDispatcher("/user/hospitalizationAvailable.jsp").forward(request, response);
        } else if ("my".equals(action)) {
            // 查询我的住院信息
            List<Hospitalization> list = usersHospitalizationService.getMyHospitalizations(patientId);
            request.setAttribute("hospitalizations", list);
            request.getRequestDispatcher("/user/myHospitalizations.jsp").forward(request, response);
        } else {
            response.sendError(404);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");
        if ("reserve".equals(action)) {
            Integer hospitalizationId = Integer.valueOf(request.getParameter("hospitalizationId"));
            int result = usersHospitalizationService.reserveHospitalization(hospitalizationId, patientId);
            response.sendRedirect(request.getContextPath() + "/user/hospitalization.do?action=my");
        } else if ("cancel".equals(action)) {
            Integer hospitalizationId = Integer.valueOf(request.getParameter("hospitalizationId"));
            int result = usersHospitalizationService.cancelHospitalization(hospitalizationId);
            response.sendRedirect(request.getContextPath() + "/user/hospitalization.do?action=my");
        } else {
            response.sendError(404);
        }
    }
} 