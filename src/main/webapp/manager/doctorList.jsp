<%--
  Created by IntelliJ IDEA.
  User: 20821
  Date: 2025/7/9
  Time: 16:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title></title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder"> 内容列表</strong> <a href="${pageContext.request.contextPath}/manager/addDoctor.do" style="float:right; display:none;">添加字段</a></div>
    <form method="post" action="${pageContext.request.contextPath}/manager/doctorsSearch.do" id="listForm">
        <!-- 添加隐藏字段存储选中的医生ID -->
        <input type="hidden" name="selectedDoctorIds" id="selectedDoctorIds" value="${param.selectedDoctorIds}">

        <div class="padding border-bottom">
            <ul class="search" style="padding-left:10px;">
                <li>
                    <input type="hidden" name="page" id="page" value="${empty param.page ? 1 : param.page}">
                    <select name="departmentId" class="input" style="width:100px; line-height:17px;">
                        <option value="">请选择科室</option>
                        <c:forEach items="${departmentsSecondList}" var="d">
                            <option value="${d.departmentId}" ${param.departmentId==d.departmentId?"selected":""}>${d.departmentName}</option>
                        </c:forEach>
                    </select>
                </li>
                <li>
                    <select name="titleId" class="input" style="width:100px; line-height:17px;">
                        <option value="">请选择职称</option>
                        <c:forEach items="${titlesList}" var="pt">
                            <option value="${pt.id}" ${param.titleId==pt.id?"selected":""}>${pt.titleName}</option>
                        </c:forEach>
                    </select>
                </li>
                <li><input type="text" placeholder="请输入医生姓名" value="${param.doctorName}" name="doctorName" class="input" style="width:150px; line-height:17px;display:inline-block" /></li>
                <li><input type="text" placeholder="请输入医生工号" value="${param.jobNumber}" name="jobNumber" class="input" style="width:150px; line-height:17px;display:inline-block" /></li>
                <li><a href="javascript:submitFormData()" class="button border-main icon-search" > 搜索</a></li>
                <li> <a class="button border-main icon-plus-square-o" href="${pageContext.request.contextPath}/manager/addDoctor.jsp"> 添加</a> </li>
            </ul>
        </div>
    </form>
    <c:set var="selectedIds" value="${fn:split(param.selectedDoctorIds, ',')}" />

    <script>
        // 全局变量存储选中的医生ID
        var selectedDoctors = {
            ids: {},
            // 初始化选中状态
            init: function() {
                var idsParam = "${param.selectedDoctorIds}";
                if (idsParam) {
                    var idsArray = idsParam.split(',');
                    for (var i = 0; i < idsArray.length; i++) {
                        this.ids[idsArray[i]] = true;
                    }
                }
            },
            // 添加或移除ID
            toggle: function(id) {
                if (this.ids[id]) {
                    delete this.ids[id];
                } else {
                    this.ids[id] = true;
                }
                this.updateHiddenField();
            },
            // 全选/取消全选
            toggleAll: function(selectAll) {
                if (selectAll) {
                    // 获取所有医生ID
                    var allIds = [];
                    <c:forEach items="${allDoctorIds}" var="doctorId">
                    allIds.push("${doctorId}");
                    </c:forEach>

                    for (var i = 0; i < allIds.length; i++) {
                        this.ids[allIds[i]] = true;
                    }
                } else {
                    this.ids = {};
                }
                this.updateHiddenField();
            },
            // 更新隐藏字段
            updateHiddenField: function() {
                var idsArray = Object.keys(this.ids);
                $('#selectedDoctorIds').val(idsArray.join(','));
            },
            // 检查是否选中
            isSelected: function(id) {
                return this.ids[id];
            },
            // 获取选中的ID数量
            getCount: function() {
                return Object.keys(this.ids).length;
            }
        };

        // 页面加载时初始化
        $(document).ready(function() {
            selectedDoctors.init();

            // 设置初始选中状态
            $('input[name="doctorIds"]').each(function() {
                var id = $(this).val();
                $(this).prop('checked', selectedDoctors.isSelected(id));
            });

            // 全选/反选功能
            $("#checkall").click(function() {
                var isChecked = $(this).prop('checked');
                selectedDoctors.toggleAll(isChecked);

                // 更新当前页选中状态
                $('input[name="doctorIds"]').prop('checked', isChecked);
            });

            // 单个复选框点击
            $('input[name="doctorIds"]').click(function() {
                var id = $(this).val();
                selectedDoctors.toggle(id);

                // 更新全选框状态
                var allChecked = true;
                $('input[name="doctorIds"]').each(function() {
                    if (!$(this).prop('checked')) {
                        allChecked = false;
                        return false; // 退出循环
                    }
                });
                $("#checkall").prop('checked', allChecked);
            });
        });

        function submitFormData(){
            document.getElementById("listForm").submit();
        }

        function changePage(page){
            document.getElementById("page").value = page;
            document.getElementById("listForm").submit();
        }

        function batchDelete() {
            if (selectedDoctors.getCount() === 0) {
                alert("请至少选择一位医生！");
                return;
            }

            if (confirm("确定要删除选中的" + selectedDoctors.getCount() + "位医生吗？")) {
                // 创建表单提交
                var form = $('<form>', {
                    method: 'post',
                    action: '${pageContext.request.contextPath}/manager/deleteDoctors.do'
                });

                // 添加选中的医生ID
                form.append($('<input>', {
                    type: 'hidden',
                    name: 'doctorIds',
                    value: Object.keys(selectedDoctors.ids).join(',')
                }));

                // 添加原搜索参数
                form.append($('<input>', {
                    type: 'hidden',
                    name: 'departmentId',
                    value: '${param.departmentId}'
                }));

                form.append($('<input>', {
                    type: 'hidden',
                    name: 'titleId',
                    value: '${param.titleId}'
                }));

                form.append($('<input>', {
                    type: 'hidden',
                    name: 'doctorName',
                    value: '${param.doctorName}'
                }));

                form.append($('<input>', {
                    type: 'hidden',
                    name: 'jobNumber',
                    value: '${param.jobNumber}'
                }));

                form.append($('<input>', {
                    type: 'hidden',
                    name: 'page',
                    value: '${param.page}'
                }));

                form.append($('<input>', {
                    type: 'hidden',
                    name: 'selectedDoctorIds',
                    value: $('#selectedDoctorIds').val()
                }));

                // 提交表单
                form.appendTo('body').submit();
            }
        }
    </script>
    <table class="table table-hover text-center">
        <tr>
            <th width="10%">
                <input type="checkbox" id="checkall"> 全选所有页
            </th>
            <!-- 其他表头保持不变 -->
        </tr>
        <tr>
            <th width="10%">编号</th>
            <th width="10%">工号</th>
            <th width="25%">图片</th>
            <th width="15%">姓名</th>
            <th width="10%">科室</th>
            <th width="15%">职称</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${pageInfo.list}" var="doctor">
            <tr>
                <td>
                    <c:set var="isSelected" value="false" />
                    <c:forEach items="${selectedIds}" var="id">
                        <c:if test="${id eq doctor.doctorId}">
                            <c:set var="isSelected" value="true" />
                        </c:if>
                    </c:forEach>
                    <input type="checkbox" name="doctorIds" value="${doctor.doctorId}"
                        ${isSelected ? 'checked' : ''}/>
                        ${doctor.doctorId}
                </td>
                <td>${doctor.jobNumber}</td>
                <td><img src="${pageContext.request.contextPath}/${doctor.avatar}" style="width:80px"></td>
                <td>${doctor.name}</td>
                <td>${doctor.departments.departmentName}</td>
                <td>${doctor.titles.titleName}</td>
                <td>
                    <div class="button-group">
                        <a class="button border-main"
                           href="${pageContext.request.contextPath}/manager/updateDoctor.do?name=${doctor.name}">
                            <span class="icon-edit"></span> 修改</a>

                        <a class="button border-red"
                           href="${pageContext.request.contextPath}/manager/deleteDoctor.do?name=${doctor.name}"
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
                    <a href="javascript:changePage(1)">首页</a>
                    <c:forEach begin="1" end="${pageInfo.pages}" var="i">
                        <c:choose>
                            <c:when test="${i==pageInfo.pageNum}">
                                <span class="current">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:changePage(${i})">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <a href="javascript:changePage(${pageInfo.pages})">尾页</a>
                </div>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
