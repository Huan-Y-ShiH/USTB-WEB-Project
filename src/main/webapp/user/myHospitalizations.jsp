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
    <title>我的住院预约</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong><span class="icon-bed"></span> 我的住院预约</strong></div>
    <div class="padding border-bottom">
        <ul class="search">
            <li>
                <a href="user/hospitalizationSearch.do" class="button border-blue icon-search"> 高级查询</a>
            </li>
        </ul>
    </div>
    <table class="table table-hover text-center">
        <tr>
            <th>住院ID</th>
            <th>房间号</th>
            <th>费用</th>
            <th>支付状态</th>
            <th>医保状态</th>
            <th>住院状态</th>
        </tr>
        <c:forEach var="h" items="${hospitalizations}">
            <tr>
                <td>${h.hospitalizationId}</td>
                <td>${h.roomNumber}</td>
                <td>￥${h.cost}</td>
                <td>
                    <c:choose>
                        <c:when test="${h.paymentStatus == 'paid'}"><span class="label label-success">已支付</span></c:when>
                        <c:otherwise><span class="label label-warning">未支付</span></c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${h.isInsured == true}"><span class="label label-primary">医保</span></c:when>
                        <c:otherwise><span class="label">自费</span></c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${h.hospitalizationStatus == 'in_progress'}"><span class="label label-success">住院中</span></c:when>
                        <c:when test="${h.hospitalizationStatus == 'admitted'}"><span class="label label-success">已入院</span></c:when>
                        <c:when test="${h.hospitalizationStatus == 'discharged'}"><span class="label">已出院</span></c:when>
                        <c:otherwise><span class="label label-warning">${h.hospitalizationStatus}</span></c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>