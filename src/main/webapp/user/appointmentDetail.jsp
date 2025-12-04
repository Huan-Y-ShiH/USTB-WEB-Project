<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>预约详情</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <style>
        .detail-container {
            max-width: 800px;
            margin: 20px auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .detail-header {
            background: #007bff;
            color: white;
            padding: 20px;
            border-radius: 8px 8px 0 0;
            text-align: center;
        }
        .detail-content {
            padding: 30px;
        }
        .detail-row {
            display: flex;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }
        .detail-label {
            width: 120px;
            font-weight: bold;
            color: #333;
        }
        .detail-value {
            flex: 1;
            color: #666;
        }
        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 14px;
            color: white;
            display: inline-block;
        }
        .status-booked { background: #28a745; }
        .status-cancelled { background: #dc3545; }
        .status-completed { background: #007bff; }
        .action-buttons {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        .action-buttons a {
            margin: 0 10px;
        }
    </style>
</head>
<body>
<div class="detail-container">
    <div class="detail-header">
        <h2><span class="icon-calendar"></span> 预约详情</h2>
    </div>
    
    <div class="detail-content">
        <div class="detail-row">
            <div class="detail-label">预约编号:</div>
            <div class="detail-value">${appointment.appointmentId}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">预约状态:</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${appointment.status == 'booked'}">
                        <span class="status-badge status-booked">已预约</span>
                    </c:when>
                    <c:when test="${appointment.status == 'cancelled'}">
                        <span class="status-badge status-cancelled">已取消</span>
                    </c:when>
                    <c:when test="${appointment.status == 'completed'}">
                        <span class="status-badge status-completed">已完成</span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-badge">${appointment.status}</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">预约日期:</div>
            <div class="detail-value">
                <fmt:formatDate value="${appointment.appointmentDate}" pattern="yyyy年MM月dd日"/>
            </div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">预约时间:</div>
            <div class="detail-value">${appointment.appointmentTime}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">医生姓名:</div>
            <div class="detail-value">${appointment.doctor.name}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">医生电话:</div>
            <div class="detail-value">${appointment.doctor.phone}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">科室名称:</div>
            <div class="detail-value">${appointment.department.departmentName}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">患者姓名:</div>
            <div class="detail-value">${appointment.patient.pname}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">联系电话:</div>
            <div class="detail-value">${appointment.patient.phone}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">身份证号:</div>
            <div class="detail-value">${appointment.patient.idCardNumber}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">创建时间:</div>
            <div class="detail-value">
                <fmt:formatDate value="${appointment.createtime}" pattern="yyyy年MM月dd日 HH:mm:ss"/>
            </div>
        </div>
        
        <div class="action-buttons">
            <c:if test="${appointment.status == 'booked'}">
                <a class="button border-red" 
                   href="javascript:if(confirm('确定要取消预约吗？')) location.href='user/appointment.do?action=cancel&appointmentId=${appointment.appointmentId}'">
                    取消预约
                </a>
            </c:if>
            <a class="button border-blue" href="user/appointment.do">返回预约列表</a>
            <a class="button border-green" href="user/appointmentSearch.do">高级查询</a>
        </div>
    </div>
</div>
</body>
</html> 