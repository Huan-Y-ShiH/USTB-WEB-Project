package com.cxy.patientController;

import com.cxy.pojo.Doctors;
import com.cxy.service.DoctorsService;
import com.cxy.service.impl.DoctorsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/doctorsByDepartment.do")
public class DoctorsByDepartmentController extends HttpServlet {
    private DoctorsService doctorsService = new DoctorsServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer patientId = (Integer) session.getAttribute("patientId");
        
        if (patientId == null) {
            response.sendRedirect(request.getContextPath() + "/user/userLogin.jsp");
            return;
        }

        try {
            String departmentIdStr = request.getParameter("departmentId");
            if (departmentIdStr == null || departmentIdStr.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\":\"科室ID不能为空\"}");
                return;
            }

            Integer departmentId = Integer.parseInt(departmentIdStr);
            List<Doctors> doctors = doctorsService.getDoctorsByDepartmentId(departmentId);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // 手动拼接JSON
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < doctors.size(); i++) {
                Doctors doctor = doctors.get(i);
                json.append("{")
                        .append("\"doctorId\":").append(doctor.getDoctorId()).append(",")
                        .append("\"name\":\"").append(doctor.getName()).append("\"");

                // 最后一个元素不加逗号
                if (i < doctors.size() - 1) {
                    json.append("},");
                } else {
                    json.append("}");
                }
            }
            json.append("]");

            response.getWriter().write(json.toString());
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"科室ID格式错误\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"查询失败：" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 