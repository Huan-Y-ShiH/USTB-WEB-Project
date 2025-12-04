package com.cxy.Listener;

import com.cxy.Vo.DoctorSearchVo;
import com.cxy.pojo.Departments;
import com.cxy.pojo.ProfessionalTitles;
import com.cxy.service.DepartmentsService;
import com.cxy.service.DoctorsService;
import com.cxy.service.ProfessionalTitlesService;
import com.cxy.service.impl.DepartmentsServiceImpl;
import com.cxy.service.impl.DoctorsServiceImpl;
import com.cxy.service.impl.ProfessionalTitlesServiceImpl;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.List;

/**
 * @author 陈翔宇
 * Date  2025/7/9 14:47
 */
@WebListener
public class ApplicationListener implements ServletContextListener {
    public ApplicationListener() {

    }

    @Override
    public void contextInitialized(ServletContextEvent sce){
        ServletContext application = sce.getServletContext();
        DepartmentsService departmentsService = new DepartmentsServiceImpl();
        ProfessionalTitlesService titlesService = new ProfessionalTitlesServiceImpl();
        DoctorsService doctorsService = new DoctorsServiceImpl();
        DoctorSearchVo searchVO = new DoctorSearchVo();
        List<Integer> allDoctorsId = doctorsService.getAllDoctorsId(searchVO);

        List<Departments> departmentsList = departmentsService.getDepartmentBySecond();
        List<ProfessionalTitles> titlesList = titlesService.selectAll();
        List<Departments> departmentAll = departmentsService.getAllDepartments();

        application.setAttribute("allDoctorIds",allDoctorsId);
        application.setAttribute("departmentsSecondList", departmentsList);
        application.setAttribute("departmentsFirstList",departmentAll);
        application.setAttribute("titlesList", titlesList);
    }


    @Override
    public void contextDestroyed(ServletContextEvent sce){

    }

}
