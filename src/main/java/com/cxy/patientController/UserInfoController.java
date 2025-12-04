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
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/info.do")
public class UserInfoController extends HttpServlet {
    private UsersService usersService = new UsersServiceImpl();
    private PatientsService patientsService = new PatientsServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");
        Patients patient = patientsService.getPatientById(patientId);
        request.setAttribute("patient", patient);
        request.getRequestDispatcher("/user/userInfo.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");
        String pname = request.getParameter("pname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        // 可扩展更多字段
        Patients patient = new Patients();
        patient.setPatientId(patientId);
        patient.setPname(pname);
        patient.setPhone(phone);
        patient.setEmail(email);
        int result = usersService.updatePatientInfo(patient);
        if(result > 0){
            request.setAttribute("successMessage", "信息修改成功");
        }else{
            request.setAttribute("errorMessage", "信息修改失败");
        }
        // 重新查询并展示
        patient = patientsService.getPatientById(patientId);
        request.setAttribute("patient", patient);
        request.getRequestDispatcher("/user/userInfo.jsp").forward(request, response);
    }
} 