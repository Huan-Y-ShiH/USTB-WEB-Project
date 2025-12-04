package com.cxy.controller;

import com.cxy.Vo.ScheduleSearchVO;
import com.cxy.pojo.Schedule;
import com.cxy.service.ScheduleService;
import com.cxy.service.impl.ScheduleServiceImpl;
import com.github.pagehelper.PageInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author 黄江涛
 * Date  2025/7/15 16:55
 */
@WebServlet("/manager/scheduleSearch.do")
public class ScheduleSearchController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer pageSize = 5;
        Integer pageNum = 1;
        String page = request.getParameter("page");
        if (page!=null && page.length()>0){
            pageNum = Integer.parseInt(page);
        }
        Integer departmentId = null;
        Integer departmentPid = 0;

        Date date = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String dateStr = request.getParameter("queryDate");
        if (dateStr!=null && dateStr.length()>0){
            try {
                date = sdf.parse(dateStr);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        }

        String strDepartmentFirstId = request.getParameter("departmentFirstId");
        String strDepartmentSecondId = request.getParameter("departmentSecondId");
        if (strDepartmentFirstId!=null && strDepartmentFirstId.length()>0){
            departmentId = Integer.parseInt(strDepartmentFirstId);
            if (strDepartmentSecondId!=null && strDepartmentSecondId.length()>0){
                departmentPid = departmentId;
                departmentId = Integer.parseInt(strDepartmentSecondId);
            }
        }
        ScheduleSearchVO searchVO = new ScheduleSearchVO(departmentId,departmentPid,date);
        ScheduleService scheduleService = new ScheduleServiceImpl();
        PageInfo<Schedule> pageInfo = scheduleService.getScheduleBySearchAndPage(searchVO,pageNum,pageSize);
        request.setAttribute("pageInfo",pageInfo);
        request.getRequestDispatcher("/manager/scheduleList.jsp").forward(request,response);
    }
}
