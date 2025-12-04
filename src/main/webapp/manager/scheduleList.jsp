<%--
  Created by IntelliJ IDEA.
  User: 20821
  Date: 2025/7/16
  Time: 12:35
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
    <title></title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <script>
        $(document).ready(function() {
            // 页面加载时初始化二级科室
            initSecondDepartment();

            // 一级科室变更事件
            $("select[name='departmentFirstId']").change(function() {
                loadSecondDepartments($(this).val());
            });

            // 初始化二级科室的函数
            function initSecondDepartment() {
                var firstId = "${param.departmentFirstId}"; // 当前选中的一级科室ID
                var secondId = "${param.departmentSecondId}"; // 当前选中的二级科室ID

                if (firstId) {
                    loadSecondDepartments(firstId, secondId);
                }
            }

            // 加载二级科室的函数
            function loadSecondDepartments(firstId, selectedId) {
                $.ajax({
                    "url": "${pageContext.request.contextPath}/manager/getSecondDepartments.do",
                    "type": "GET",
                    "data": { departmentFirstId: firstId , time:Math.random() },
                    "dataType": "json",
                    "success": function(data) {
                        var $select = $("#departmentSecondId");
                        $select.empty().append('<option value="">请选择二级科室</option>');

                        $.each(data, function(i, item) {
                            var option = $('<option>').val(item.departmentId).text(item.departmentName);
                            if (selectedId && item.departmentId == selectedId) {
                                option.prop('selected', true);
                            }
                            $select.append(option);
                        });
                    },
                    error: function() {
                        console.log("加载二级科室失败");
                    }
                });
            }
        });
    </script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder"> 内容列表</strong> <a href="${pageContext.request.contextPath}/manager/addDoctor.do" style="float:right; display:none;">添加字段</a></div>
    <form method="post" action="${pageContext.request.contextPath}/manager/scheduleSearch.do" id="listForm">
        <div class="padding border-bottom">
            <ul class="search" style="padding-left:10px;">
                <li>
                    <%--设置用户请求的当前页--%>
                    <input type="hidden" name="page" id="page" value="1">
                    <%--    设置一级科室--%>
                    <select name="departmentFirstId" class="input" style="width:100px; line-height:17px;">
                        <option value="">请选择一级科室</option>
                        <c:forEach items="${departmentsFirstList}" var="d">
                            <option value="${d.departmentId}" ${param.departmentFirstId==d.departmentId?"selected":""}>${d.departmentName}</option>
                        </c:forEach>
                    </select>
                </li>
                <li>
                <select name="departmentSecondId" id="departmentSecondId" class="input" style="width:100px; line-height:17px;">
                    <option value="">请选择二级科室</option>
                </select>
                </li>
                <li>
                    <input type="date" name="queryDate" class="input" style="width:150px; line-height:17px;"
                           value="${param.queryDate}">
                </li>
                <li><a href="javascript:submitFormData()" class="button border-main icon-search" > 搜索</a></li>
                <li><a class="button border-main icon-plus-square-o" href="${pageContext.request.contextPath}/manager/addSchedule.jsp"> 添加</a> </li>
            </ul>
        </div>
    </form>
    <script>
        function submitFormData(){
            // 更新一级科室隐藏字段
            var firstDept = $("#firstDeptSelect").val();
            $("input[name='departmentFirstId']").val(firstDept);

            // 更新二级科室隐藏字段
            var secondDept = $("#secondDeptSelect").val();
            $("input[name='departmentSecondId']").val(secondDept);

            // 重置页码为1
            $("#page").val(1);

            // 提交表单
            document.getElementById("listForm").submit();
        }
        function buildPageUrl(pageNum) {
            var url = "${pageContext.request.contextPath}/manager/scheduleSearch.do?page=" + pageNum;

            // 添加一级科室参数
            var firstId = "${param.departmentFirstId}";
            if (firstId) {
                url += "&departmentFirstId=" + firstId;
            }

            // 添加二级科室参数
            var secondId = "${param.departmentSecondId}";
            if (secondId) {
                url += "&departmentSecondId=" + secondId;
            }

            var queryDate = "${param.queryDate}";
            if (queryDate) {
                url += "&queryDate=" + encodeURIComponent(queryDate); // 确保URL安全
            }

            return url;
        }
    </script>
    <table class="table table-hover text-center">
        <tr>
            <th width="10%">编号</th>
            <th width="15%">医生姓名</th>
            <th width="40%">科室日期</th>
            <th width="25%">科室时间</th>
            <th width="10%">科室人数</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${pageInfo.list}" var="schedule">
            <tr>
                <td>${schedule.scheduleId}</td>
                <td>${schedule.doctors.name}</td>
                <td><fmt:formatDate value="${schedule.date}" pattern="yyyy-MM-dd" /></td>
                <td>${schedule.shiftTime}</td>
                <td>
                    <c:choose>
                        <c:when test="${empty schedule.sumCount}">0</c:when>
                        <c:otherwise>${schedule.sumCount}</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <div class="button-group">
                        <a class="button border-red"
                           href="${pageContext.request.contextPath}/manager/delSchedule.do?scheduleId=${schedule.scheduleId}"
                           onclick="return confirm('您确定要删除吗?')">
                            <span class="icon-trash-o"></span> 删除</a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="8">
                <div class="pagelist">
                    <span class="current">总记录数${pageInfo.total}</span>
                    <a href="javascript:void(0)" onclick="location.href=buildPageUrl(1)">首页</a>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <a href="javascript:void(0)" onclick="location.href=buildPageUrl(${pageInfo.prePage})">上一页</a>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="i">
                        <c:choose>
                            <c:when test="${i == pageInfo.pageNum}">
                                <span class="current">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:void(0)" onclick="location.href=buildPageUrl(${i})">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <a href="javascript:void(0)" onclick="location.href=buildPageUrl(${pageInfo.nextPage})">下一页</a>
                    </c:if>
                    <a href="javascript:void(0)" onclick="location.href=buildPageUrl(${pageInfo.pages})">尾页</a>
                </div>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
