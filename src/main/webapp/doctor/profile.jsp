<%--
  医生个人信息页面
  Created by IntelliJ IDEA.
  User: 王知涵
  Date: 2025/1/10
  Time: 15:30
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
    <title>个人信息</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder"> 个人信息</strong></div>
    
    <!-- 显示成功消息 -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">
            <span class="close" onclick="this.parentNode.style.display='none';">&times;</span>
            ${successMessage}
        </div>
        <c:remove var="successMessage" scope="session"/>
    </c:if>
    
    <div class="padding border-bottom">
        <div class="media media-x">
            <div class="media-object margin-right">
                <c:choose>
                    <c:when test="${not empty doctor.avatar}">
                        <img src="${doctor.avatar}" class="radius" height="80" alt="头像" />
                    </c:when>
                    <c:otherwise>
                        <img src="images/avatars/default.jpg" class="radius" height="80" alt="默认头像" />
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="media-body">
                <h4>${doctor.name} 医生</h4>
                <p class="text-gray">工号：${doctor.jobNumber}</p>
                <p class="text-gray">科室：${doctor.departments.departmentName}</p>
                <p class="text-gray">职称：${doctor.titles.titleName}</p>
            </div>
        </div>
    </div>
    <table class="table table-hover">
        <tbody>
            <tr>
                <td width="200">姓名</td>
                <td>${doctor.name}</td>
            </tr>
            <tr>
                <td>工号</td>
                <td>${doctor.jobNumber}</td>
            </tr>
            <tr>
                <td>联系电话</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty doctor.phone}">
                            ${doctor.phone}
                        </c:when>
                        <c:otherwise>
                            <span class="text-gray">未填写</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td>邮箱</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty doctor.email}">
                            ${doctor.email}
                        </c:when>
                        <c:otherwise>
                            <span class="text-gray">未填写</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td>所属科室</td>
                <td>${doctor.departments.departmentName}</td>
            </tr>
            <tr>
                <td>职称</td>
                <td>${doctor.titles.titleName}</td>
            </tr>
            <tr>
                <td>挂号费</td>
                <td>￥${doctor.registrationFee}</td>
            </tr>
            <tr>
                <td>入职时间</td>
                <td>${doctor.entryDate}</td>
            </tr>
            <tr>
                <td>状态</td>
                <td>
                    <c:choose>
                        <c:when test="${doctor.state == 1}">
                            <span class="label label-success">正常</span>
                        </c:when>
                        <c:otherwise>
                            <span class="label label-danger">禁用</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td>个人简介</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty doctor.introduction}">
                            ${doctor.introduction}
                        </c:when>
                        <c:otherwise>
                            <span class="text-gray">暂无个人简介</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </tbody>
    </table>
    <div class="panel-foot text-center">
        <button class="button bg-main icon-edit" onclick="editProfile()">编辑信息</button>
        <button class="button bg-blue icon-lock" onclick="changePassword()">修改密码</button>
    </div>
</div>

<script>
function editProfile() {
    // 在当前frame中打开编辑页面
    window.location.href = "${pageContext.request.contextPath}/doctor/updateInfo.do";
}

function changePassword() {
    // 修改密码功能
    window.location.href = "${pageContext.request.contextPath}/doctor/updatePassword.do";
}

// 自动隐藏成功消息
$(function(){
    setTimeout(function(){
        $(".alert-success").fadeOut();
    }, 3000);
});
</script>
</body>
</html> 