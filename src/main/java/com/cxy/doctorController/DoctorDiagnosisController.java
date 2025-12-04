package com.cxy.doctorController;

import com.cxy.pojo.Consultation;
import com.cxy.pojo.Doctors;
import com.cxy.service.ConsultationService;
import com.cxy.service.impl.ConsultationServiceImpl;
import com.github.pagehelper.PageInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 医生端诊断记录控制器
 * @author 王知涵
 * Date  2025/1/10 23:10
 */
@WebServlet("/doctor/diagnosis.do")
public class DoctorDiagnosisController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 设置请求编码
        request.setCharacterEncoding("UTF-8");
        
        // 检查医生登录状态
        HttpSession session = request.getSession();
        Doctors doctor = (Doctors) session.getAttribute("doctor");
        
        if (doctor == null) {
            // 未登录，重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        try {
            // 获取分页参数
            Integer pageSize = 10;
            Integer pageNum = 1;
            String page = request.getParameter("page");
            if (page != null && page.length() != 0) {
                pageNum = Integer.parseInt(page);
            }
            
            // 获取时间范围参数
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            
            Date startDate = null;
            Date endDate = null;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            if (startDateStr != null && !startDateStr.trim().isEmpty()) {
                try {
                    startDate = sdf.parse(startDateStr);
                } catch (ParseException e) {
                    // 日期格式错误，忽略
                }
            }
            
            if (endDateStr != null && !endDateStr.trim().isEmpty()) {
                try {
                    endDate = sdf.parse(endDateStr);
                    // 设置结束时间为当天的23:59:59
                    endDate = new Date(endDate.getTime() + 24 * 60 * 60 * 1000 - 1);
                } catch (ParseException e) {
                    // 日期格式错误，忽略
                }
            }
            
            // 创建咨询Service对象
            ConsultationService consultationService = new ConsultationServiceImpl();
            
            // 分页查询当前医生的咨询记录
            PageInfo<Consultation> pageInfo;
            if (startDate != null || endDate != null) {
                // 按时间范围查询
                pageInfo = consultationService.getConsultationsByDoctorIdAndDateRange(
                        doctor.getDoctorId(), startDate, endDate, pageNum, pageSize);
            } else {
                // 查询所有
                pageInfo = consultationService.getConsultationsByDoctorIdAndPage(
                        doctor.getDoctorId(), pageNum, pageSize);
            }
            
            // 存储结果到请求域
            request.setAttribute("pageInfo", pageInfo);
            request.setAttribute("doctor", doctor);
            request.setAttribute("startDate", startDateStr);
            request.setAttribute("endDate", endDateStr);
            
            // 转发到诊断记录页面
            request.getRequestDispatcher("/doctor/diagnosis.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "页码格式错误");
            request.getRequestDispatcher("/doctor/diagnosis.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            request.getRequestDispatcher("/doctor/diagnosis.jsp").forward(request, response);
        }
    }
} 