<%--
  医生端预约管理页面
  Created by IntelliJ IDEA.
  User: 王知涵
  Date: 2025/1/10
  Time: 21:30
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
    <title>我的预约</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong class="icon-calendar"> 我的预约 - ${doctor.name}医生</strong>
    </div>
    
    <!-- 显示成功消息 -->
    <c:if test="${not empty param.message}">
        <div class="alert alert-success">
            <span class="close" onclick="this.parentNode.style.display='none';">&times;</span>
            ${param.message}
        </div>
    </c:if>
    
    <!-- 显示错误消息 -->
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger">
            <span class="close" onclick="this.parentNode.style.display='none';">&times;</span>
            ${param.error}
        </div>
    </c:if>
    
    <!-- 搜索和筛选 -->
    <form method="get" action="${pageContext.request.contextPath}/doctor/appointments.do" id="listForm">
        <div class="padding border-bottom">
            <div class="form-inline">
                <!-- 分页参数 -->
                <input type="hidden" name="page" id="page" value="1">
                
                <div class="form-group">
                    <label>预约状态：</label>
                    <select name="status" class="input">
                        <option value="">全部状态</option>
                        <option value="booked" ${status == 'booked' ? 'selected' : ''}>已预约</option>
                        <option value="completed" ${status == 'completed' ? 'selected' : ''}>已完成</option>
                        <option value="cancelled" ${status == 'cancelled' ? 'selected' : ''}>已取消</option>
                    </select>
                    
                    <button type="submit" class="button bg-main">
                        <span class="icon-search"></span> 筛选
                    </button>
                </div>
                
                <div class="form-group" style="float: right;">
                    <span class="text-gray">
                        共找到 ${pageInfo.total} 条预约记录
                    </span>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
//定义页码的点击事件
function changePage(page){
    document.getElementById("page").value=page;
    document.getElementById("listForm").submit();
}

//完成预约
function confirmComplete(appointmentId){
    if(confirm("确定要标记这个预约为已完成吗？")){
        window.location.href = "${pageContext.request.contextPath}/doctor/updateAppointmentStatus.do?appointmentId=" + appointmentId + "&status=completed";
    }
}

//取消预约
function confirmCancel(appointmentId){
    if(confirm("确定要取消这个预约吗？")){
        window.location.href = "${pageContext.request.contextPath}/doctor/updateAppointmentStatus.do?appointmentId=" + appointmentId + "&status=cancelled";
    }
}
</script>

<table class="table table-hover text-center">
    <tr>
        <th width="8%">预约编号</th>
        <th width="15%">患者姓名</th>
        <th width="15%">预约日期</th>
        <th width="10%">时间段</th>
        <th width="10%">预约状态</th>
        <th width="15%">创建时间</th>
        <th width="15%">操作</th>
    </tr>

    <c:forEach items="${pageInfo.list}" var="appointment">
        <tr>
            <td>${appointment.appointmentId}</td>
            <td>
                <strong>${appointment.patient.pname}</strong>
                <br>
                <small class="text-gray">${appointment.patient.idCardNumber}</small>
            </td>
            <td>
                <strong><fmt:formatDate value="${appointment.appointmentDate}" pattern="yyyy-MM-dd"/></strong>
                <br>
                <small class="text-gray">
                    <fmt:formatDate value="${appointment.appointmentDate}" pattern="EEEE"/>
                </small>
            </td>
            <td>
                <c:choose>
                    <c:when test="${appointment.appointmentTime == '上午'}">
                        <span class="label label-success">上午</span>
                        <br><small>08:00-12:00</small>
                    </c:when>
                    <c:otherwise>
                        <span class="label label-warning">下午</span>
                        <br><small>14:00-18:00</small>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:choose>
                    <c:when test="${appointment.status == 'booked'}">
                        <span class="label label-info">已预约</span>
                    </c:when>
                    <c:when test="${appointment.status == 'completed'}">
                        <span class="label label-success">已完成</span>
                    </c:when>
                    <c:when test="${appointment.status == 'cancelled'}">
                        <span class="label label-danger">已取消</span>
                    </c:when>
                    <c:otherwise>
                        <span class="label label-default">${appointment.status}</span>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <fmt:formatDate value="${appointment.createtime}" pattern="MM-dd HH:mm"/>
            </td>
            <td>
                <c:choose>
                    <c:when test="${appointment.status == 'booked'}">
                        <div class="button-group">
                            <a class="button border-green button-small" href="javascript:void(0)" 
                               onclick="confirmComplete('${appointment.appointmentId}')">
                                <span class="icon-check"></span> 完成
                            </a>
                            <a class="button border-red button-small" href="javascript:void(0)" 
                               onclick="confirmCancel('${appointment.appointmentId}')">
                                <span class="icon-times"></span> 取消
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <span class="text-muted">-</span>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
    
    <c:if test="${empty pageInfo.list}">
        <tr>
            <td colspan="8" class="text-center text-gray" style="padding: 50px;">
                <span class="icon-info-circle" style="font-size: 48px; color: #ddd;"></span>
                <br><br>
                暂无预约记录
                <br>
                <small>您还没有预约记录，或者可以尝试调整筛选条件</small>
            </td>
        </tr>
    </c:if>
</table>

<!-- 分页导航 -->
<c:if test="${pageInfo.pages > 1}">
    <div class="pagelist">
        <c:if test="${pageInfo.hasPreviousPage}">
            <a href="javascript:changePage(1)">首页</a>
            <a href="javascript:changePage(${pageInfo.prePage})">上一页</a>
        </c:if>
        
        <c:forEach items="${pageInfo.navigatepageNums}" var="nav">
            <c:choose>
                <c:when test="${nav == pageInfo.pageNum}">
                    <span class="current">${nav}</span>
                </c:when>
                <c:otherwise>
                    <a href="javascript:changePage(${nav})">${nav}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        
        <c:if test="${pageInfo.hasNextPage}">
            <a href="javascript:changePage(${pageInfo.nextPage})">下一页</a>
            <a href="javascript:changePage(${pageInfo.pages})">尾页</a>
        </c:if>
        
        <span>第${pageInfo.pageNum}页/共${pageInfo.pages}页 (${pageInfo.total}条记录)</span>
    </div>
</c:if>

</body>
</html> 