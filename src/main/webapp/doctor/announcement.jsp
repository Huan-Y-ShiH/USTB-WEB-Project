<%--
  Created by IntelliJ IDEA.
  User: 86198
  Date: 2025/7/15
  Time: 16:21
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
    <title>网站信息</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder"> 内容列表</strong></div>
    <table class="table table-hover text-center">
        <tr>
            <th width="10%">编号</th>
            <th width="10%">标题</th>
            <th width="15%">内容</th>
            <th width="15%">创建时间</th>
            <th width="15%">创建人</th>
        </tr>

        <c:forEach items="${pageInfo.list}" var="announcement">

            <tr>
                <td>${announcement.announcementId}</td>
                <td>${announcement.title}</td>
                <td>${announcement.content}</td>
                <td>${announcement.creationTime}</td>
                <td>${announcement.creator}</td>
            </tr>
        </c:forEach>

        <tr>
            <td colspan="4"><div class="pagelist">
                <c:forEach begin="1" end="${pageInfo.pages}" var="i">
                    <c:choose>
                        <c:when test="${i ==pageInfo.pageNum}">
                            <span class="current">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/manager/announcement.do?page=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
            </td>
        </tr>

    </table>
</div>

</body></html>