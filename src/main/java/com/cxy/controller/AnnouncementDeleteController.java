package com.cxy.controller;

import com.cxy.service.AnnouncementService;
import com.cxy.service.impl.AnnouncementServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author 陈翔宇
 * Date  2025/7/15 19:48
 */
@WebServlet("/manager/deleteAnnouncement.do")
public class AnnouncementDeleteController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取要删除的公告ID
        Integer id = Integer.parseInt(request.getParameter("id"));

        // 调用服务层删除公告
        AnnouncementService announcementService = new AnnouncementServiceImpl();
        announcementService.deleteAnnouncement(id);

        // 删除成功后重定向到公告列表
        response.sendRedirect(request.getContextPath() + "/manager/announcement.do");
    }
}

