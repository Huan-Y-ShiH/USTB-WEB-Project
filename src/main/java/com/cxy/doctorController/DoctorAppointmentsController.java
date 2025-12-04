package com.cxy.doctorController;

import com.cxy.pojo.Appointments;
import com.cxy.pojo.Doctors;
import com.cxy.service.AppointmentsService;
import com.cxy.service.impl.AppointmentsServiceImpl;
import com.github.pagehelper.PageInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 医生端预约管理控制器
 * @author 王知涵
 * Date  2025/1/10 21:30
 */
@WebServlet("/doctor/appointments.do")
public class DoctorAppointmentsController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 检查医生登录状态
        HttpSession session = request.getSession();
        Doctors doctor = (Doctors) session.getAttribute("doctor");
        
        if (doctor == null) {
            // 未登录，重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // 设置分页参数
        Integer pageSize = 10;
        Integer pageNum = 1;
        String page = request.getParameter("page");
        if (page != null && page.length() != 0) {
            pageNum = Integer.parseInt(page);
        }
        
        // 获取搜索参数
        String status = request.getParameter("status");
        
        // 创建预约Service对象
        AppointmentsService appointmentsService = new AppointmentsServiceImpl();
        
        // 分页查询当前医生的预约信息
        PageInfo<Appointments> pageInfo = appointmentsService.getAppointmentsByDoctorIdAndPage(
                doctor.getDoctorId(), status, pageNum, pageSize);
        
        // 存储结果到请求域
        request.setAttribute("pageInfo", pageInfo);
        request.setAttribute("status", status);
        request.setAttribute("doctor", doctor);
        
        // 转发到医生端预约页面
        request.getRequestDispatcher("/doctor/appointments.jsp").forward(request, response);
    }
} 