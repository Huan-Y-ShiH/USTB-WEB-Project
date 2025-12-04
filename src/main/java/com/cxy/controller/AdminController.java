package com.cxy.controller;

import com.cxy.pojo.Admins;
import com.cxy.pojo.Doctors;
import com.cxy.service.AdminDoctorsService;
import com.cxy.service.AdminService;
import com.cxy.service.impl.AdminDoctorsServiceImpl;
import com.cxy.service.impl.AdminServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @author 陈翔宇
 * Date  2025/7/8 11:07
 */
@WebServlet("/login.do")
public class AdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("name");
        String password = request.getParameter("password");
        Integer rid = Integer.parseInt(request.getParameter("rid"));
        HttpSession session = request.getSession();

        if(rid == 1){
            AdminService adminService = new AdminServiceImpl();
            Admins admins = adminService.login(username,password);
            if(admins!=null){
                session.setAttribute("admin",admins);
                response.sendRedirect(request.getContextPath()+"/manager/index.jsp");
            }else {
                session.setAttribute("loginErr","用户名或密码错误");
                response.sendRedirect(request.getContextPath()+"/login.jsp");
            }
        }else if(rid == 2) {
            // 医生登录
            AdminDoctorsService adminDoctorsService = new AdminDoctorsServiceImpl();
            Doctors doctor = adminDoctorsService.login(username, password);
            System.out.println(doctor);
            if(doctor != null) {
                session.setAttribute("doctor", doctor);
                response.sendRedirect(request.getContextPath()+"/doctor/index.jsp");
            }
            else {
                session.setAttribute("loginErr","错误");
                response.sendRedirect(request.getContextPath()+"/login.jsp");
            }
        } else {
            session.setAttribute("loginErr","无效的角色类型");
            response.sendRedirect(request.getContextPath()+"/login.jsp");
        }
    }
}
