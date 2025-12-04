<%--
  Created by IntelliJ IDEA.
  User: 86198
  Date: 2025/7/17
  Time: 14:34
  To change this template use File | Settings | File Templates.
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
  <title>预约管理</title>
  <link rel="stylesheet" href="css/pintuer.css">
  <link rel="stylesheet" href="css/admin.css">
  <script src="js/jquery.js"></script>
  <script src="js/pintuer.js"></script>
  <style>
    .panel {
      margin-bottom: 20px;
    }

    .alert {
      padding: 10px;
      margin-bottom: 20px;
      border-radius: 4px;
    }

    .alert-success {
      background-color: #dff0d8;
      border: 1px solid #d6e9c6;
      color: #3c763d;
    }

    .alert-danger {
      background-color: #f2dede;
      border: 1px solid #ebccd1;
      color: #a94442;
    }

    .close {
      float: right;
      font-size: 21px;
      font-weight: bold;
      line-height: 1;
      color: #000;
      text-shadow: 0 1px 0 #fff;
      opacity: 0.2;
      cursor: pointer;
    }

    .search-form {
      margin: 20px 0;
      padding: 15px;
      background-color: #f5f5f5;
      border-radius: 4px;
    }

    .form-inline {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
    }

    .form-group {
      margin-right: 15px;
      margin-bottom: 10px;
    }

    .form-group label {
      margin-right: 5px;
    }

    .table {
      width: 100%;
      max-width: 100%;
      margin-bottom: 20px;
      border-collapse: collapse;
    }

    .table th, .table td {
      padding: 8px;
      line-height: 1.42857143;
      vertical-align: top;
      border-top: 1px solid #ddd;
      text-align: center;
    }

    .table th {
      vertical-align: bottom;
      border-bottom: 2px solid #ddd;
      background-color: #f9f9f9;
    }

    .table-hover tbody tr:hover {
      background-color: #f5f5f5;
    }

    .text-center {
      text-align: center;
    }

    .text-gray {
      color: #999;
    }

    .label {
      display: inline;
      padding: 0.2em 0.6em 0.3em;
      font-size: 75%;
      font-weight: bold;
      line-height: 1;
      color: #fff;
      text-align: center;
      white-space: nowrap;
      vertical-align: baseline;
      border-radius: 0.25em;
    }

    .label-success {
      background-color: #5cb85c;
    }

    .label-info {
      background-color: #5bc0de;
    }

    .label-warning {
      background-color: #f0ad4e;
    }

    .label-danger {
      background-color: #d9534f;
    }

    .label-default {
      background-color: #777;
    }

    .button-group {
      display: inline-flex;
    }

    .button-small {
      padding: 2px 6px;
      font-size: 12px;
      line-height: 1.5;
      border-radius: 3px;
      margin-right: 5px;
    }

    .pagelist {
      text-align: center;
      margin: 20px 0;
    }

    .pagelist a, .pagelist span {
      display: inline-block;
      padding: 5px 10px;
      margin: 0 2px;
      border: 1px solid #ddd;
      text-decoration: none;
      color: #333;
    }

    .pagelist .current {
      background-color: #1E9FFF;
      color: #fff;
      border-color: #1E9FFF;
    }

    .text-muted {
      color: #999;
    }

    .action-buttons {
      margin: 20px 0;
    }

    .no-data {
      padding: 50px;
      text-align: center;
      color: #999;
    }

    .no-data .icon {
      font-size: 48px;
      color: #ddd;
      margin-bottom: 15px;
    }
  </style>
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head">
    <strong><span class="icon-calendar"></span> 预约管理</strong>
  </div>

  <!-- 消息提示 -->
  <c:if test="${not empty param.message}">
    <div class="alert alert-success">
      <span class="close" onclick="this.parentNode.style.display='none';">&times;</span>
        ${param.message}
    </div>
  </c:if>

  <c:if test="${not empty param.error}">
    <div class="alert alert-danger">
      <span class="close" onclick="this.parentNode.style.display='none';">&times;</span>
        ${param.error}
    </div>
  </c:if>

  <!-- 搜索和筛选 -->
  <div class="search-form">
    <form method="get" action="${pageContext.request.contextPath}/manager/appointments.do" id="listForm">
      <div class="form-inline">
        <!-- 分页参数 -->
        <input type="hidden" name="page" id="page" value="1">

        <div class="form-group">
          <label>患者姓名：</label>
          <input type="text" name="patientName" value="${patientName}" class="input" placeholder="输入患者姓名">
        </div>

        <div class="form-group">
          <label>医生姓名：</label>
          <input type="text" name="doctorName" value="${doctorName}" class="input" placeholder="输入医生姓名">
        </div>

        <div class="form-group">
          <label>预约状态：</label>
          <select name="status" class="input">
            <option value="">全部状态</option>
            <option value="booked" ${status == 'booked' ? 'selected' : ''}>已预约</option>
            <option value="completed" ${status == 'completed' ? 'selected' : ''}>已完成</option>
            <option value="cancelled" ${status == 'cancelled' ? 'selected' : ''}>已取消</option>
          </select>
        </div>

        <div class="form-group">
          <label>预约日期：</label>
          <input type="date" name="appointmentDate" value="${appointmentDate}" class="input">
        </div>

        <div class="form-group">
          <button type="submit" class="button bg-main">
            <span class="icon-search"></span> 搜索
          </button>
          <button type="reset" class="button bg-gray">重置</button>
        </div>
      </div>
    </form>
  </div>

  <!-- 操作按钮 -->
  <div class="action-buttons">
    <a href="${pageContext.request.contextPath}/manager/addAppointment.do" class="button bg-green">
      <span class="icon-plus"></span> 添加预约
    </a>
  </div>

  <!-- 预约列表表格 -->
  <table class="table table-hover text-center">
    <thead>
    <tr>
      <th width="8%">预约编号</th>
      <th width="15%">患者信息</th>
      <th width="15%">医生信息</th>
      <th width="12%">预约日期</th>
      <th width="10%">时间段</th>
      <th width="10%">状态</th>
      <th width="15%">创建时间</th>
      <th width="15%">操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${pageInfo.list}" var="appointment">
      <tr>
        <td>${appointment.appointmentId}</td>
        <td>
          <strong>${appointment.patient.pname}</strong>
          <br>
        </td>
        <td>
          <strong>${appointment.doctor.name}</strong>
          <br>
          <small class="text-gray">${appointment.doctor.departments.departmentName}</small>
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
          <fmt:formatDate value="${appointment.createtime}" pattern="yyyy-MM-dd HH:mm"/>
        </td>
        <td>
          <c:choose>
            <c:when test="${appointment.status == 'booked'}">
              <div class="button-group">
                <a class="button border-green button-small" href="javascript:void(0)"
                   onclick="updateStatus('${appointment.appointmentId}', 'completed')">
                  <span class="icon-check"></span> 完成
                </a>
                <a class="button border-red button-small" href="javascript:void(0)"
                   onclick="updateStatus('${appointment.appointmentId}', 'cancelled')">
                  <span class="icon-times"></span> 取消
                </a>
                <a class="button border-gray button-small" href="javascript:void(0)"
                   onclick="deleteAppointment('${appointment.appointmentId}')">
                  <span class="icon-trash-o"></span> 删除
                </a>
              </div>
            </c:when>
            <c:otherwise>
              <div class="button-group">
                <a class="button border-gray button-small" href="javascript:void(0)"
                   onclick="deleteAppointment('${appointment.appointmentId}')">
                  <span class="icon-trash-o"></span> 删除
                </a>
              </div>
            </c:otherwise>
          </c:choose>
        </td>
      </tr>
    </c:forEach>

    <c:if test="${empty pageInfo.list}">
      <tr>
        <td colspan="8" class="no-data">
          <span class="icon icon-info-circle"></span>
          <br><br>
          暂无预约记录
          <br>
          <small>没有找到符合条件的预约记录</small>
        </td>
      </tr>
    </c:if>
    </tbody>
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
</div>

<script>
  // 分页函数
  function changePage(page) {
    document.getElementById("page").value = page;
    document.getElementById("listForm").submit();
  }

  // 更新预约状态
  function updateStatus(appointmentId, status) {
    var action = "";
    if (status === "completed") {
      action = "标记为完成";
    } else if (status === "cancelled") {
      action = "取消";
    }

    if (confirm("确定要" + action + "这个预约吗？")) {
      window.location.href = "${pageContext.request.contextPath}/manager/updateAppointmentStatus.do?appointmentId=" + appointmentId + "&status=" + status;
    }
  }

  // 删除预约
  function deleteAppointment(appointmentId) {
    if (confirm("确定要删除这个预约记录吗？")) {
      window.location.href = "${pageContext.request.contextPath}/manager/deleteAppointment.do?appointmentId=" + appointmentId;
    }
  }
</script>

</body>
</html>