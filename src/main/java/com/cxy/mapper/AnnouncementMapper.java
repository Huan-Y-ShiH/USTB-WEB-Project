package com.cxy.mapper;

import com.cxy.pojo.Announcement;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AnnouncementMapper {
    List<Announcement> getAllAnnouncements();

    void addAnnouncement(Announcement announcement);

    void deleteAnnouncementById(@Param("id") Integer id);
}