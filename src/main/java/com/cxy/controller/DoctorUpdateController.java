package com.cxy.controller;

import com.cxy.pojo.Departments;
import com.cxy.pojo.Doctors;
import com.cxy.pojo.ProfessionalTitles;
import com.cxy.service.DepartmentsService;
import com.cxy.service.DoctorsService;
import com.cxy.service.ProfessionalTitlesService;
import com.cxy.service.impl.DepartmentsServiceImpl;
import com.cxy.service.impl.DoctorsServiceImpl;
import com.cxy.service.impl.ProfessionalTitlesServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet("/manager/updateDoctor.do")
@MultipartConfig
public class DoctorUpdateController extends HttpServlet {
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    // 在DoctorUpdateController.java中添加doGet方法
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String name = request.getParameter("name");

            // 获取医生信息
            DoctorsService doctorService = new DoctorsServiceImpl();
            Doctors doctor = doctorService.getDoctorByName(name);

            // 获取科室和职称列表
            DepartmentsService departmentService = new DepartmentsServiceImpl();
            ProfessionalTitlesService titleService = new ProfessionalTitlesServiceImpl();

            List<Departments> departmentList = departmentService.getDepartmentBySecond();
            List<ProfessionalTitles> titleList = titleService.selectAll();

            request.setAttribute("doctor", doctor);
            request.setAttribute("departmentList", departmentList);
            request.setAttribute("titleList", titleList);

            request.getRequestDispatcher("/manager/updateDoctor.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("加载医生信息失败", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            // 获取医生姓名作为唯一标识
            String name = request.getParameter("name");

            // 处理上传的头像文件
            String avatarPath = null;
            Part part = request.getPart("imgFile");
            if (part != null && part.getSize() > 0) {
                String oldFileName = part.getSubmittedFileName();
                String fileExtension = oldFileName.substring(oldFileName.lastIndexOf("."));
                String newFileName = UUID.randomUUID().toString() + fileExtension;
                String savePath = this.getServletContext().getRealPath("/upload/");
                part.write(savePath + newFileName);
                avatarPath = "upload/" + newFileName;
            }

            // 获取表单参数
            String jobNumber = request.getParameter("jobNumber");
            String passWord = request.getParameter("passWord");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String introduction = request.getParameter("introduction");
            Double registrationFee = Double.parseDouble(request.getParameter("registrationFee"));

            // 处理日期类型
            Date entryDate = null;
            String entryDateStr = request.getParameter("entryDate");
            if (entryDateStr != null && !entryDateStr.isEmpty()) {
                entryDate = DATE_FORMAT.parse(entryDateStr);
            }

            Integer departmentId = Integer.parseInt(request.getParameter("departmentId"));
            Integer professionalTitleId = Integer.parseInt(request.getParameter("titleId"));

            // 创建Doctor对象
            Doctors doctor = new Doctors();
            doctor.setName(name); // 作为更新条件
            doctor.setJobNumber(jobNumber);
            doctor.setPassword(passWord);
            if (avatarPath != null) {
                doctor.setAvatar(avatarPath);
            }
            doctor.setPhone(phone);
            doctor.setEmail(email);
            doctor.setIntroduction(introduction);
            doctor.setRegistrationFee(registrationFee);
            doctor.setEntryDate(entryDate);
            doctor.setDepartmentId(departmentId);
            doctor.setProfessionalTitleId(professionalTitleId);

            // 更新医生信息
            DoctorsService doctorService = new DoctorsServiceImpl();
            doctorService.updateDoctor(doctor);

            // 重定向到医生列表
            response.sendRedirect(request.getContextPath() + "/manager/doctorsSearch.do");
        } catch (ParseException e) {
            throw new ServletException("日期格式错误", e);
        } catch (Exception e) {
            throw new ServletException("更新医生信息失败", e);
        }
    }
}