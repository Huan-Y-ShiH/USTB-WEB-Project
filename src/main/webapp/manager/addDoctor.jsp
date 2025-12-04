<%--
  Created by IntelliJ IDEA.
  User: 86198
  Date: 2025/7/10
  Time: 16:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>添加医生</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel margin-top">
    <div class="panel-head" id="add"><strong><span class="icon-pencil-square-o"></span>添加医生</strong></div>
    <div class="body-content">
        <form method="post" class="form-x" action="${pageContext.request.contextPath}/manager/addDoctor.do" enctype="multipart/form-data">
            <!-- 工号 -->
            <div class="form-group">
                <div class="label">
                    <label>工号：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="jobNumber" value="" data-validate="required:请输入工号" />
                </div>
            </div>

            <!-- 通行密码 -->
            <div class="form-group">
                <div class="label">
                    <label>密码：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="passWord" value="" data-validate="required:请输入密码" />
                </div>
            </div>

            <!-- 医生姓名 -->
            <div class="form-group">
                <div class="label">
                    <label>医生姓名：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="name" value="" data-validate="required:请输入姓名" />
                </div>
            </div>

            <!-- 头像上传 -->
            <div class="form-group">
                <div class="label">
                    <label>头像：</label>
                </div>
                <div class="field">
                    <input type="file" name="imgFile" accept="image/*" class="input w50" data-validate="required:请选择头像图片" />
                </div>
            </div>

            <!-- 电话 -->
            <div class="form-group">
                <div class="label">
                    <label>电话：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="phone" value="" data-validate="required:请输入电话" />
                </div>
            </div>

            <!-- 邮箱 -->
            <div class="form-group">
                <div class="label">
                    <label>邮箱：</label>
                </div>
                <div class="field">
                    <input type="email" class="input w50" name="email" value="" data-validate="required:请输入邮箱" />
                </div>
            </div>

            <!-- 简介 -->
            <div class="form-group">
                <div class="label">
                    <label>简介：</label>
                </div>
                <div class="field">
                    <textarea class="input" name="introduction" style="height:100px;"></textarea>
                </div>
            </div>

            <!-- 挂号费 -->
            <div class="form-group">
                <div class="label">
                    <label>挂号费：</label>
                </div>
                <div class="field">
                    <input type="number" step="0.01" class="input w50" name="registrationFee" value="" data-validate="required:请输入挂号费" />
                </div>
            </div>

            <!-- 入职日期 -->
            <div class="form-group">
                <div class="label">
                    <label>入职日期：</label>
                </div>
                <div class="field">
                    <input type="date" class="input w50" name="entryDate" value="" data-validate="required:请选择入职日期" />
                </div>
            </div>

            <!-- 科室 -->
            <div class="form-group">
                <div class="label">
                    <label>科室：</label>
                </div>
                <div class="field">
                    <select name="departmentId" class="input" style="width:100px; line-height:17px;">
                        <option value="">请选择科室</option>
                        <c:forEach items="${departmentsSecondList}" var="dept">
                            <option value="${dept.departmentId}"${param.departmentId==dept.departmentId?"selected":""}>${dept.departmentName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <!-- 职称 -->
            <div class="form-group">
                <div class="label">
                    <label>职称：</label>
                </div>
                <div class="field">
                    <select name="titleId" class="input" style="width:100px; line-height:17px;">
                        <option value="">请选择职称</option>
                        <c:forEach items="${titlesList}" var="title">
                            <option value="${title.id}" ${param.titleId==title.id?"selected":""}>${title.titleName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <div class="label">
                    <label></label>
                </div>
                <div class="field">
                    <button class="button bg-main icon-check-square-o" type="submit">提交</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>