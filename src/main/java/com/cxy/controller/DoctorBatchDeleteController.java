package com.cxy.controller;

import com.cxy.service.DoctorsService;
import com.cxy.service.impl.DoctorsServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author 陈翔宇
 * Date  2025/7/15
 */
@WebServlet("/manager/batchDeleteDoctor.do")
public class DoctorBatchDeleteController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String[] doctorIds = request.getParameterValues("doctorId");
        if (doctorIds == null || doctorIds.length == 0) {
            response.sendRedirect(request.getContextPath() + "/manager/doctorsSearch.do");
            return;
        }

        List<Integer> ids = Arrays.stream(doctorIds)
                .map(Integer::parseInt)
                .collect(Collectors.toList());

        DoctorsService doctorsService = new DoctorsServiceImpl();
        doctorsService.deleteDoctorsByIds(ids);

        response.sendRedirect(request.getContextPath() + "/manager/doctorsSearch.do");
    }
}