package com.cxy.controller;

import com.cxy.Vo.DoctorSearchVo;
import com.cxy.Vo.PatientSearchVo;
import com.cxy.pojo.Appointments;
import com.cxy.pojo.Departments;
import com.cxy.pojo.Doctors;
import com.cxy.pojo.Patients;
import com.cxy.service.*;
import com.cxy.service.impl.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 添加预约控制器（包括临时加号功能）
 * @author 陈翔宇
 * Date  2025/1/10 21:00
 */
@WebServlet("/manager/addAppointment.do")
public class AppointmentAddController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 加载科室数据
        DepartmentsService departmentsService = new DepartmentsServiceImpl();
        List<Departments> departmentsList = departmentsService.getDepartmentBySecond();
        request.setAttribute("departmentsList", departmentsList);
        
        // 加载医生数据
        AdminDoctorsService  adminDoctorsService = new AdminDoctorsServiceImpl();
        List<Doctors> doctorsList = adminDoctorsService.selectDoctorAll(new DoctorSearchVo());
        request.setAttribute("doctorsList", doctorsList);
        
        // 加载患者数据
        PatientsService patientsService = new PatientsServiceImpl();
        List<Patients> patientsList = patientsService.getPatientAll(new PatientSearchVo());
        request.setAttribute("patientsList", patientsList);
        
        // 跳转到添加预约页面
        request.getRequestDispatcher("/manager/addAppointment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 设置请求编码
        request.setCharacterEncoding("UTF-8");
        
        try {
            // 获取表单参数
            String patientIdStr = request.getParameter("patientId");
            String doctorIdStr = request.getParameter("doctorId");
            String appointmentDateStr = request.getParameter("appointmentDate");
            String appointmentTime = request.getParameter("appointmentTime");
            String isEmergency = request.getParameter("isEmergency"); // 是否为临时加号
            
            // 验证必要参数
            if (patientIdStr == null || patientIdStr.trim().isEmpty() ||
                doctorIdStr == null || doctorIdStr.trim().isEmpty() ||
                appointmentDateStr == null || appointmentDateStr.trim().isEmpty() ||
                appointmentTime == null || appointmentTime.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "请填写完整的预约信息");
                loadDataForForm(request);
                request.getRequestDispatcher("/manager/addAppointment.jsp").forward(request, response);
                return;
            }
            
            // 转换参数
            Integer patientId = Integer.parseInt(patientIdStr);
            Integer doctorId = Integer.parseInt(doctorIdStr);
            
            // 处理预约日期
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date appointmentDate = sdf.parse(appointmentDateStr);
            
            // 创建预约Service对象
            AppointmentsService appointmentsService = new AppointmentsServiceImpl();
            
            // 检查是否为临时加号
            boolean isEmergencyAdd = "1".equals(isEmergency);
            
            if (!isEmergencyAdd) {
                // 普通预约：检查该医生在指定日期时间的预约数量
                int existingCount = appointmentsService.getAppointmentCount(doctorId, appointmentDate, appointmentTime);
                
                // 设定每个时间段的最大预约数（可以根据实际需求调整）
                int maxAppointments = 20;
                if (existingCount >= maxAppointments) {
                    request.setAttribute("errorMessage", 
                        "该医生在 " + appointmentDateStr + " " + appointmentTime + " 的预约已满，您可以选择临时加号");
                    loadDataForForm(request);
                    request.getRequestDispatcher("/manager/addAppointment.jsp").forward(request, response);
                    return;
                }
            }
            
            // 创建预约对象
            Appointments appointment = new Appointments();
            appointment.setPatientId(patientId);
            appointment.setDoctorId(doctorId);
            appointment.setAppointmentDate(appointmentDate);
            appointment.setAppointmentTime(appointmentTime);
            appointment.setStatus("booked");
            appointment.setCreatetime(new Date());
            
            // 调用添加预约方法
            int result = appointmentsService.addAppointment(appointment);
            
            if (result > 0) {
                // 添加成功，重定向到预约列表页面
                String successMessage = isEmergencyAdd ? "临时加号成功！" : "预约添加成功！";
                response.sendRedirect(request.getContextPath() + "/manager/appointments.do?message=" + successMessage);
            } else {
                // 添加失败，返回添加页面并显示错误信息
                request.setAttribute("errorMessage", "预约添加失败，请重试");
                loadDataForForm(request);
                request.getRequestDispatcher("/manager/addAppointment.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "参数格式错误，请检查输入");
            loadDataForForm(request);
            request.getRequestDispatcher("/manager/addAppointment.jsp").forward(request, response);
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "日期格式错误，请使用yyyy-MM-dd格式");
            loadDataForForm(request);
            request.getRequestDispatcher("/manager/addAppointment.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            loadDataForForm(request);
            request.getRequestDispatcher("/manager/addAppointment.jsp").forward(request, response);
        }
    }
    
    /**
     * 加载表单所需的数据
     */
    private void loadDataForForm(HttpServletRequest request) {
        // 重新加载数据
        DepartmentsService departmentsService = new DepartmentsServiceImpl();
        List<Departments> departmentsList = departmentsService.getDepartmentBySecond();
        request.setAttribute("departmentsList", departmentsList);
        
        AdminDoctorsService  adminDoctorsService = new AdminDoctorsServiceImpl();
        List<Doctors> doctorsList = adminDoctorsService.selectDoctorAll(new DoctorSearchVo());
        request.setAttribute("doctorsList", doctorsList);
        
        PatientsService patientsService = new PatientsServiceImpl();
        List<Patients> patientsList = patientsService.getPatientAll(new PatientSearchVo());
        request.setAttribute("patientsList", patientsList);
    }
} 