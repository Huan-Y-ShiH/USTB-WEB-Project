package com.cxy.doctorController;

import com.cxy.pojo.DoctorSchedule;
import com.cxy.pojo.Doctors;
import com.cxy.service.DoctorScheduleService;
import com.cxy.service.impl.DoctorScheduleServiceImpl;

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
import java.util.List;

/**
 * 科室出诊查询控制器
 * @author 王知涵
 * Date  2025/1/10 18:40
 */
@WebServlet("/doctor/departmentSchedule.do")
public class DoctorScheduleController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
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
            // 获取查询参数
            String queryType = request.getParameter("type"); // thisweek, nextweek, custom
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            
            // 创建排班Service对象
            DoctorScheduleService scheduleService = new DoctorScheduleServiceImpl();
            List<DoctorSchedule> scheduleList = null;
            
            // 获取医生所在科室ID
            Integer departmentId = sessionDoctor.getDepartmentId();
            
            if ("thisweek".equals(queryType) || queryType == null) {
                // 查询本周排班（默认）
                scheduleList = scheduleService.getThisWeekScheduleByDepartment(departmentId);
                request.setAttribute("queryType", "thisweek");
                request.setAttribute("queryTypeText", "本周");
            } else if ("nextweek".equals(queryType)) {
                // 查询下周排班
                scheduleList = scheduleService.getNextWeekScheduleByDepartment(departmentId);
                request.setAttribute("queryType", "nextweek");
                request.setAttribute("queryTypeText", "下周");
            } else if ("custom".equals(queryType)) {
                // 自定义时间范围查询
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date startDate = null;
                Date endDate = null;
                
                if (startDateStr != null && !startDateStr.trim().isEmpty()) {
                    startDate = sdf.parse(startDateStr);
                }
                if (endDateStr != null && !endDateStr.trim().isEmpty()) {
                    endDate = sdf.parse(endDateStr);
                }
                
                scheduleList = scheduleService.getScheduleByDepartment(departmentId, startDate, endDate);
                request.setAttribute("queryType", "custom");
                request.setAttribute("queryTypeText", "自定义时间");
                request.setAttribute("startDate", startDateStr);
                request.setAttribute("endDate", endDateStr);
            }
            
            // 设置返回数据
            request.setAttribute("scheduleList", scheduleList);
            request.setAttribute("departmentName", sessionDoctor.getDepartments().getDepartmentName());
            
            // 跳转到排班显示页面
            request.getRequestDispatcher("/doctor/departmentSchedule.jsp").forward(request, response);
            
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "日期格式错误，请使用yyyy-MM-dd格式");
            request.getRequestDispatcher("/doctor/departmentSchedule.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            request.getRequestDispatcher("/doctor/departmentSchedule.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 