<%--
  患者详情查看页面
  Created by IntelliJ IDEA.
  User: 王知涵
  Date: 2025/1/10
  Time: 20:50
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
    <title>患者详情</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-user"> 患者详情</strong></div>
    
    <div class="padding border-bottom">
        <div class="media media-x">
            <div class="media-object margin-right">
                <c:choose>
                    <c:when test="${not empty patient.avatar}">
                        <img src="${patient.avatar}" class="radius" height="80" alt="头像" />
                    </c:when>
                    <c:otherwise>
                        <img src="images/avatars/default.jpg" class="radius" height="80" alt="默认头像" />
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="media-body">
                <h4>${patient.pname}</h4>
                <p class="text-gray">患者ID：${patient.patientId}</p>
                <p class="text-gray">身份证号：${patient.idCardNumber}</p>
                <p class="text-gray">账户余额：￥${patient.balance}</p>
            </div>
        </div>
    </div>
    
    <table class="table table-hover">
        <tbody>
            <tr>
                <td width="200">患者ID</td>
                <td>${patient.patientId}</td>
            </tr>
            <tr>
                <td>姓名</td>
                <td>${patient.pname}</td>
            </tr>
            <tr>
                <td>身份证号</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty patient.idCardNumber}">
                            ${patient.idCardNumber}
                        </c:when>
                        <c:otherwise>
                            <span class="text-gray">未填写</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td>联系电话</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty patient.phone}">
                            ${patient.phone}
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
                        <c:when test="${not empty patient.email}">
                            ${patient.email}
                        </c:when>
                        <c:otherwise>
                            <span class="text-gray">未填写</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td>账户余额</td>
                <td>
                    <c:choose>
                        <c:when test="${patient.balance != null}">
                            <span class="text-success">￥${patient.balance}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-gray">￥0.00</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </tbody>
    </table>
    
    <div class="panel-foot text-center">
        <button class="button bg-gray icon-back" onclick="goBack()">返回列表</button>
    </div>
</div>

<script>
function goBack() {
    window.history.back();
}
</script>
</body>
</html> 