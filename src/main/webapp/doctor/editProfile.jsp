<%--
  医生个人信息编辑页面
  Created by IntelliJ IDEA.
  User: 王知涵
  Date: 2025/1/10
  Time: 16:40
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
    <title>编辑个人信息</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-edit"> 编辑个人信息</strong></div>
    
    <!-- 显示错误或成功消息 -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
            <span class="close" onclick="this.parentNode.style.display='none';">&times;</span>
            ${errorMessage}
        </div>
    </c:if>
    
    <div class="body-content">
        <form method="post" class="form-x" action="${pageContext.request.contextPath}/doctor/updateInfo.do">
            <div class="form-group">
                <div class="label">
                    <label>姓名：</label>
                </div>
                <div class="field">
                    <input type="text" class="input" name="name" value="${doctor.name}" 
                           data-validate="required:请输入姓名" maxlength="20" />
                    <div class="tips">请输入您的真实姓名</div>
                </div>
            </div>
            
            <div class="form-group">
                <div class="label">
                    <label>联系电话：</label>
                </div>
                <div class="field">
                    <input type="text" class="input" name="phone" value="${doctor.phone}" 
                           pattern="^1[3456789]\d{9}$" maxlength="11" />
                    <div class="tips">请输入11位手机号码</div>
                </div>
            </div>
            
            <div class="form-group">
                <div class="label">
                    <label>邮箱：</label>
                </div>
                <div class="field">
                    <input type="email" class="input" name="email" value="${doctor.email}" 
                           maxlength="50" />
                    <div class="tips">请输入有效的邮箱地址</div>
                </div>
            </div>
            
            <div class="form-group">
                <div class="label">
                    <label>工号：</label>
                </div>
                <div class="field">
                    <input type="text" class="input" value="${doctor.jobNumber}" readonly />
                    <div class="tips">工号不可修改</div>
                </div>
            </div>
            
            <div class="form-group">
                <div class="label">
                    <label>科室：</label>
                </div>
                <div class="field">
                    <input type="text" class="input" value="${doctor.departments.departmentName}" readonly />
                    <div class="tips">科室信息不可修改，如需更改请联系管理员</div>
                </div>
            </div>
            
            <div class="form-group">
                <div class="label">
                    <label>职称：</label>
                </div>
                <div class="field">
                    <input type="text" class="input" value="${doctor.titles.titleName}" readonly />
                    <div class="tips">职称信息不可修改，如需更改请联系管理员</div>
                </div>
            </div>
            
            <div class="form-group">
                <div class="label">
                    <label></label>
                </div>
                <div class="field">
                    <button class="button bg-main icon-check-square-o" type="submit"> 保存修改</button>
                    <button class="button bg-gray icon-times" type="button" onclick="goBack()"> 取消</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
function goBack() {
    if (window.parent && window.parent.location) {
        // 如果在iframe中，让父窗口跳转
        window.parent.location.href = "${pageContext.request.contextPath}/doctor/profile.jsp";
    } else {
        // 否则直接跳转
        window.location.href = "${pageContext.request.contextPath}/doctor/profile.jsp";
    }
}

// 表单验证
$(function(){
    $(".form-x").validate({
        debug: false,
        success: "valid",
        submitHandler: function(form) {
            // 表单验证通过后提交
            form.submit();
        }
    });
    
    // 手机号码验证
    $("input[name='phone']").blur(function(){
        var phone = $(this).val();
        if(phone && !/^1[3456789]\d{9}$/.test(phone)){
            alert("请输入正确的手机号码格式");
            $(this).focus();
        }
    });
    
    // 邮箱验证
    $("input[name='email']").blur(function(){
        var email = $(this).val();
        if(email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)){
            alert("请输入正确的邮箱格式");
            $(this).focus();
        }
    });
});
</script>
</body>
</html> 