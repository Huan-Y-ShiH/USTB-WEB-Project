package com.cxy.doctorController;

import com.cxy.pojo.Doctors;
import com.cxy.pojo.Hospitalization;
import com.cxy.pojo.Patients;
import com.cxy.service.HospitalizationService;
import com.cxy.service.PatientsService;
import com.cxy.service.impl.HospitalizationServiceImpl;
import com.cxy.service.impl.PatientsServiceImpl;
import com.github.pagehelper.PageInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;

/**
 * 患者住院管理控制器
 * @author 王知涵
 * Date  2025/1/11 10:20
 */
@WebServlet("/doctor/patientHospitalizations.do")
public class PatientHospitalizationController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 设置请求编码
        request.setCharacterEncoding("UTF-8");
        
        // 检查医生登录状态
        HttpSession session = request.getSession();
        Doctors doctor = (Doctors) session.getAttribute("doctor");
        
        if (doctor == null) {
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
            
            // 获取分页参数
            Integer pageSize = 10;
            Integer pageNum = 1;
            String page = request.getParameter("page");
            if (page != null && page.length() != 0) {
                pageNum = Integer.parseInt(page);
            }
            
            // 创建Service对象
            PatientsService patientsService = new PatientsServiceImpl();
            HospitalizationService hospitalizationService = new HospitalizationServiceImpl();
            
            // 查询患者信息
            Patients patient = patientsService.getPatientById(patientId);
            if (patient == null) {
                request.setAttribute("errorMessage", "患者不存在");
                request.getRequestDispatcher("/doctor/patients.do").forward(request, response);
                return;
            }
            
            // 分页查询患者的住院记录
            PageInfo<Hospitalization> pageInfo = hospitalizationService.getHospitalizationsByPatientIdAndPage(
                    patientId, pageNum, pageSize);
            
            // 存储结果到请求域
            request.setAttribute("patient", patient);
            request.setAttribute("pageInfo", pageInfo);
            request.setAttribute("doctor", doctor);
            
            // 转发到患者住院记录页面
            request.getRequestDispatcher("/doctor/patientHospitalizations.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "参数格式错误");
            request.getRequestDispatcher("/doctor/patients.do").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            request.getRequestDispatcher("/doctor/patients.do").forward(request, response);
        }
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
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // 获取操作类型
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            // 添加住院记录
            addHospitalization(request, response, doctor);
        } else if ("update".equals(action)) {
            // 更新住院记录
            updateHospitalization(request, response, doctor);
        } else if ("updateStatus".equals(action)) {
            // 更新住院状态并同步咨询记录
            updateHospitalizationStatus(request, response, doctor);
        } else if ("delete".equals(action)) {
            // 删除住院记录
            deleteHospitalization(request, response, doctor);
        } else {
            // 默认查看
            doGet(request, response);
        }
    }
    
    /**
     * 添加住院记录
     */
    private void addHospitalization(HttpServletRequest request, HttpServletResponse response, Doctors doctor) 
            throws ServletException, IOException {
        
        try {
            // 获取参数
            String patientIdStr = request.getParameter("patientId");
            String roomNumber = request.getParameter("roomNumber");
            String costStr = request.getParameter("cost");
            String paymentStatus = request.getParameter("paymentStatus");
            String isInsuredStr = request.getParameter("isInsured");
            String hospitalizationStatus = request.getParameter("hospitalizationStatus");
            
            if (patientIdStr == null || patientIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "患者ID不能为空");
                doGet(request, response);
                return;
            }
            
            Integer patientId = Integer.parseInt(patientIdStr);
            
            // 创建住院记录对象
            Hospitalization hospitalization = new Hospitalization();
            hospitalization.setPatientId(patientId);
            hospitalization.setRoomNumber(roomNumber);
            
            if (costStr != null && !costStr.trim().isEmpty()) {
                hospitalization.setCost(new BigDecimal(costStr));
            }
            
            hospitalization.setPaymentStatus(paymentStatus != null ? paymentStatus : "unpaid");
            hospitalization.setIsInsured(Boolean.parseBoolean(isInsuredStr));
            hospitalization.setHospitalizationStatus(hospitalizationStatus != null ? hospitalizationStatus : "admitted");
            
            // 保存住院记录
            HospitalizationService hospitalizationService = new HospitalizationServiceImpl();
            boolean result = hospitalizationService.addHospitalization(hospitalization);
            
            if (result) {
                // 添加成功，重定向回列表页面
                response.sendRedirect(request.getContextPath() + "/doctor/patientHospitalizations.do?patientId=" + patientId + "&message=添加成功");
            } else {
                request.setAttribute("errorMessage", "添加住院记录失败");
                doGet(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "数据格式错误");
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            doGet(request, response);
        }
    }
    
    /**
     * 更新住院记录
     */
    private void updateHospitalization(HttpServletRequest request, HttpServletResponse response, Doctors doctor) 
            throws ServletException, IOException {
        
        try {
            // 获取参数
            String hospitalizationIdStr = request.getParameter("hospitalizationId");
            String patientIdStr = request.getParameter("patientId");
            String roomNumber = request.getParameter("roomNumber");
            String costStr = request.getParameter("cost");
            String paymentStatus = request.getParameter("paymentStatus");
            String isInsuredStr = request.getParameter("isInsured");
            String hospitalizationStatus = request.getParameter("hospitalizationStatus");
            
            Integer hospitalizationId = Integer.parseInt(hospitalizationIdStr);
            Integer patientId = Integer.parseInt(patientIdStr);
            
            // 创建住院记录对象
            Hospitalization hospitalization = new Hospitalization();
            hospitalization.setHospitalizationId(hospitalizationId);
            hospitalization.setPatientId(patientId);
            hospitalization.setRoomNumber(roomNumber);
            
            if (costStr != null && !costStr.trim().isEmpty()) {
                hospitalization.setCost(new BigDecimal(costStr));
            }
            
            hospitalization.setPaymentStatus(paymentStatus);
            hospitalization.setIsInsured(Boolean.parseBoolean(isInsuredStr));
            hospitalization.setHospitalizationStatus(hospitalizationStatus);
            
            // 更新住院记录
            HospitalizationService hospitalizationService = new HospitalizationServiceImpl();
            boolean result = hospitalizationService.updateHospitalization(hospitalization);
            
            if (result) {
                // 更新成功，重定向回列表页面
                response.sendRedirect(request.getContextPath() + "/doctor/patientHospitalizations.do?patientId=" + patientId + "&message=更新成功");
            } else {
                request.setAttribute("errorMessage", "更新住院记录失败");
                doGet(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "数据格式错误");
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            doGet(request, response);
        }
    }
    
    /**
     * 更新住院状态并同步咨询记录
     */
    private void updateHospitalizationStatus(HttpServletRequest request, HttpServletResponse response, Doctors doctor) 
            throws ServletException, IOException {
        
        try {
            String hospitalizationIdStr = request.getParameter("hospitalizationId");
            String patientIdStr = request.getParameter("patientId");
            String newStatus = request.getParameter("newStatus");
            
            Integer hospitalizationId = Integer.parseInt(hospitalizationIdStr);
            Integer patientId = Integer.parseInt(patientIdStr);
            
            HospitalizationService hospitalizationService = new HospitalizationServiceImpl();
            boolean result = hospitalizationService.updateHospitalizationStatusAndSyncConsultation(hospitalizationId, newStatus);
            
            if (result) {
                response.sendRedirect(request.getContextPath() + "/doctor/patientHospitalizations.do?patientId=" + patientId + "&message=状态更新成功，已同步更新咨询记录");
            } else {
                request.setAttribute("errorMessage", "状态更新失败");
                doGet(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "参数格式错误");
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            doGet(request, response);
        }
    }
    
    /**
     * 删除住院记录
     */
    private void deleteHospitalization(HttpServletRequest request, HttpServletResponse response, Doctors doctor) 
            throws ServletException, IOException {
        
        try {
            String hospitalizationIdStr = request.getParameter("hospitalizationId");
            String patientIdStr = request.getParameter("patientId");
            
            Integer hospitalizationId = Integer.parseInt(hospitalizationIdStr);
            Integer patientId = Integer.parseInt(patientIdStr);
            
            HospitalizationService hospitalizationService = new HospitalizationServiceImpl();
            boolean result = hospitalizationService.deleteHospitalization(hospitalizationId);
            
            if (result) {
                response.sendRedirect(request.getContextPath() + "/doctor/patientHospitalizations.do?patientId=" + patientId + "&message=删除成功");
            } else {
                request.setAttribute("errorMessage", "删除失败");
                doGet(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "参数格式错误");
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            doGet(request, response);
        }
    }
} 