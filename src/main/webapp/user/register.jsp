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
    <title>用户注册</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="bg"></div>
<div class="container">
    <div class="line bouncein">
        <div class="xs6 xm4 xs3-move xm4-move">
            <div style="height:50px;"></div>
            <div class="media media-y margin-big-bottom"></div>
            <form action="${pageContext.request.contextPath}/user/register.do" method="post">
                <div class="panel loginbox">
                    <div class="text-center margin-big padding-big-top"><h1>用户注册</h1></div>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>
                    <div class="panel-body" style="padding:30px; padding-bottom:10px; padding-top:10px;">
                        <div class="form-group">
                            <div class="field field-icon-right">
                                <input type="text" class="input input-big" name="phone" placeholder="手机号"
                                       data-validate="required:请填写手机号,mobile:请输入正确的手机号" />
                                <span class="icon icon-mobile margin-small"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="field field-icon-right">
                                <input type="password" class="input input-big" name="password" placeholder="密码"
                                       data-validate="required:请填写密码,length#>=6:密码长度不能小于6位" />
                                <span class="icon icon-key margin-small"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="field field-icon-right">
                                <input type="text" class="input input-big" name="pname" placeholder="真实姓名"
                                       data-validate="required:请填写真实姓名" />
                                <span class="icon icon-user margin-small"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="field field-icon-right">
                                <input type="text" class="input input-big" name="idCardNumber" placeholder="身份证号"
                                       data-validate="required:请填写身份证号,idcard:请输入正确的身份证号" />
                                <span class="icon icon-credit-card margin-small"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="field field-icon-right">
                                <input type="email" class="input input-big" name="email" placeholder="邮箱(可选)" />
                                <span class="icon icon-envelope margin-small"></span>
                            </div>
                        </div>
                    </div>
                    <div style="padding:30px;">
                        <input type="submit" class="button button-block bg-main text-big input-big" value="立即注册">
                        <div class="text-center margin-top">
                            已有账号？<a href="${pageContext.request.contextPath}/user/login.do" class="text-main">立即登录</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>