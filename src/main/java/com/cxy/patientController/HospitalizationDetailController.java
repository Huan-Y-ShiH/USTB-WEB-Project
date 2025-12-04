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

@WebServlet("/user/hospitalizationDetail.do")
public class HospitalizationDetailController extends HttpServlet {
    private UsersHospitalizationService usersHospitalizationService = new UsersHospitalizationServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");
        
        if (patientId == null) {
            response.sendRedirect(request.getContextPath() + "/user/userLogin.jsp");
            return;
        }

        String hospitalizationIdStr = request.getParameter("hospitalizationId");
        if (hospitalizationIdStr == null || hospitalizationIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/hospitalization.do?action=my");
            return;
        }

        try {
            Integer hospitalizationId = Integer.parseInt(hospitalizationIdStr);
            Hospitalization hospitalization = usersHospitalizationService.getHospitalizationDetail(hospitalizationId, patientId);
            
            if (hospitalization == null) {
                request.setAttribute("error", "住院信息不存在或无权限查看");
                request.getRequestDispatcher("/user/error.jsp").forward(request, response);
                return;
            }
            
            request.setAttribute("hospitalization", hospitalization);
            request.getRequestDispatcher("/user/hospitalizationDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "住院ID格式错误");
            request.getRequestDispatcher("/user/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 