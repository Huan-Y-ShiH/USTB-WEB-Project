package com.cxy.controller;

import com.cxy.service.DoctorsService;
import com.cxy.service.ScheduleService;
import com.cxy.service.impl.DoctorsServiceImpl;
import com.cxy.service.impl.ScheduleServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/17 23:06
 */
@WebServlet("/manager/deleteDoctors.do")
public class DoctorsDeleteController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

// 获取选中的医生ID数组
        String[] doctorIds = request.getParameterValues("doctorIds");
        System.out.println("--------------"+doctorIds);

        if (doctorIds == null || doctorIds.length == 0) {
            request.setAttribute("errorMsg", "请选择要删除的医生");
            request.getRequestDispatcher("/manager/doctorsSearch.do").forward(request, response);
            return;
        }

        DoctorsService doctorsService = new DoctorsServiceImpl();
        ScheduleService scheduleService = new ScheduleServiceImpl();

        try {
            List<Integer> ids = new ArrayList<>();
            for (String id : doctorIds) {
                ids.add(Integer.parseInt(id));
            }

// 批量删除相关排班
            scheduleService.delSchedulesByDoctorIds(ids);

// 批量删除医生
            doctorsService.deleteDoctors(ids);

// 重定向回原页面（保持搜索条件）
            String queryString = request.getQueryString();
            response.sendRedirect(request.getContextPath() + "/manager/doctorsSearch.do?" + queryString);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "删除失败: " + e.getMessage());
            request.getRequestDispatcher("/manager/doctorsSearch.do").forward(request, response);
        }
    }
}