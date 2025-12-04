package com.cxy.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Announcement {
    private Integer announcementId;
    private String title;
    private String imgUrl;
    private String content;
    private Date creationTime;
    private String creator;
}