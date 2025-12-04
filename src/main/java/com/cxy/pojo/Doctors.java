package com.cxy.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @author 陈翔宇
 * Date  2025/7/9 15:16
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Doctors {
    private Integer doctorId;
    //doctor_id	int
    private String jobNumber;
    //job_number	varchar
    private String password;
    //password	varchar
    private String name;
    //name	varchar
    private String avatar;
    //avatar	varchar
    private String phone;
    //phone	varchar
    private String email;
    //email	varchar
    private String introduction;
    //introduction	text
    private Double registrationFee;
    //registration_fee	decimal
    private Date entryDate;
    //entry_date	date
    private Integer departmentId;
    //department_id	int
    private Integer professionalTitleId;
    //professional_title_id	int
    private Integer state;
    //state	int
    private Departments departments;
    private ProfessionalTitles titles;
}
