package com.cxy.patientController;

import com.cxy.pojo.Patients;
import com.cxy.service.PatientsService;
import com.cxy.service.impl.PatientsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/changePassword.do")
public class ChangePasswordController extends HttpServlet {
    private PatientsService patientsService = new PatientsServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");
        
        if (patientId == null) {
            response.sendRedirect(request.getContextPath() + "/user/userLogin.jsp");
            return;
        }

        // 转发到修改密码页面
        request.getRequestDispatcher("/user/changePassword.jsp").forward(request, response);
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
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            // 参数校验
            if (oldPassword == null || oldPassword.trim().isEmpty()) {
                response.getWriter().write("{\"success\":false,\"message\":\"请输入当前密码\"}");
                return;
            }

            if (newPassword == null || newPassword.trim().isEmpty()) {
                response.getWriter().write("{\"success\":false,\"message\":\"请输入新密码\"}");
                return;
            }

            if (newPassword.length() < 6) {
                response.getWriter().write("{\"success\":false,\"message\":\"新密码长度不能少于6位\"}");
                return;
            }

            if (newPassword.equals(oldPassword)) {
                response.getWriter().write("{\"success\":false,\"message\":\"新密码不能与当前密码相同\"}");
                return;
            }

            if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
                response.getWriter().write("{\"success\":false,\"message\":\"请确认新密码\"}");
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                response.getWriter().write("{\"success\":false,\"message\":\"两次输入的密码不一致\"}");
                return;
            }

            // 验证当前密码是否正确
            Patients patient = patientsService.getPatientById(patientId);
            if (patient == null) {
                response.getWriter().write("{\"success\":false,\"message\":\"用户信息不存在\"}");
                return;
            }

            if (!oldPassword.equals(patient.getPassword())) {
                response.getWriter().write("{\"success\":false,\"message\":\"当前密码错误\"}");
                return;
            }

            // 更新密码
            boolean success = patientsService.updatePassword(patientId, newPassword);
            
            if (success) {
                response.getWriter().write("{\"success\":true,\"message\":\"密码修改成功\"}");
            } else {
                response.getWriter().write("{\"success\":false,\"message\":\"密码修改失败，请重试\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\":false,\"message\":\"密码修改失败：" + e.getMessage() + "\"}");
        }
    }
} 