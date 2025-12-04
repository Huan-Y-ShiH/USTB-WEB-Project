package com.cxy.doctorController;

import com.cxy.Vo.PatientSearchVo;
import com.cxy.pojo.Appointments;
import com.cxy.pojo.Doctors;
import com.cxy.pojo.Patients;
import com.cxy.service.AppointmentsService;
import com.cxy.service.PatientsService;
import com.cxy.service.impl.AppointmentsServiceImpl;
import com.cxy.service.impl.PatientsServiceImpl;

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
 * 医生端临时加号控制器
 * @author 王知涵
 * Date  2025/1/10 22:00
 */
@WebServlet("/doctor/addAppointment.do")
public class DoctorAddAppointmentController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 检查医生登录状态
        HttpSession session = request.getSession();
        Doctors doctor = (Doctors) session.getAttribute("doctor");
        
        if (doctor == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // 加载患者数据
        PatientsService patientsService = new PatientsServiceImpl();
        List<Patients> patientsList = patientsService.getPatientAll(new PatientSearchVo());
        request.setAttribute("patientsList", patientsList);
        request.setAttribute("doctor", doctor);
        
        // 跳转到医生端添加预约页面
        request.getRequestDispatcher("/doctor/addAppointment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 检查医生登录状态
        HttpSession session = request.getSession();
        Doctors doctor = (Doctors) session.getAttribute("doctor");
        
        if (doctor == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // 设置请求编码
        request.setCharacterEncoding("UTF-8");
        
        try {
            // 获取表单参数
            String patientIdStr = request.getParameter("patientId");
            String appointmentDateStr = request.getParameter("appointmentDate");
            String appointmentTime = request.getParameter("appointmentTime");
            String patientName = request.getParameter("patientName");
            String patientPhone = request.getParameter("patientPhone");
            String useExistingPatient = request.getParameter("useExistingPatient");
            
            // 验证必要参数
            if (appointmentDateStr == null || appointmentDateStr.trim().isEmpty() ||
                appointmentTime == null || appointmentTime.trim().isEmpty()) {
                
                request.setAttribute("errorMessage", "请填写完整的预约信息");
                loadDataForForm(request, doctor);
                request.getRequestDispatcher("/doctor/addAppointment.jsp").forward(request, response);
                return;
            }
            
            Integer patientId = null;
            
            // 判断是选择现有患者还是临时患者
            if ("true".equals(useExistingPatient)) {
                // 使用现有患者
                if (patientIdStr == null || patientIdStr.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "请选择患者");
                    loadDataForForm(request, doctor);
                    request.getRequestDispatcher("/doctor/addAppointment.jsp").forward(request, response);
                    return;
                }
                patientId = Integer.parseInt(patientIdStr);
            } else {
                // 临时患者，验证姓名和电话
                if (patientName == null || patientName.trim().isEmpty() ||
                    patientPhone == null || patientPhone.trim().isEmpty()) {
                    
                    request.setAttribute("errorMessage", "临时患者请填写姓名和联系电话");
                    loadDataForForm(request, doctor);
                    request.getRequestDispatcher("/doctor/addAppointment.jsp").forward(request, response);
                    return;
                }
                
                // 查找是否已有同名同电话的患者
                PatientsService patientsService = new PatientsServiceImpl();
                PatientSearchVo searchVo = new PatientSearchVo();
                searchVo.setPatientName(patientName);
                searchVo.setPhone(patientPhone);
                List<Patients> existingPatients = patientsService.getPatientAll(searchVo);
                
                if (!existingPatients.isEmpty()) {
                    // 使用已存在的患者
                    patientId = existingPatients.get(0).getPatientId();
                } else {
                    // 这里简化处理，使用一个默认的患者ID（实际项目中应该创建新患者）
                    // 为了演示，我们暂时要求选择现有患者
                    request.setAttribute("errorMessage", "未找到该患者信息，请从现有患者中选择或联系管理员添加新患者");
                    loadDataForForm(request, doctor);
                    request.getRequestDispatcher("/doctor/addAppointment.jsp").forward(request, response);
                    return;
                }
            }
            
            // 处理预约日期
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date appointmentDate = sdf.parse(appointmentDateStr);
            
            // 检查日期是否为今天或未来
            java.util.Calendar calendar = java.util.Calendar.getInstance();
            calendar.set(java.util.Calendar.HOUR_OF_DAY, 0);
            calendar.set(java.util.Calendar.MINUTE, 0);
            calendar.set(java.util.Calendar.SECOND, 0);
            calendar.set(java.util.Calendar.MILLISECOND, 0);
            Date today = calendar.getTime();
            if (appointmentDate.before(today)) {
                request.setAttribute("errorMessage", "预约日期不能是过去的日期");
                loadDataForForm(request, doctor);
                request.getRequestDispatcher("/doctor/addAppointment.jsp").forward(request, response);
                return;
            }
            
            // 创建预约Service对象
            AppointmentsService appointmentsService = new AppointmentsServiceImpl();
            
            // 医生端的加号都是临时加号，不检查数量限制
            // 但我们仍然可以显示当前时间段的预约数量作为参考
            int existingCount = appointmentsService.getAppointmentCount(doctor.getDoctorId(), appointmentDate, appointmentTime);
            
            // 创建预约对象
            Appointments appointment = new Appointments();
            appointment.setPatientId(patientId);
            appointment.setDoctorId(doctor.getDoctorId()); // 医生只能为自己添加预约
            appointment.setAppointmentDate(appointmentDate);
            appointment.setAppointmentTime(appointmentTime);
            appointment.setStatus("booked");
            appointment.setCreatetime(new Date());
            
            // 调用添加预约方法
            int result = appointmentsService.addAppointment(appointment);
            
            if (result > 0) {
                // 添加成功，重定向到预约列表页面
                String successMessage = "临时加号成功！当前时间段共有 " + (existingCount + 1) + " 个预约";
                response.sendRedirect(request.getContextPath() + "/doctor/appointments.do?message=" + successMessage);
            } else {
                // 添加失败，返回添加页面并显示错误信息
                request.setAttribute("errorMessage", "临时加号失败，请重试");
                loadDataForForm(request, doctor);
                request.getRequestDispatcher("/doctor/addAppointment.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "参数格式错误，请检查输入");
            loadDataForForm(request, doctor);
            request.getRequestDispatcher("/doctor/addAppointment.jsp").forward(request, response);
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "日期格式错误，请使用正确的日期格式");
            loadDataForForm(request, doctor);
            request.getRequestDispatcher("/doctor/addAppointment.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "系统错误：" + e.getMessage());
            loadDataForForm(request, doctor);
            request.getRequestDispatcher("/doctor/addAppointment.jsp").forward(request, response);
        }
    }
    
    /**
     * 加载表单所需的数据
     */
    private void loadDataForForm(HttpServletRequest request, Doctors doctor) {
        // 重新加载患者数据
        PatientsService patientsService = new PatientsServiceImpl();
        List<Patients> patientsList = patientsService.getPatientAll(new PatientSearchVo());
        request.setAttribute("patientsList", patientsList);
        request.setAttribute("doctor", doctor);
    }
} 