<%--
  医生修改密码页面
  Created by IntelliJ IDEA.
  User: 王知涵
  Date: 2025/1/10
  Time: 17:30
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
    <title>修改密码</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-lock"> 修改密码</strong></div>
    
    <!-- 显示错误消息 -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
            <span class="close" onclick="this.parentNode.style.display='none';">&times;</span>
            ${errorMessage}
        </div>
    </c:if>
    
    <div class="body-content">
        <form method="post" class="form-x" action="${pageContext.request.contextPath}/doctor/updatePassword.do" id="passwordForm">
            <div class="form-group">
                <div class="label">
                    <label>当前密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input" name="oldPassword" id="oldPassword"
                           data-validate="required:请输入当前密码" maxlength="20" />
                    <div class="tips">请输入您当前使用的密码</div>
                </div>
            </div>
            
            <div class="form-group">
                <div class="label">
                    <label>新密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input" name="newPassword" id="newPassword"
                           data-validate="required:请输入新密码" minlength="6" maxlength="20" />
                    <div class="tips">密码长度至少6位，建议包含字母和数字</div>
                </div>
            </div>
            
            <div class="form-group">
                <div class="label">
                    <label>确认新密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input" name="confirmPassword" id="confirmPassword"
                           data-validate="required:请确认新密码" maxlength="20" />
                    <div class="tips">请再次输入新密码进行确认</div>
                </div>
            </div>
            
            <div class="form-group">
                <div class="label">
                    <label>安全提示：</label>
                </div>
                <div class="field">
                    <div class="alert alert-info">
                        <strong>温馨提示：</strong><br/>
                        • 新密码长度至少6位<br/>
                        • 建议使用字母、数字组合以提高安全性<br/>
                        • 密码修改成功后需要使用新密码登录<br/>
                        • 请妥善保管您的密码，不要告诉他人
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <div class="label">
                    <label></label>
                </div>
                <div class="field">
                    <button class="button bg-main icon-check-square-o" type="submit"> 修改密码</button>
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
    $("#passwordForm").validate({
        debug: false,
        success: "valid",
        rules: {
            oldPassword: {
                required: true,
                minlength: 1
            },
            newPassword: {
                required: true,
                minlength: 6
            },
            confirmPassword: {
                required: true,
                equalTo: "#newPassword"
            }
        },
        messages: {
            oldPassword: {
                required: "请输入当前密码",
                minlength: "请输入有效的密码"
            },
            newPassword: {
                required: "请输入新密码",
                minlength: "新密码长度至少6位"
            },
            confirmPassword: {
                required: "请确认新密码",
                equalTo: "两次输入的密码不一致"
            }
        },
        submitHandler: function(form) {
            // 表单验证通过后提交
            form.submit();
        }
    });
    
    // 实时验证新密码强度
    $("#newPassword").keyup(function(){
        var password = $(this).val();
        var strength = checkPasswordStrength(password);
        var tips = $(this).next('.tips');
        
        if (password.length > 0) {
            if (strength === 'weak') {
                tips.html('<span style="color: #ff6b6b;">密码强度：弱 - 建议包含字母和数字</span>');
            } else if (strength === 'medium') {
                tips.html('<span style="color: #ffa500;">密码强度：中等</span>');
            } else if (strength === 'strong') {
                tips.html('<span style="color: #51cf66;">密码强度：强</span>');
            }
        } else {
            tips.html('密码长度至少6位，建议包含字母和数字');
        }
    });
    
    // 实时验证确认密码
    $("#confirmPassword").keyup(function(){
        var newPassword = $("#newPassword").val();
        var confirmPassword = $(this).val();
        var tips = $(this).next('.tips');
        
        if (confirmPassword.length > 0) {
            if (newPassword === confirmPassword) {
                tips.html('<span style="color: #51cf66;">密码确认正确</span>');
            } else {
                tips.html('<span style="color: #ff6b6b;">两次输入的密码不一致</span>');
            }
        } else {
            tips.html('请再次输入新密码进行确认');
        }
    });
});

// 检查密码强度
function checkPasswordStrength(password) {
    if (password.length < 6) return 'weak';
    
    var hasLetter = /[a-zA-Z]/.test(password);
    var hasNumber = /\d/.test(password);
    var hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);
    
    if (hasLetter && hasNumber && hasSpecial) {
        return 'strong';
    } else if ((hasLetter && hasNumber) || (hasLetter && hasSpecial) || (hasNumber && hasSpecial)) {
        return 'medium';
    } else {
        return 'weak';
    }
}
</script>
</body>
</html> 