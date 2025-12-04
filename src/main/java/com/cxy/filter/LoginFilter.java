package com.cxy.filter;

import com.cxy.pojo.Admins;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 过署：定义一个类，实现javax.servlet.Filter接口，重写方法
 * doFilter()在此方法处亚助词是否登录
 */
@WebFilter({"/manager/*", "/doctor/*"})
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException{

    }
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,FilterChain filterChain) throws IOException,ServletException{
        System.out.println("-----------------------------过滤器----------------------------");

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse  response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();

        String requestURI = request.getRequestURI();

        Object admin = session.getAttribute("admin");
        Object doctor = session.getAttribute("doctor");

        // 判断访问路径和用户权限
        if (requestURI.contains("/manager/")) {
            // 访问管理员路径，需要管理员权限
            if (admin != null) {
                filterChain.doFilter(servletRequest, servletResponse); // 放行
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
        } else if (requestURI.contains("/doctor/")) {
            // 访问医生路径，需要医生权限
            if (doctor != null) {
                filterChain.doFilter(servletRequest, servletResponse); // 放行
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
        } else {
            // 其他路径，有任意一种权限即可访问
            if (admin != null || doctor != null) {
                filterChain.doFilter(servletRequest, servletResponse); // 放行
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
        }
    }

    @Override
    public void destroy(){

    }
}
