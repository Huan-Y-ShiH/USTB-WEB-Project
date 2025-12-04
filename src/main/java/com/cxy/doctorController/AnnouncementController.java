package com.cxy.doctorController;

import com.cxy.pojo.Announcement;
import com.cxy.service.AnnouncementService;
import com.cxy.service.impl.AnnouncementServiceImpl;
import com.github.pagehelper.PageInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/doctor/announcement.do")
public class AnnouncementController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer pageSize = 5;
        Integer pageNum = 1;
        String page = request.getParameter("page");
        if(page != null && page.length() > 0){
            pageNum = Integer.parseInt(page);
        }
        AnnouncementService announcementService = new AnnouncementServiceImpl();
        PageInfo<Announcement> pageInfo = announcementService.getAnnouncements(pageNum, pageSize);
        request.setAttribute("pageInfo",pageInfo);
        request.getRequestDispatcher("/doctor/announcement.jsp").forward(request,response);
    }
}