package com.cxy.doctorController;

import com.cxy.Vo.PatientSearchVo;
import com.cxy.pojo.Doctors;
import com.cxy.pojo.Patients;
import com.cxy.service.PatientsService;
import com.cxy.service.impl.PatientsServiceImpl;
import com.github.pagehelper.PageInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 患者管理控制器
 * @author 王知涵
 * Date  2025/1/10 20:10
 */
@WebServlet("/doctor/patients.do")
public class PatientsController extends HttpServlet {
    
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
            // 获取查询参数
            String action = request.getParameter("action"); // all, mypatients, department
            String patientName = request.getParameter("patientName");
            String idCardNumber = request.getParameter("idCardNumber");
            String phone = request.getParameter("phone");
            String minBalanceStr = request.getParameter("minBalance");
            String maxBalanceStr = request.getParameter("maxBalance");
            String pageNumStr = request.getParameter("pageNum");
            
            // 构建搜索条件
            PatientSearchVo searchVo = new PatientSearchVo();
            searchVo.setPatientName(patientName);
            searchVo.setIdCardNumber(idCardNumber);
            searchVo.setPhone(phone);
            
            if (minBalanceStr != null && !minBalanceStr.trim().isEmpty()) {
                searchVo.setMinBalance(Double.parseDouble(minBalanceStr));
            }
            if (maxBalanceStr != null && !maxBalanceStr.trim().isEmpty()) {
                searchVo.setMaxBalance(Double.parseDouble(maxBalanceStr));
            }
            
            // 分页参数
            int pageNum = 1;
            if (pageNumStr != null && !pageNumStr.trim().isEmpty()) {
                pageNum = Integer.parseInt(pageNumStr);
            }
            int pageSize = 10; // 每页显示10条记录
            
            // 创建患者Service对象
            PatientsService patientsService = new PatientsServiceImpl();
            PageInfo<Patients> pageInfo = null;
            String queryTypeText = "";
            
            if ("mypatients".equals(action)) {
                // 查询我的患者（基于就诊记录）
                pageInfo = patientsService.getPatientsByDoctorAndPage(sessionDoctor.getDoctorId(), searchVo, pageNum, pageSize);
                queryTypeText = "我的患者";
            } else if ("department".equals(action)) {
                // 查询科室患者（基于就诊记录）
                pageInfo = patientsService.getPatientsByDepartmentAndPage(sessionDoctor.getDepartmentId(), searchVo, pageNum, pageSize);
                queryTypeText = "科室患者";
            } else {
                // 查询所有患者（默认）
                pageInfo = patientsService.getPatientsByPageAndSearch(searchVo, pageNum, pageSize);
                queryTypeText = "所有患者";
                action = "all";
            }
            
            // 设置返回数据
            request.setAttribute("pageInfo", pageInfo);
            request.setAttribute("searchVo", searchVo);
            request.setAttribute("action", action);
            request.setAttribute("queryTypeText", queryTypeText);
            request.setAttribute("departmentName", sessionDoctor.getDepartments().getDepartmentName());
            
            // 跳转到患者列表页面
            request.getRequestDispatcher("/doctor/patients.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "数字格式错误，请检查输入");
            request.getRequestDispatcher("/doctor/patients.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            request.getRequestDispatcher("/doctor/patients.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 