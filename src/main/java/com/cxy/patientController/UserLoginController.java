package com.cxy.patientController;

import com.cxy.pojo.Patients;
import com.cxy.service.UsersService;
import com.cxy.service.impl.UsersServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 用户登录控制器
 */
@WebServlet("/user/login.do")
public class UserLoginController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 跳转到登录页面
        request.getRequestDispatcher("/user/userLogin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        if (phone == null || phone.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "手机号和密码不能为空");
            request.getRequestDispatcher("/user/userLogin.jsp").forward(request, response);
            return;
        }

        UsersService usersService = new UsersServiceImpl();
        Patients patient = usersService.login(phone, password);
        if (patient != null) {
            // 登录成功，保存session并跳转到首页
            HttpSession session = request.getSession();
            session.setAttribute("patient", patient);
            session.setAttribute("patientId", patient.getPatientId());
            response.sendRedirect(request.getContextPath() + "/user/index.jsp");
        } else {
            request.setAttribute("errorMessage", "手机号或密码错误");
            request.getRequestDispatcher("/user/userLogin.jsp").forward(request, response);
        }
    }
} 