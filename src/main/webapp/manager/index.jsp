<%--
  Created by IntelliJ IDEA.
  User: 30449
  Date: 2025/7/8
  Time: 14:56
  To change this template use File | Settings | File Templates.
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
  <title>后台管理中心</title>
  <link rel="stylesheet" href="css/pintuer.css">
  <link rel="stylesheet" href="css/admin.css">
  <script src="js/jquery.js"></script>
</head>
<body style="background-color:#f2f9fd;">
<div class="header bg-main">
  <div class="logo margin-big-left fadein-top">
    <h1><img src="${pageContext.request.contextPath}/images/${admin.avatar}" class="radius-circle rotate-hover" height="50" alt="" />后台管理中心</h1>
  </div>
  <div class="head-l">
    <a class="button button-little bg-green" href="${pageContext.request.contextPath}/user/login.do" target="_blank">
    <span class="icon-home"></span> 前台登录页</a>

    <a class="button button-little bg-red" href="../login.jsp">
    <span class="icon-power-off"></span> 退出登录</a> </div>
</div>
<div class="leftnav">
  <div class="leftnav-title"><strong><span class="icon-list"></span>菜单列表</strong></div>
  <h2><span class="icon-user"></span>医院管理</h2>
  <ul style="display:block">
    <li><a href="${pageContext.request.contextPath}/manager/departmentByFirst.do" target="right"><span class="icon-caret-right"></span>科室管理</a></li>
    <li><a href="${pageContext.request.contextPath}/manager/doctorsSearch.do" target="right"><span class="icon-caret-right"></span>医生管理</a></li>
    <li><a href="${pageContext.request.contextPath}/manager/scheduleSearch.do" target="right"><span class="icon-caret-right"></span>排班管理</a></li>
    <li><a href="${pageContext.request.contextPath}/manager/professionByFirst.do" target="right"><span class="icon-caret-right"></span>职称管理</a></li>
    <li><a href="${pageContext.request.contextPath}/manager/appointments.do" target="right"><span class="icon-caret-right"></span>预约管理</a></li>
    <li><a href="${pageContext.request.contextPath}/manager/announcement.do" target="right"><span class="icon-caret-right"></span>公告管理</a></li>
    <%-- <li><a href="column.html" target="right"><span class="icon-caret-right"></span>栏目管理</a></li> --%>
  </ul>

  <%--
  <h2><span class="icon-pencil-square-o"></span>栏目管理</h2>
  <ul>
    <li><a href="list.html" target="right"><span class="icon-caret-right"></span>内容管理</a></li>
    <li><a href="add.html" target="right"><span class="icon-caret-right"></span>添加内容</a></li>
    <li><a href="cate.html" target="right"><span class="icon-caret-right"></span>分类管理</a></li>
  </ul>
  --%>

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
  <li><a href="{:U('Index/info')}" target="right" class="icon-home"> 首页</a></li>
  <li><a href="##" id="a_leader_txt">网站信息</a></li>
  <li><b>当前语言：</b><span style="color:red;">中文</span>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;切换语言：<a href="##">中文</a> &nbsp;&nbsp;<a href="##">英文</a> </li>
</ul>
<div class="admin">
  <iframe scrolling="auto" rameborder="0" src="${pageContext.request.contextPath}/manager/departmentByFirst.do" name="right" width="100%" height="100%"></iframe>
</div>
<div style="text-align:center;">
  <p>来源:<a href="http://www.mycodes.net/" target="_blank">源码之家</a></p>
</div>
</body>
</html>