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
import com.cxy.util.SqlSessionUtil;

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

@WebServlet("/manager/addDoctor.do")
@MultipartConfig
public class DoctorAddController extends HttpServlet {

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取科室和职称列表
        DepartmentsService departmentService = new DepartmentsServiceImpl();
        ProfessionalTitlesService titleService = new ProfessionalTitlesServiceImpl();

        try {
            List<Departments> departmentList = departmentService.getDepartmentBySecond();
            List<ProfessionalTitles> titleList = titleService.selectAll();

            request.setAttribute("departmentList", departmentList);
            request.setAttribute("titleList", titleList);

            // 转发到添加页面
            request.getRequestDispatcher("/manager/addDoctor.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "加载数据失败: " + e.getMessage());
            request.getRequestDispatcher("/manager/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            request.setCharacterEncoding("UTF-8");

            // 处理上传的头像文件
            Part part = request.getPart("imgFile");
            String oldFileName = part.getSubmittedFileName();
            String fileExtension = oldFileName.substring(oldFileName.lastIndexOf("."));
            String newFileName = UUID.randomUUID().toString() + fileExtension;

            // 保存路径设置
            String savePath = this.getServletContext().getRealPath("/upload/");
            part.write(savePath + newFileName);

            // 获取表单参数
            String jobNumber = request.getParameter("jobNumber");
            String passWord = request.getParameter("passWord");
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String introduction = request.getParameter("introduction");
            Double registrationFee = Double.parseDouble(request.getParameter("registrationFee"));

            // 处理日期类型
            String entryDateStr = request.getParameter("entryDate");
            Date entryDate = null;
            try {
                entryDate = DATE_FORMAT.parse(entryDateStr);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }

            Integer departmentId = Integer.parseInt(request.getParameter("departmentId"));
            Integer professionalTitleId = Integer.parseInt(request.getParameter("titleId"));

            // 创建Doctor对象
            Doctors doctor = new Doctors();
            doctor.setJobNumber(jobNumber);
            doctor.setPassword(passWord);
            doctor.setName(name);
            doctor.setAvatar("upload/" + newFileName);
            doctor.setPhone(phone);
            doctor.setEmail(email);
            doctor.setIntroduction(introduction);
            doctor.setRegistrationFee(registrationFee);
            doctor.setEntryDate(entryDate);
            doctor.setDepartmentId(departmentId);
            doctor.setProfessionalTitleId(professionalTitleId);

            // 保存医生信息
            DoctorsService doctorService = new DoctorsServiceImpl();
            doctorService.addDoctor(doctor);

            // 重定向到医生列表
            response.sendRedirect(request.getContextPath() + "/manager/doctorsSearch.do");
    }
}