package com.cxy.service;

import com.cxy.pojo.Announcement;
import com.github.pagehelper.PageInfo;

public interface AnnouncementService {

    PageInfo<Announcement> getAnnouncements(int pageNum, int pageSize);

    void addAnnouncement(Announcement announcement);

    void deleteAnnouncement(Integer id);
}