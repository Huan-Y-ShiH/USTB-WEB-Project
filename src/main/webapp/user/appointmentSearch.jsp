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
    <title>预约查询</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <style>
        .search-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .search-form .form-group {
            margin-bottom: 15px;
        }
        .search-form label {
            display: inline-block;
            width: 80px;
            text-align: right;
            margin-right: 10px;
        }
        .search-form input, .search-form select {
            width: 200px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        .search-buttons {
            text-align: center;
            margin-top: 20px;
        }
        .search-buttons button {
            margin: 0 10px;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a {
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid #ddd;
            text-decoration: none;
            color: #333;
        }
        .pagination a:hover {
            background: #007bff;
            color: white;
        }
        .pagination .active a {
            background: #007bff;
            color: white;
        }
        .status-badge {
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 12px;
            color: white;
        }
        .status-booked { background: #28a745; }
        .status-cancelled { background: #dc3545; }
        .status-completed { background: #007bff; }
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong><span class="icon-search"></span> 预约查询</strong></div>
    
    <!-- 搜索表单 -->
    <div class="search-form">
        <form method="get" action="user/appointmentSearch.do">
            <div class="form-group">
                <label>开始日期:</label>
                <input type="date" name="startDate" value="${searchVo.startDate}">
                
                <label style="margin-left: 20px;">结束日期:</label>
                <input type="date" name="endDate" value="${searchVo.endDate}">
            </div>
            
            <div class="form-group">
                <label>预约状态:</label>
                <select name="status">
                    <option value="">全部状态</option>
                    <option value="booked" ${searchVo.status == 'booked' ? 'selected' : ''}>已预约</option>
                    <option value="cancelled" ${searchVo.status == 'cancelled' ? 'selected' : ''}>已取消</option>
                    <option value="completed" ${searchVo.status == 'completed' ? 'selected' : ''}>已完成</option>
                </select>
                
                <label style="margin-left: 20px;">医生姓名:</label>
                <input type="text" name="doctorName" value="${searchVo.doctorName}" placeholder="请输入医生姓名">
            </div>
            
            <div class="form-group">
                <label>科室名称:</label>
                <input type="text" name="departmentName" value="${searchVo.departmentName}" placeholder="请输入科室名称">
            </div>
            
            <div class="search-buttons">
                <button type="submit" class="button border-main icon-search">查询</button>
                <button type="button" class="button border-yellow" onclick="resetForm()">重置</button>
                <a href="user/appointment.do" class="button border-blue">返回我的预约</a>
            </div>
        </form>
    </div>
    
    <!-- 搜索结果 -->
    <div class="padding border-bottom">
        <ul class="search">
            <li>
                <span class="icon-info-circle"></span> 共找到 <strong>${total}</strong> 条预约记录
            </li>
        </ul>
    </div>
    
    <table class="table table-hover text-center">
        <tr>
            <th>预约ID</th>
            <th>医生姓名</th>
            <th>科室</th>
            <th>预约日期</th>
            <th>预约时间</th>
            <th>状态</th>
            <th>创建时间</th>
            <th>操作</th>
        </tr>
        <c:forEach var="appointment" items="${appointments}">
            <tr>
                <td>${appointment.appointmentId}</td>
                <td>${appointment.doctor.name}</td>
                <td>${appointment.department.departmentName}</td>
                <td>
                    <fmt:formatDate value="${appointment.appointmentDate}" pattern="yyyy-MM-dd"/>
                </td>
                <td>${appointment.appointmentTime}</td>
                <td>
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
                </td>
                <td>
                    <fmt:formatDate value="${appointment.createtime}" pattern="yyyy-MM-dd HH:mm"/>
                </td>
                <td>
                    <a class="button border-blue button-little" href="user/appointmentDetail.do?appointmentId=${appointment.appointmentId}">查看详情</a>
                    <c:if test="${appointment.status == 'booked'}">
                        <a class="button border-red button-little"
                           href="javascript:deleteAppointment(${appointment.appointmentId})">
                            取消预约
                        </a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
    
    <!-- 分页 -->
    <c:if test="${totalPages > 1}">
        <div class="panel-foot text-center">
            <ul class="pagination">
                <c:if test="${currentPage > 1}">
                    <li><a href="user/appointmentSearch.do?page=${currentPage-1}&startDate=${searchVo.startDate}&endDate=${searchVo.endDate}&status=${searchVo.status}&doctorName=${searchVo.doctorName}&departmentName=${searchVo.departmentName}">上一页</a></li>
                </c:if>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <li class="active"><a href="#">${i}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="user/appointmentSearch.do?page=${i}&startDate=${searchVo.startDate}&endDate=${searchVo.endDate}&status=${searchVo.status}&doctorName=${searchVo.doctorName}&departmentName=${searchVo.departmentName}">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <c:if test="${currentPage < totalPages}">
                    <li><a href="user/appointmentSearch.do?page=${currentPage+1}&startDate=${searchVo.startDate}&endDate=${searchVo.endDate}&status=${searchVo.status}&doctorName=${searchVo.doctorName}&departmentName=${searchVo.departmentName}">下一页</a></li>
                </c:if>
            </ul>
        </div>
    </c:if>
</div>

<script>
function resetForm() {
    document.querySelector('input[name="startDate"]').value = '';
    document.querySelector('input[name="endDate"]').value = '';
    document.querySelector('select[name="status"]').value = '';
    document.querySelector('input[name="doctorName"]').value = '';
    document.querySelector('input[name="departmentName"]').value = '';
}

function deleteAppointment(appointmentId) {
    if(confirm('确定要删除这个预约吗？删除后无法恢复！')) {
        $.ajax({
            url: 'user/deleteAppointment.do',
            type: 'POST',
            data: {
                appointmentId: appointmentId
            },
            dataType: 'json',
            success: function(response) {
                if(response.success) {
                    alert(response.message);
                    location.reload(); // 刷新页面
                } else {
                    alert(response.message);
                }
            },
            error: function() {
                alert('删除失败，请重试');
            }
        });
    }
}
</script>
</body>
</html> 