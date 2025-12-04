package com.cxy.doctorController;

import com.cxy.pojo.Doctors;
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

/**
 * 患者详情查看控制器
 * @author 王知涵
 * Date  2025/1/10 20:20
 */
@WebServlet("/doctor/patientDetail.do")
public class PatientDetailController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
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
            // 获取患者ID参数
            String patientIdStr = request.getParameter("patientId");
            
            if (patientIdStr == null || patientIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "患者ID不能为空");
                request.getRequestDispatcher("/doctor/patients.do").forward(request, response);
                return;
            }
            
            Integer patientId = Integer.parseInt(patientIdStr);
            
            // 创建患者Service对象
            PatientsService patientsService = new PatientsServiceImpl();
            
            // 查询患者详情
            Patients patient = patientsService.getPatientById(patientId);
            
            if (patient == null) {
                request.setAttribute("errorMessage", "患者不存在");
                request.getRequestDispatcher("/doctor/patients.do").forward(request, response);
                return;
            }
            
            // 设置返回数据
            request.setAttribute("patient", patient);
            
            // 跳转到患者详情页面
            request.getRequestDispatcher("/doctor/patientDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "患者ID格式错误");
            request.getRequestDispatcher("/doctor/patients.do").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            request.getRequestDispatcher("/doctor/patients.do").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 