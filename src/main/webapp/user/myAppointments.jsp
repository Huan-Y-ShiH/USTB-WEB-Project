<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>我的门诊预约</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong><span class="icon-calendar"></span> 我的门诊预约</strong></div>
    <div class="padding border-bottom">
        <ul class="search">
            <li>
                <a href="user/addAppointment.do" class="button border-main icon-plus-square-o"> 新增预约</a>
            </li>
            <li>
                <a href="user/appointmentSearch.do" class="button border-blue icon-search"> 高级查询</a>
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
            <th>操作</th>
        </tr>
        <c:forEach var="a" items="${appointments}">
            <tr>
                <td>${a.appointmentId}</td>
                <td>${a.doctor.name}</td>
                <td>${a.department.departmentName}</td>
                <td>${a.appointmentDate}</td>
                <td>${a.appointmentTime}</td>
                <td>
                    <c:choose>
                        <c:when test="${a.status == 'booked'}"><span class="label label-success">已预约</span></c:when>
                        <c:when test="${a.status == 'cancelled'}"><span class="label label-danger">已取消</span></c:when>
                        <c:when test="${a.status == 'completed'}"><span class="label label-primary">已完成</span></c:when>
                        <c:otherwise><span class="label label-warning">${a.status}</span></c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <a class="button border-blue button-little" href="user/appointmentDetail.do?appointmentId=${a.appointmentId}">查看详情</a>
                    <c:if test="${a.status == 'booked'}">
                        <a class="button border-red button-little" href="javascript:deleteAppointment(${a.appointmentId})">取消预约</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
    <div class="panel-foot text-center">
        <ul class="pagination">
            <li><a href="#">上一页</a></li>
            <li class="active"><a href="#">1</a></li>
            <li><a href="#">2</a></li>
            <li><a href="#">下一页</a></li>
        </ul>
    </div>
</div>

<script>
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