package com.cxy.patientController;

import com.cxy.Vo.PatientSearchVo;
import com.cxy.pojo.Appointments;
import com.cxy.service.UsersAppointmentsService;
import com.cxy.service.impl.UsersAppointmentsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/appointmentSearch.do")
public class AppointmentSearchController extends HttpServlet {
    private UsersAppointmentsService usersAppointmentsService = new UsersAppointmentsServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");
        
        if (patientId == null) {
            response.sendRedirect(request.getContextPath() + "/user/userLogin.jsp");
            return;
        }

        // 获取搜索参数
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String status = request.getParameter("status");
        String doctorName = request.getParameter("doctorName");
        String departmentName = request.getParameter("departmentName");
        
        // 分页参数
        String pageStr = request.getParameter("page");
        String sizeStr = request.getParameter("size");
        int page = pageStr != null ? Integer.parseInt(pageStr) : 1;
        int size = sizeStr != null ? Integer.parseInt(sizeStr) : 10;
        
        // 构建搜索条件
        PatientSearchVo searchVo = new PatientSearchVo();
        searchVo.setPatientId(patientId);
        searchVo.setStartDate(startDate);
        searchVo.setEndDate(endDate);
        searchVo.setStatus(status);
        searchVo.setDoctorName(doctorName);
        searchVo.setDepartmentName(departmentName);
        searchVo.setPage(page);
        searchVo.setSize(size);
        
        // 查询预约列表
        List<Appointments> appointments = usersAppointmentsService.searchAppointments(searchVo);
        int total = usersAppointmentsService.getAppointmentCount(searchVo);
        
        // 计算总页数
        int totalPages = (int) Math.ceil((double) total / size);
        
        // 设置属性
        request.setAttribute("appointments", appointments);
        request.setAttribute("searchVo", searchVo);
        request.setAttribute("total", total);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        
        // 转发到查询页面
        request.getRequestDispatcher("/user/appointmentSearch.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 