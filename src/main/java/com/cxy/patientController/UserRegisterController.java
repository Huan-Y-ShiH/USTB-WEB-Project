package com.cxy.patientController;

import com.cxy.pojo.Patients;
import com.cxy.service.PatientsService;
import com.cxy.service.UsersService;
import com.cxy.service.impl.PatientsServiceImpl;
import com.cxy.service.impl.UsersServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * 用户注册控制器
 */
@WebServlet("/user/register.do")
public class UserRegisterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 跳转到注册页面
        request.getRequestDispatcher("/user/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String pname = request.getParameter("pname");
        String idCardNumber = request.getParameter("idCardNumber");
        String email = request.getParameter("email");
        // 其他字段可根据页面补充

        // 简单校验
        if (phone == null || phone.trim().isEmpty() || password == null || password.trim().isEmpty() || pname == null || pname.trim().isEmpty()) {
            request.setAttribute("errorMessage", "手机号、密码、姓名不能为空");
            request.getRequestDispatcher("/user/register.jsp").forward(request, response);
            return;
        }

        UsersService usersService = new UsersServiceImpl();
        PatientsService patientsService = new PatientsServiceImpl();
        // 检查手机号是否已注册
        Patients exist = patientsService.getPatientByPhone(phone);
        if (exist != null) {
            request.setAttribute("errorMessage", "该手机号已注册");
            request.getRequestDispatcher("/user/register.jsp").forward(request, response);
            return;
        }

        Patients patient = new Patients();
        patient.setPhone(phone);
        patient.setPassword(password);
        patient.setPname(pname);
        patient.setIdCardNumber(idCardNumber);
        patient.setEmail(email);
        patient.setRegistrationDate(new Date());
        patient.setBalance(0.0);
        // 其他字段可补充

        int result = usersService.register(patient);
        if (result > 0) {
            // 注册成功，跳转到登录页
            request.setAttribute("successMessage", "注册成功，请登录");
            request.getRequestDispatcher("/user/userLogin.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "注册失败，请重试");
            request.getRequestDispatcher("/user/register.jsp").forward(request, response);
        }
    }
} 