package com.cxy.controller;

import com.cxy.pojo.Announcement;
import com.cxy.service.AnnouncementService;
import com.cxy.service.impl.AnnouncementServiceImpl;
import com.github.pagehelper.PageInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/manager/announcement.do")
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
        request.getRequestDispatcher("/manager/announcementList.jsp").forward(request,response);
    }
}