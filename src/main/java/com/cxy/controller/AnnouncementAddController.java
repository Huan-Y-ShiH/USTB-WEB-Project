package com.cxy.controller;

import com.cxy.pojo.Announcement;
import com.cxy.service.AnnouncementService;
import com.cxy.service.impl.AnnouncementServiceImpl;
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
import java.util.UUID;

/**
 * @author 陈翔宇
 * Date  2025/7/15 16:30
 */
@WebServlet("/manager/addAnnouncement.do")
@MultipartConfig
public class AnnouncementAddController extends HttpServlet {

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
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
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String creator = request.getParameter("creator");

        // 处理日期类型
        String creationTimeStr = request.getParameter("creationTime");
        Date creationTime = null;
        try {
            creationTime = DATE_FORMAT.parse(creationTimeStr);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }

        // 创建Announcement对象
        Announcement announcement = new Announcement();
        announcement.setTitle(title);
        announcement.setContent(content);
        announcement.setCreator(creator);

        announcement.setImgUrl("upload/" + newFileName);
        announcement.setCreationTime(creationTime);

        // 保存Announcement信息
        AnnouncementService  announcementService = new AnnouncementServiceImpl();
        announcementService.addAnnouncement(announcement);

        // 重定向到Announcement列表
        response.sendRedirect(request.getContextPath() + "/manager/announcement.do");
    }

}