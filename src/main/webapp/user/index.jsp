<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="renderer" content="webkit">
    <title>用户中心 - 医院管理系统</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/pintuer.js"></script>
    <style>
        .admin iframe {
            min-height: 600px;
            background: #fff;
        }
        .leftnav li a.on {
            background: #f2f9fd;
            color: #1E9FFF;
        }
        .header .head-l {
            line-height: 70px;
        }
    </style>
</head>
<body style="background-color:#f2f9fd;">
<div class="header bg-main">
    <div class="logo margin-big-left fadein-top">
        <h1>
            用户中心
        </h1>
    </div>
    <div class="head-l">
        <span style="color: white; margin-right: 20px;">欢迎您，${patient.pname}</span>
        <a class="button button-little bg-red" href="${pageContext.request.contextPath}/user/userLogin.jsp">
            <span class="icon-power-off"></span> 退出登录
        </a>
    </div>
</div>

<div class="leftnav">
    <div class="leftnav-title"><strong><span class="icon-list"></span>菜单列表</strong></div>

    <h2><span class="icon-user"></span>个人中心</h2>
    <ul style="display: block">
        <li><a href="user/info.do" target="right"><span class="icon-caret-right"></span>个人信息维护</a></li>
        <li><a href="user/hospitalization.do?action=my" target="right"><span class="icon-caret-right"></span>住院信息</a></li>
        <li><a href="user/appointment.do" target="right"><span class="icon-caret-right"></span>门诊预约</a></li>
    </ul>

    <ul>
        <li><a href="user/password.do" target="right"><span class="icon-caret-right"></span>修改密码</a></li>
    </ul>
</div>

<script type="text/javascript">
    $(function(){
        // 菜单折叠效果
        $(".leftnav h2").click(function(){
            $(this).next().slideToggle(200);
            $(this).toggleClass("on");
        });

        // 菜单选中效果
        $(".leftnav ul li a").click(function(){
            $("#a_leader_txt").text($(this).text().replace('<span class="icon-caret-right"></span>','').trim());
            $(".leftnav ul li a").removeClass("on");
            $(this).addClass("on");

            // 存储当前选中的菜单项
            sessionStorage.setItem('selectedMenu', $(this).attr('href'));
        });

        // 页面加载时恢复选中的菜单项
        var selectedMenu = sessionStorage.getItem('selectedMenu');
        if(selectedMenu) {
            $('.leftnav ul li a[href="'+selectedMenu+'"]').click();
        } else {
            $('.leftnav ul li:first-child a').click();
        }

        // iframe高度自适应
        function resizeIframe() {
            var ifm = document.getElementsByName("right")[0];
            ifm.height = document.documentElement.clientHeight - 120;
        }
        window.onresize = resizeIframe;
        resizeIframe();
    });
</script>

<ul class="bread">
    <li><a href="user/info.do" target="right" class="icon-home"> 首页</a></li>
    <li><a href="javascript:;" id="a_leader_txt">个人信息</a></li>
    <li>
        <b>账户余额：</b>
        <span style="color:red;">￥<fmt:formatNumber value="${patient.balance}" pattern="#,##0.00"/></span>
    </li>
</ul>

<div class="admin">
    <iframe scrolling="auto" frameborder="0" src="user/info.do" name="right" width="100%" height="100%"></iframe>
</div>

<div style="text-align:center; padding: 10px 0; color: #999;">
    <p>医院管理系统 &copy; 2025 版权所有</p>
</div>
</body>
</html>