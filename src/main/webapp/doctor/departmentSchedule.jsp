<%--
  科室出诊查询页面
  Created by IntelliJ IDEA.
  User: 王知涵
  Date: 2025/1/10
  Time: 18:50
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <title>科室出诊安排</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <style>
        .doctor-item {
            display: inline-block;
            margin: 3px 5px;
            padding: 5px 10px;
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            font-size: 13px;
        }
        .doctor-item .doctor-name {
            font-weight: bold;
            color: #2c3e50;
        }
        .doctor-item .doctor-info {
            color: #6c757d;
            font-size: 11px;
            margin-top: 2px;
        }
        .status-available {
            background: #d4edda;
            border-color: #c3e6cb;
        }
        .status-unavailable {
            background: #f8d7da;
            border-color: #f5c6cb;
        }
        .shift-header {
            background: #e3f2fd;
            font-weight: bold;
        }
        .same-shift {
            background: #f8f9fa;
        }
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong class="icon-calendar"> ${departmentName} - 出诊安排</strong>
    </div>
    
    <!-- 显示错误消息 -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
            <span class="close" onclick="this.parentNode.style.display='none';">&times;</span>
            ${errorMessage}
        </div>
    </c:if>
    
    <!-- 查询条件 -->
    <div class="padding border-bottom">
        <form method="get" action="${pageContext.request.contextPath}/doctor/departmentSchedule.do" class="form-inline">
            <div class="form-group">
                <label class="sr-only">查询类型</label>
                <select name="type" class="input" onchange="toggleCustomDate(this.value)">
                    <option value="thisweek" ${queryType == 'thisweek' ? 'selected' : ''}>本周</option>
                    <option value="nextweek" ${queryType == 'nextweek' ? 'selected' : ''}>下周</option>
                    <option value="custom" ${queryType == 'custom' ? 'selected' : ''}>自定义时间</option>
                </select>
            </div>
            
            <div id="customDateRange" style="display: ${queryType == 'custom' ? 'inline-block' : 'none'};">
                <div class="form-group">
                    <label class="sr-only">开始日期</label>
                    <input type="date" name="startDate" class="input" value="${startDate}" placeholder="开始日期" />
                </div>
                <div class="form-group">
                    <label class="sr-only">结束日期</label>
                    <input type="date" name="endDate" class="input" value="${endDate}" placeholder="结束日期" />
                </div>
            </div>
            
            <div class="form-group">
                <button type="submit" class="button bg-main icon-search"> 查询</button>
            </div>
        </form>
    </div>
    
    <!-- 统计信息 -->
    <div class="padding">
        <div class="alert alert-info">
            <strong>查询结果：</strong>
            ${queryTypeText}共有 <strong style="color: #d9534f;">${scheduleList.size()}</strong> 个排班安排
        </div>
    </div>
    
    <!-- 排班列表 -->
    <table class="table table-hover">
        <thead>
            <tr>
                <th width="12%">日期</th>
                <th width="8%">班次</th>
                <th width="40%">出诊医生</th>
                <th width="8%">医生数</th>
                <th width="8%">就诊总数</th>
                <th width="8%">计划总数</th>
                <th width="6%">是否可预约</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty scheduleList}">
                    <tr>
                        <td colspan="7" class="text-center text-gray">
                            <i class="icon-info-circle"></i> 暂无排班数据
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <!-- 简化的分组处理 -->
                    <c:set var="lastDateShift" value="" />
                    <c:set var="currentGroupDoctors" value="" />
                    <c:set var="currentGroupCount" value="0" />
                    <c:set var="currentGroupVisit" value="0" />
                    <c:set var="currentGroupSum" value="0" />
                    <c:set var="currentGroupAvailable" value="0" />
                    <c:set var="firstSchedule" value="" />
                    
                    <c:forEach items="${scheduleList}" var="schedule" varStatus="status">
                        <fmt:formatDate value="${schedule.date}" pattern="yyyy-MM-dd" var="dateStr"/>
                        <c:set var="currentDateShift" value="${dateStr}_${schedule.shiftTime}" />
                        
                        <c:choose>
                            <c:when test="${currentDateShift != lastDateShift}">
                                <!-- 输出上一组的数据（如果不是第一行） -->
                                <c:if test="${not empty lastDateShift}">
                                    <tr class="shift-header">
                                        <td>
                                            <fmt:formatDate value="${firstSchedule.date}" pattern="yyyy-MM-dd"/>
                                            <br/>
                                            <small class="text-gray">
                                                <fmt:formatDate value="${firstSchedule.date}" pattern="E" var="dayOfWeek"/>
                                                ${dayOfWeek}
                                            </small>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${firstSchedule.shiftTime == '上午'}">
                                                    <span class="label label-primary">上午</span>
                                                    <br><small>08:00-12:00</small>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="label label-info">下午</span>
                                                    <br><small>14:00-18:00</small>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            ${currentGroupDoctors}
                                        </td>
                                        <td><strong>${currentGroupCount}</strong></td>
                                        <td><strong class="text-info">${currentGroupVisit}</strong></td>
                                        <td><strong class="text-success">${currentGroupSum}</strong></td>
                                        <td><span class="text-success">${currentGroupAvailable}</span></td>
                                    </tr>
                                </c:if>
                                
                                <!-- 重置当前组的数据 -->
                                <c:set var="currentGroupDoctors" value="" />
                                <c:set var="currentGroupCount" value="0" />
                                <c:set var="currentGroupVisit" value="0" />
                                <c:set var="currentGroupSum" value="0" />
                                <c:set var="currentGroupAvailable" value="0" />
                                <c:set var="firstSchedule" value="${schedule}" />
                            </c:when>
                        </c:choose>
                        
                        <!-- 构建医生信息卡片 -->
                        <c:set var="doctorCard">
                            <div class="doctor-item ${schedule.isAvailable == 1 ? 'status-available' : 'status-unavailable'}">
                                <div class="doctor-name">${schedule.doctor.name}</div>
                                <div class="doctor-info">
                                    工号: ${schedule.doctor.jobNumber}<br/>
                                    电话: ${not empty schedule.doctor.phone ? schedule.doctor.phone : '-'}<br/>
                                    就诊: ${schedule.visitCount != null ? schedule.visitCount : 0} | 
                                    计划: ${schedule.sumCount != null ? schedule.sumCount : 0}
                                    <c:if test="${schedule.isAvailable == 1}">
                                        <br/><span class="label label-success">可预约</span>
                                    </c:if>
                                    <c:if test="${schedule.isAvailable != 1}">
                                        <br/><span class="label label-warning">不可约</span>
                                    </c:if>
                                </div>
                            </div>
                        </c:set>
                        
                        <!-- 累加当前组的数据 -->
                        <c:set var="currentGroupDoctors" value="${currentGroupDoctors}${doctorCard}" />
                        <c:set var="currentGroupCount" value="${currentGroupCount + 1}" />
                        <c:set var="currentGroupVisit" value="${currentGroupVisit + (schedule.visitCount != null ? schedule.visitCount : 0)}" />
                        <c:set var="currentGroupSum" value="${currentGroupSum + (schedule.sumCount != null ? schedule.sumCount : 0)}" />
                        <c:if test="${schedule.isAvailable == 1}">
                            <c:set var="currentGroupAvailable" value="${currentGroupAvailable + 1}" />
                        </c:if>
                        
                        <c:set var="lastDateShift" value="${currentDateShift}" />
                        
                        <!-- 如果是最后一条记录，输出当前组 -->
                        <c:if test="${status.last}">
                            <tr class="shift-header">
                                <td>
                                    <fmt:formatDate value="${schedule.date}" pattern="yyyy-MM-dd"/>
                                    <br/>
                                    <small class="text-gray">
                                        <fmt:formatDate value="${schedule.date}" pattern="E" var="dayOfWeek"/>
                                        ${dayOfWeek}
                                    </small>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${schedule.shiftTime == '上午'}">
                                            <span class="label label-primary">上午</span>
                                            <br><small>08:00-12:00</small>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="label label-info">下午</span>
                                            <br><small>14:00-18:00</small>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    ${currentGroupDoctors}
                                </td>
                                <td><strong>${currentGroupCount}</strong></td>
                                <td><strong class="text-info">${currentGroupVisit}</strong></td>
                                <td><strong class="text-success">${currentGroupSum}</strong></td>
                                <td><span class="text-success">${currentGroupAvailable}</span></td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    
    <!-- 统计汇总 -->
    <c:if test="${not empty scheduleList}">
        <div class="panel-foot">
            <div class="alert alert-success">
                <strong>统计汇总：</strong>
                <c:set var="totalVisit" value="0"/>
                <c:set var="totalSum" value="0"/>
                <c:set var="availableCount" value="0"/>
                <c:forEach items="${scheduleList}" var="schedule">
                    <c:set var="totalVisit" value="${totalVisit + (schedule.visitCount != null ? schedule.visitCount : 0)}"/>
                    <c:set var="totalSum" value="${totalSum + (schedule.sumCount != null ? schedule.sumCount : 0)}"/>
                    <c:if test="${schedule.isAvailable == 1}">
                        <c:set var="availableCount" value="${availableCount + 1}"/>
                    </c:if>
                </c:forEach>
                总医生数：<span class="text-info">${scheduleList.size()}</span> |
                可预约医生：<span class="text-success">${availableCount}</span> |
                总就诊数：<span class="text-warning">${totalVisit}</span> |
                总计划数：<span class="text-danger">${totalSum}</span>
            </div>
        </div>
    </c:if>
</div>

<script>
function toggleCustomDate(type) {
    var customDiv = document.getElementById('customDateRange');
    if (type === 'custom') {
        customDiv.style.display = 'inline-block';
    } else {
        customDiv.style.display = 'none';
    }
}

// 页面加载时初始化
$(document).ready(function() {
    var queryType = '${queryType}';
    toggleCustomDate(queryType);
});
</script>
</body>
</html> 