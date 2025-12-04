package com.cxy.service.impl;

import com.cxy.mapper.AnnouncementMapper;
import com.cxy.pojo.Announcement;
import com.cxy.service.AnnouncementService;
import com.cxy.util.SqlSessionUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.util.List;

public class AnnouncementServiceImpl implements AnnouncementService {

    @Override
    public PageInfo<Announcement> getAnnouncements(int pageNum, int pageSize) {
        try {
            AnnouncementMapper mapper = SqlSessionUtil.getSession().getMapper(AnnouncementMapper.class);
            PageHelper.startPage(pageNum, pageSize);
            List<Announcement> list = mapper.getAllAnnouncements();
            return new PageInfo<>(list);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public void addAnnouncement(Announcement announcement) {
        try {
            AnnouncementMapper mapper = SqlSessionUtil.getSession().getMapper(AnnouncementMapper.class);
            mapper.addAnnouncement(announcement);
            SqlSessionUtil.commit();
        } catch (Exception e) {
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }

    @Override
    public void deleteAnnouncement(Integer id) {
        try {
            AnnouncementMapper mapper = SqlSessionUtil.getSession().getMapper(AnnouncementMapper.class);
            mapper.deleteAnnouncementById(id);
            SqlSessionUtil.commit();
        } catch (Exception e) {
            SqlSessionUtil.rollback();
            throw new RuntimeException(e);
        } finally {
            SqlSessionUtil.closeSession();
        }
    }
}