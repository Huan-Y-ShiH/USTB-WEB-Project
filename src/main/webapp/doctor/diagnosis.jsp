<%--
  医生端诊断记录页面
  Created by IntelliJ IDEA.
  User: 王知涵
  Date: 2025/1/10
  Time: 23:20
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>诊断记录</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong class="icon-file-text"> 我的诊断记录</strong>
    </div>
    
    <!-- 显示错误消息 -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
            <span class="close" onclick="this.parentNode.style.display='none';">&times;</span>
            ${errorMessage}
        </div>
    </c:if>
    
    <!-- 时间筛选 -->
    <div class="padding border-bottom">
        <form method="get" action="${pageContext.request.contextPath}/doctor/diagnosis.do" class="form-inline">
            <div class="form-group">
                <label>时间范围：</label>
                <input type="date" name="startDate" class="input" value="${startDate}" />
                <span class="text-gray">至</span>
                <input type="date" name="endDate" class="input" value="${endDate}" />
            </div>
            
            <div class="form-group">
                <button type="submit" class="button bg-main icon-search"> 查询</button>
                <button type="button" class="button bg-gray icon-refresh" onclick="clearSearch()"> 重置</button>
            </div>
        </form>
    </div>
    
    <!-- 统计信息 -->
    <div class="padding">
        <div class="alert alert-info">
            <strong>统计信息：</strong>
            共有 <strong style="color: #d9534f;">${pageInfo.total}</strong> 条诊断记录，
            当前第 <strong>${pageInfo.pageNum}</strong> 页，
            共 <strong>${pageInfo.pages}</strong> 页
        </div>
    </div>
    
    <!-- 诊断记录列表 -->
    <table class="table table-hover">
        <thead>
            <tr>
                <th width="8%">咨询ID</th>
                <th width="12%">患者姓名</th>
                <th width="15%">患者电话</th>
                <th width="15%">咨询时间</th>
                <th width="10%">是否住院</th>
                <th width="30%">医疗建议</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty pageInfo.list}">
                    <tr>
                        <td colspan="7" class="text-center text-gray">
                            <i class="icon-info-circle"></i> 暂无诊断记录
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${pageInfo.list}" var="consultation">
                        <tr>
                            <td>${consultation.consultationId}</td>
                            <td>
                                <strong>${consultation.patient.pname}</strong>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty consultation.patient.phone}">
                                        ${consultation.patient.phone}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-gray">未填写</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <fmt:formatDate value="${consultation.consultationTime}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${consultation.isHospitalized}">
                                        <span class="label bg-red">已住院</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="label bg-gray">未住院</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty consultation.medicalAdviceCase}">
                                        ${consultation.medicalAdviceCase}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-gray">无</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    
    <!-- 分页导航 -->
    <c:if test="${pageInfo.pages > 1}">
        <div class="panel-foot text-center">
            <div class="pagination">
                <c:if test="${pageInfo.hasPreviousPage}">
                    <a href="${pageContext.request.contextPath}/doctor/diagnosis.do?page=1&startDate=${startDate}&endDate=${endDate}" 
                       class="button border">首页</a>
                    <a href="${pageContext.request.contextPath}/doctor/diagnosis.do?page=${pageInfo.prePage}&startDate=${startDate}&endDate=${endDate}" 
                       class="button border">上一页</a>
                </c:if>
                
                <c:forEach items="${pageInfo.navigatepageNums}" var="nav">
                    <c:choose>
                        <c:when test="${nav == pageInfo.pageNum}">
                            <span class="button bg-main">${nav}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/doctor/diagnosis.do?page=${nav}&startDate=${startDate}&endDate=${endDate}" 
                               class="button border">${nav}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <c:if test="${pageInfo.hasNextPage}">
                    <a href="${pageContext.request.contextPath}/doctor/diagnosis.do?page=${pageInfo.nextPage}&startDate=${startDate}&endDate=${endDate}" 
                       class="button border">下一页</a>
                    <a href="${pageContext.request.contextPath}/doctor/diagnosis.do?page=${pageInfo.pages}&startDate=${startDate}&endDate=${endDate}" 
                       class="button border">尾页</a>
                </c:if>
            </div>
            <p class="text-gray">
                第 ${pageInfo.pageNum} 页 / 共 ${pageInfo.pages} 页，总共 ${pageInfo.total} 条记录
            </p>
        </div>
    </c:if>
</div>

<script>
function clearSearch() {
    window.location.href = "${pageContext.request.contextPath}/doctor/diagnosis.do";
}
</script>
</body>
</html> 