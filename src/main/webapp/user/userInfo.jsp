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
    <title>个人信息维护</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel" style="max-width: 600px; margin: 20px auto;">
    <div class="panel-head"><strong><span class="icon-user"></span> 个人信息维护</strong></div>
    <div class="panel-body" style="padding:30px;">
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">${successMessage}</div>
        </c:if>
        <form class="form-x" method="post" action="user/info.do">
            <div class="form-group">
                <div class="label"><label>姓名</label></div>
                <div class="field">
                    <input type="text" class="input" name="pname" value="${patient.pname}" required data-validate="required:请输入姓名" />
                </div>
            </div>
            <div class="form-group">
                <div class="label"><label>手机号</label></div>
                <div class="field">
                    <input type="text" class="input" name="phone" value="${patient.phone}" required data-validate="required:请输入手机号,mobile:请输入正确的手机号" />
                </div>
            </div>
            <div class="form-group">
                <div class="label"><label>身份证号</label></div>
                <div class="field">
                    <input type="text" class="input" value="${patient.idCardNumber}" readonly
                           style="width: 100%; font-family: monospace; letter-spacing: 1px;"/>
                </div>
            </div>
            <div class="form-group">
                <div class="label"><label>邮箱</label></div>
                <div class="field">
                    <input type="email" class="input" name="email" value="${patient.email}" data-validate="email:请输入正确的邮箱地址" />
                </div>
            </div>
            <div class="form-group">
                <div class="label"><label>账户余额</label></div>
                <div class="field">
                    <input type="text" class="input" value="￥${patient.balance}" readonly
                           style="width: 100%; font-family: monospace; letter-spacing: 1px;"/>
                </div>
            </div>
            <div class="form-button">
                <button class="button bg-main" type="submit">保存修改</button>
                <a href="user/changePassword.do" class="button bg-blue" style="margin-left: 10px;">修改密码</a>
                <a href="user/index.jsp" class="button bg-gray" style="margin-left: 10px;">返回主页</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>