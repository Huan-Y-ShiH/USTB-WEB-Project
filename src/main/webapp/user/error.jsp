<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>错误信息</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <style>
        .error-container {
            max-width: 600px;
            margin: 100px auto;
            text-align: center;
            background: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .error-icon {
            font-size: 64px;
            color: #dc3545;
            margin-bottom: 20px;
        }
        .error-message {
            font-size: 18px;
            color: #333;
            margin-bottom: 30px;
        }
        .error-actions {
            margin-top: 30px;
        }
        .error-actions a {
            margin: 0 10px;
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-icon">
        <span class="icon-exclamation-triangle"></span>
    </div>
    <div class="error-message">
        ${error}
    </div>
    <div class="error-actions">
        <a href="javascript:history.back()" class="button border-blue">返回上一页</a>
        <a href="user/appointment.do" class="button border-green">返回预约列表</a>
        <a href="user/index.jsp" class="button border-yellow">返回首页</a>
    </div>
</div>
</body>
</html> 