package com.cxy.controller;

import com.cxy.service.ScheduleService;
import com.cxy.service.impl.ScheduleServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * @author 黄江涛
 * Date  2025/7/17 13:24
 */
@WebServlet("/manager/getAvailableShiftTimes.do")
public class AvailableShiftTimesController extends HttpServlet {
    private ScheduleService scheduleService = new ScheduleServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            Integer doctorId = Integer.parseInt(request.getParameter("doctorId"));
            String dateStr = request.getParameter("date");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = sdf.parse(dateStr);

            // 获取已安排的时间段
            List<String> bookedTimes = scheduleService.getBookedShiftTimes(doctorId, date);

            // 所有可能的时间段
            List<String> allTimes = Arrays.asList("上午", "下午");

            // 计算可用时间段
            List<String> availableTimes = new ArrayList<>();
            if (bookedTimes.size()!=0){
                for (String time : allTimes) {
                    if (!bookedTimes.contains(time)) {
                        availableTimes.add(time);
                    }
                }
            }else {
                availableTimes = allTimes;
            }

            // 手动拼接JSON数组
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < availableTimes.size(); i++) {
                json.append("\"").append(availableTimes.get(i)).append("\"");
                if (i < availableTimes.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");

            out.print(json.toString());
        } catch (NumberFormatException e) {
            out.print("{\"error\":\"无效的医生ID\"}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } catch (ParseException e) {
            out.print("{\"error\":\"日期格式错误，请使用yyyy-MM-dd格式\"}");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            out.print("{\"error\":\"服务器错误: " + e.getMessage() + "\"}");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
