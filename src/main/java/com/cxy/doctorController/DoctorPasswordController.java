package com.cxy.doctorController;

import com.cxy.pojo.Doctors;
import com.cxy.service.AdminDoctorsService;
import com.cxy.service.impl.AdminDoctorsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 医生修改密码控制器
 * @author 王知涵
 * Date  2025/1/10 17:20
 */
@WebServlet("/doctor/updatePassword.do")
public class DoctorPasswordController extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 设置请求编码
        request.setCharacterEncoding("UTF-8");
        
        // 获取session中的医生信息
        HttpSession session = request.getSession();
        Doctors sessionDoctor = (Doctors) session.getAttribute("doctor");
        
        if (sessionDoctor == null) {
            // 未登录，跳转到登录页面
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            // 获取表单参数
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            // 参数验证
            if (oldPassword == null || oldPassword.trim().isEmpty()) {
                request.setAttribute("errorMessage", "请输入旧密码");
                request.getRequestDispatcher("/doctor/updatePassword.jsp").forward(request, response);
                return;
            }
            
            if (newPassword == null || newPassword.trim().isEmpty()) {
                request.setAttribute("errorMessage", "请输入新密码");
                request.getRequestDispatcher("/doctor/updatePassword.jsp").forward(request, response);
                return;
            }
            
            if (confirmPassword == null || !newPassword.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "两次输入的新密码不一致");
                request.getRequestDispatcher("/doctor/updatePassword.jsp").forward(request, response);
                return;
            }
            
            if (newPassword.length() < 6) {
                request.setAttribute("errorMessage", "新密码长度不能少于6位");
                request.getRequestDispatcher("/doctor/updatePassword.jsp").forward(request, response);
                return;
            }
            
            if (oldPassword.equals(newPassword)) {
                request.setAttribute("errorMessage", "新密码不能与旧密码相同");
                request.getRequestDispatcher("/doctor/updatePassword.jsp").forward(request, response);
                return;
            }
            
            // 创建医生Service对象
            AdminDoctorsService adminDoctorsService = new AdminDoctorsServiceImpl();
            
            // 调用修改密码方法
            boolean result = adminDoctorsService.updateDoctorPassword(
                sessionDoctor.getDoctorId(), 
                oldPassword.trim(), 
                newPassword.trim()
            );
            
            if (result) {
                // 修改成功，更新session中的医生信息
                Doctors updatedDoctor = adminDoctorsService.login(sessionDoctor.getJobNumber(), newPassword.trim());
                if (updatedDoctor != null) {
                    session.setAttribute("doctor", updatedDoctor);
                }
                
                // 设置成功消息并重定向到个人信息页面
                session.setAttribute("successMessage", "密码修改成功");
                response.sendRedirect(request.getContextPath() + "/doctor/profile.jsp");
            } else {
                // 修改失败，返回修改页面并显示错误信息
                request.setAttribute("errorMessage", "旧密码不正确，密码修改失败");
                request.getRequestDispatcher("/doctor/updatePassword.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            request.getRequestDispatcher("/doctor/updatePassword.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // GET请求跳转到修改密码页面
        request.getRequestDispatcher("/doctor/updatePassword.jsp").forward(request, response);
    }
} 