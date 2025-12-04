<%--
  医生管理中心首页
  Created by IntelliJ IDEA.
  User: 王知涵
  Date: 2025/1/10
  Time: 15:00
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
  <%
    String contextPath = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + contextPath + "/";
  %>
  <base href="<%=basePath%>">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <meta name="renderer" content="webkit">
  <title>医生工作台</title>
  <link rel="stylesheet" href="css/pintuer.css">
  <link rel="stylesheet" href="css/admin.css">
  <script src="js/jquery.js"></script>
</head>
<body style="background-color:#f2f9fd;">
<div class="header bg-main">
  <div class="logo margin-big-left fadein-top">
    <h1><img src="${doctor.avatar}" class="radius-circle rotate-hover" height="50" alt="" />医生工作台</h1>
  </div>
  <div class="head-l">
    <span style="color: white; margin-right: 20px;">欢迎您，${doctor.name}医生</span>
    <a class="button button-little bg-green" href="${pageContext.request.contextPath}/user/login.do" target="_blank"><span class="icon-home"></span> 前台登陆页</a>
    &nbsp;&nbsp;<a class="button button-little bg-red" href="${pageContext.request.contextPath}/login.jsp"><span class="icon-power-off"></span> 退出登录</a> 
  </div>
</div>
<div class="leftnav">
  <div class="leftnav-title"><strong><span class="icon-list"></span>菜单列表</strong></div>
  <h2><span class="icon-user"></span>个人中心</h2>
  <ul style="display: block">
    <li><a href="doctor/profile.jsp" target="right"><span class="icon-caret-right"></span>个人信息</a></li>
    <li><a href="doctor/updateInfo.do" target="right"><span class="icon-caret-right"></span>编辑信息</a></li>
    <li><a href="doctor/updatePassword.do" target="right"><span class="icon-caret-right"></span>修改密码</a></li>
  </ul>
  <h2><span class="icon-calendar"></span>预约管理</h2>
  <ul>
    <li><a href="doctor/departmentSchedule.do" target="right"><span class="icon-caret-right"></span>科室出诊</a></li>
    <li><a href="doctor/appointments.do" target="right"><span class="icon-caret-right"></span>我的预约</a></li>
    <li><a href="doctor/addAppointment.do" target="right"><span class="icon-caret-right"></span>临时加号</a></li>
  </ul>
  <h2><span class="icon-clipboard"></span>患者管理</h2>
  <ul>
    <li><a href="doctor/patients.do" target="right"><span class="icon-caret-right"></span>患者列表</a></li>
    <li><a href="doctor/diagnosis.do" target="right"><span class="icon-caret-right"></span>诊断记录</a></li>
  </ul>
  <h2><span class="icon-bell"></span>公告消息</h2>
  <ul>
    <li><a href="doctor/announcement.do" target="right"><span class="icon-caret-right"></span>医院公告</a></li>
  </ul>
</div>
<script type="text/javascript">
  $(function(){
    $(".leftnav h2").click(function(){
      $(this).next().slideToggle(200);
      $(this).toggleClass("on");
    })
    $(".leftnav ul li a").click(function(){
      $("#a_leader_txt").text($(this).text());
      $(".leftnav ul li a").removeClass("on");
      $(this).addClass("on");
    })
  });
</script>
<ul class="bread">
  <li><a href="doctor/profile.jsp" target="right" class="icon-home"> 首页</a></li>
  <li><a href="##" id="a_leader_txt">个人信息</a></li>
  <li><b>当前科室：</b><span style="color:red;">${doctor.departments.departmentName}</span>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>职称：</b><span style="color:red;">${doctor.titles.titleName}</span></li>
</ul>
<div class="admin">
  <iframe scrolling="auto" rameborder="0" src="doctor/profile.jsp" name="right" width="100%" height="100%"></iframe>
</div>
<div style="text-align:center;">
  <p>医生工作台 - 医院管理系统</p>
</div>
</body>
</html> 