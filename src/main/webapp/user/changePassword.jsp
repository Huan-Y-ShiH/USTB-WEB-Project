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
    <title>修改密码</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <style>
        .password-form {
            max-width: 500px;
            margin: 20px auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .form-group input:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 0 2px rgba(0,123,255,0.25);
        }
        .button-group {
            text-align: center;
            margin-top: 30px;
        }
        .button-group button, .button-group a {
            margin: 0 10px;
        }
        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
        }
        .success-message {
            color: #28a745;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong><span class="icon-lock"></span> 修改密码</strong></div>
    
    <div class="password-form">
        <form id="changePasswordForm" method="post" action="user/changePassword.do">
            <div class="form-group">
                <label for="oldPassword">当前密码：</label>
                <input type="password" id="oldPassword" name="oldPassword" required placeholder="请输入当前密码">
                <div class="error-message" id="oldPasswordError"></div>
            </div>
            
            <div class="form-group">
                <label for="newPassword">新密码：</label>
                <input type="password" id="newPassword" name="newPassword" required placeholder="请输入新密码">
                <div class="error-message" id="newPasswordError"></div>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">确认新密码：</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="请再次输入新密码">
                <div class="error-message" id="confirmPasswordError"></div>
            </div>
            
            <div class="button-group">
                <button type="button" class="button bg-main" onclick="submitForm()">确认修改</button>
                <a href="user/info.do" class="button bg-gray">返回</a>
            </div>
        </form>
    </div>
</div>

<script>
function submitForm() {
    // 清除之前的错误信息
    $('.error-message').text('');
    
    var oldPassword = $('#oldPassword').val();
    var newPassword = $('#newPassword').val();
    var confirmPassword = $('#confirmPassword').val();
    
    // 基本验证
    if (!oldPassword) {
        $('#oldPasswordError').text('请输入当前密码');
        return;
    }
    
    if (!newPassword) {
        $('#newPasswordError').text('请输入新密码');
        return;
    }
    
    if (newPassword.length < 6) {
        $('#newPasswordError').text('新密码长度不能少于6位');
        return;
    }
    
    if (newPassword === oldPassword) {
        $('#newPasswordError').text('新密码不能与当前密码相同');
        return;
    }
    
    if (!confirmPassword) {
        $('#confirmPasswordError').text('请确认新密码');
        return;
    }
    
    if (newPassword !== confirmPassword) {
        $('#confirmPasswordError').text('两次输入的密码不一致');
        return;
    }
    
    // 确认修改
    if (confirm('确定要修改密码吗？')) {
        $.ajax({
            url: 'user/changePassword.do',
            type: 'POST',
            data: {
                oldPassword: oldPassword,
                newPassword: newPassword,
                confirmPassword: confirmPassword
            },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    alert('密码修改成功！');
                    window.location.href = 'user/info.do';
                } else {
                    alert('密码修改失败：' + response.message);
                }
            },
            error: function() {
                alert('修改失败，请重试');
            }
        });
    }
}

// 回车键提交
$(document).keypress(function(e) {
    if (e.which == 13) { // Enter key
        submitForm();
    }
});
</script>
</body>
</html> 