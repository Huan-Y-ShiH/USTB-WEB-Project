<%--
  Created by IntelliJ IDEA.
  User: 86198
  Date: 2025/7/10
  Time: 09:50
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
    <div class="padding border-bottom">
        <a class="button border-yellow" href="${pageContext.request.contextPath}/manager/addProfession.jsp">
            <span class="icon-plus-square-o"></span> 添加内容</a>
    </div>
    <table class="table table-hover text-center">
        <tr>
            <th width="5%">编号</th>
            <th width="20%">职称名称</th>
            <th width="50%">职称简介</th>
            <th width="25%">操作</th>
        </tr>

        <c:forEach items="${pageInfo.list}" var="profession">

            <tr>
                <td>${profession.id}</td>
                <td>${profession.titleName}</td>
                <td>${profession.description}</td>
                <td>
                    <div class="button-group">
                        <a class="button border-main"
                           href="${pageContext.request.contextPath}/manager/searchProfession.do?titleName=${profession.titleName}"
                           class="operate-btn edit-btn">
                            <span class="icon-edit"></span>修改</a>

                        <a class="button border-red"
                           href="${pageContext.request.contextPath}/manager/deleteProfession.do?titleName=${profession.titleName}"
                           onclick="return confirm('您确定要删除吗?')">
                            <span class="icon-trash-o"></span> 删除</a>
                    </div>
                </td>
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
                            <a href="${pageContext.request.contextPath}/manager/professionByFirst.do?page=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
            </td>
        </tr>

    </table>
</div>

</body></html>
