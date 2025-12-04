package com.cxy.doctorController;

import com.cxy.pojo.Consultation;
import com.cxy.pojo.Doctors;
import com.cxy.pojo.Patients;
import com.cxy.service.ConsultationService;
import com.cxy.service.PatientsService;
import com.cxy.service.impl.ConsultationServiceImpl;
import com.cxy.service.impl.PatientsServiceImpl;
import com.github.pagehelper.PageInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

/**
 * 患者咨询记录管理控制器
 * @author 王知涵
 * Date  2025/1/10 23:30
 */
@WebServlet("/doctor/patientConsultations.do")
public class PatientConsultationsController extends HttpServlet {
    
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
            ConsultationService consultationService = new ConsultationServiceImpl();
            
            // 查询患者信息
            Patients patient = patientsService.getPatientById(patientId);
            if (patient == null) {
                request.setAttribute("errorMessage", "患者不存在");
                request.getRequestDispatcher("/doctor/patients.do").forward(request, response);
                return;
            }
            
            // 分页查询患者的咨询记录
            PageInfo<Consultation> pageInfo = consultationService.getConsultationsByPatientIdAndPage(
                    patientId, pageNum, pageSize);
            
            // 存储结果到请求域
            request.setAttribute("patient", patient);
            request.setAttribute("pageInfo", pageInfo);
            request.setAttribute("doctor", doctor);
            
            // 转发到患者咨询记录页面
            request.getRequestDispatcher("/doctor/patientConsultations.jsp").forward(request, response);
            
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
            // 添加咨询记录
            addConsultation(request, response, doctor);
        } else if ("delete".equals(action)) {
            // 删除咨询记录
            deleteConsultation(request, response, doctor);
        } else {
            // 默认查看
            doGet(request, response);
        }
    }
    
    /**
     * 添加咨询记录
     */
    private void addConsultation(HttpServletRequest request, HttpServletResponse response, Doctors doctor) 
            throws ServletException, IOException {
        
        try {
            // 获取参数
            String patientIdStr = request.getParameter("patientId");
            String medicalAdviceCase = request.getParameter("medicalAdviceCase");
            
            if (patientIdStr == null || patientIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "患者ID不能为空");
                doGet(request, response);
                return;
            }
            
            if (medicalAdviceCase == null || medicalAdviceCase.trim().isEmpty()) {
                request.setAttribute("errorMessage", "医疗建议不能为空");
                doGet(request, response);
                return;
            }
            
            Integer patientId = Integer.parseInt(patientIdStr);
            
            // 创建咨询记录对象
            Consultation consultation = new Consultation();
            consultation.setPatientId(patientId);
            consultation.setDoctorId(doctor.getDoctorId());
            consultation.setConsultationTime(new Date());
            consultation.setMedicalAdviceCase(medicalAdviceCase.trim());
            // is_hospital_registered 和 is_hospitalized 保持默认值（false）
            consultation.setIsHospitalRegistered(false);
            consultation.setIsHospitalized(false);
            
            // 保存咨询记录
            ConsultationService consultationService = new ConsultationServiceImpl();
            boolean result = consultationService.addConsultation(consultation);
            
            if (result) {
                // 添加成功，重定向回列表页面
                response.sendRedirect(request.getContextPath() + "/doctor/patientConsultations.do?patientId=" + patientId + "&message=添加成功");
            } else {
                request.setAttribute("errorMessage", "添加咨询记录失败");
                doGet(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "患者ID格式错误");
            doGet(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            doGet(request, response);
        }
    }
    
    /**
     * 删除咨询记录
     */
    private void deleteConsultation(HttpServletRequest request, HttpServletResponse response, Doctors doctor) 
            throws ServletException, IOException {
        
        try {
            // 获取参数
            String consultationIdStr = request.getParameter("consultationId");
            String patientIdStr = request.getParameter("patientId");
            
            if (consultationIdStr == null || consultationIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "咨询记录ID不能为空");
                doGet(request, response);
                return;
            }
            
            if (patientIdStr == null || patientIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "患者ID不能为空");
                doGet(request, response);
                return;
            }
            
            Integer consultationId = Integer.parseInt(consultationIdStr);
            Integer patientId = Integer.parseInt(patientIdStr);
            
            // 验证咨询记录是否属于当前医生
            ConsultationService consultationService = new ConsultationServiceImpl();
            Consultation consultation = consultationService.getConsultationById(consultationId);
            
            if (consultation == null) {
                request.setAttribute("errorMessage", "咨询记录不存在");
                doGet(request, response);
                return;
            }
            
            if (!consultation.getDoctorId().equals(doctor.getDoctorId())) {
                request.setAttribute("errorMessage", "您只能删除自己的咨询记录");
                doGet(request, response);
                return;
            }
            
            // 删除咨询记录
            boolean result = consultationService.deleteConsultation(consultationId);
            
            if (result) {
                // 删除成功，重定向回列表页面
                response.sendRedirect(request.getContextPath() + "/doctor/patientConsultations.do?patientId=" + patientId + "&message=删除成功");
            } else {
                request.setAttribute("errorMessage", "删除咨询记录失败");
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