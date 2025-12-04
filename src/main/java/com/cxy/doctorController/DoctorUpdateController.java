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
 * 医生个人信息更新控制器
 * @author 王知涵
 * Date  2025/1/10 16:30
 */
@WebServlet("/doctor/updateInfo.do")
public class DoctorUpdateController extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
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
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            
            // 参数验证
            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("errorMessage", "姓名不能为空");
                request.getRequestDispatcher("/doctor/editProfile.jsp").forward(request, response);
                return;
            }
            
            // 创建医生Service对象
            AdminDoctorsService adminDoctorsService = new AdminDoctorsServiceImpl();
            
            // 调用更新方法
            boolean result = adminDoctorsService.updateDoctorInfo(
                sessionDoctor.getDoctorId(), 
                name.trim(), 
                phone != null ? phone.trim() : "", 
                email != null ? email.trim() : ""
            );
            
            if (result) {
                // 更新成功，重新查询医生信息并更新session
                Doctors updatedDoctor = adminDoctorsService.login(sessionDoctor.getJobNumber(), sessionDoctor.getPassword());
                if (updatedDoctor != null) {
                    session.setAttribute("doctor", updatedDoctor);
                }
                
                // 设置成功消息并重定向到个人信息页面
                session.setAttribute("successMessage", "个人信息更新成功");
                response.sendRedirect(request.getContextPath() + "/doctor/profile.jsp");
            } else {
                // 更新失败，返回编辑页面并显示错误信息
                request.setAttribute("errorMessage", "更新失败，请重试");
                request.getRequestDispatcher("/doctor/editProfile.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            request.getRequestDispatcher("/doctor/editProfile.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // GET请求跳转到编辑页面
        request.getRequestDispatcher("/doctor/editProfile.jsp").forward(request, response);
    }
} 