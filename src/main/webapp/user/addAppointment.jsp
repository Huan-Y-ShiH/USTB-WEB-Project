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
    <title>新增预约</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <style>
        .form-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: inline-block;
            width: 80px;
            font-weight: bold;
            color: #333;
        }
        .form-group select, .form-group input {
            width: 300px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .form-group select:focus, .form-group input:focus {
            border-color: #007bff;
            outline: none;
        }
        .button-group {
            text-align: center;
            margin-top: 30px;
        }
        .button-group button, .button-group a {
            margin: 0 10px;
        }
        .loading {
            color: #999;
            font-style: italic;
        }
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong><span class="icon-plus"></span> 新增预约</strong></div>
    
    <div class="form-container">
        <form id="addAppointmentForm" method="post" action="user/addAppointment.do">
            <div class="form-group">
                <label>科室：</label>
                <select id="departmentSelect" name="departmentId" required>
                    <option value="">请选择科室</option>
                    <c:forEach var="dept" items="${departments}">
                        <option value="${dept.departmentId}">${dept.departmentName}</option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label>医生：</label>
                <select id="doctorSelect" name="doctorId" required>
                    <option value="">请先选择科室</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>预约日期：</label>
                <input type="date" name="appointmentDate" required min="${minDate}">
            </div>
            
            <div class="form-group">
                <label>预约时段：</label>
                <select name="appointmentTime" required>
                    <option value="">请选择时段</option>
                    <option value="上午">上午</option>
                    <option value="下午">下午</option>
                </select>
            </div>
            
            <div class="button-group">
                <button type="button" class="button border-main icon-check" onclick="checkAndSubmit()">提交预约</button>
                <a href="user/appointment.do" class="button border-blue icon-arrow-left">返回预约列表</a>
            </div>
        </form>
    </div>
</div>

<script>
$(document).ready(function() {
    // 设置最小日期为今天
    var today = new Date().toISOString().split('T')[0];
    $('input[name="appointmentDate"]').attr('min', today);
});

// 选择科室后加载医生
$('#departmentSelect').change(function(){
    var deptId = $(this).val();
    var doctorSelect = $('#doctorSelect');
    
    if(!deptId){
        doctorSelect.html('<option value="">请先选择科室</option>');
        return;
    }
    
    // 显示加载状态
    doctorSelect.html('<option value="" class="loading">正在加载医生列表...</option>');
    
    $.ajax({
        url: 'user/doctorsByDepartment.do',
        type: 'GET',
        data: {departmentId: deptId},
        dataType: 'json',
        success: function(data){
            var html = '<option value="">请选择医生</option>';
            if(data && data.length > 0){
                for(var i = 0; i < data.length; i++){
                    html += '<option value="' + data[i].doctorId + '">' + data[i].name + '</option>';
                }
            } else {
                html = '<option value="">该科室暂无医生</option>';
            }
            doctorSelect.html(html);
        },
        error: function(){
            doctorSelect.html('<option value="">加载失败，请重试</option>');
        }
    });
});

// 校验并提交预约
function checkAndSubmit(){
    var form = $('#addAppointmentForm');
    var departmentId = $('#departmentSelect').val();
    var doctorId = $('#doctorSelect').val();
    var appointmentDate = $('input[name="appointmentDate"]').val();
    var appointmentTime = $('select[name="appointmentTime"]').val();
    
    // 基本校验
    if(!departmentId){
        alert('请选择科室');
        return;
    }
    if(!doctorId){
        alert('请选择医生');
        return;
    }
    if(!appointmentDate){
        alert('请选择预约日期');
        return;
    }
    if(!appointmentTime){
        alert('请选择预约时段');
        return;
    }
    
    // 确认提交
    if(confirm('确认提交预约吗？')){
        // AJAX提交预约
        $.ajax({
            url: 'user/addAppointment.do',
            type: 'POST',
            data: {
                doctorId: doctorId,
                appointmentDate: appointmentDate,
                appointmentTime: appointmentTime
            },
            dataType: 'json',
            success: function(response){
                if(response.success){
                    alert(response.message);
                    window.location.href = 'user/appointment.do';
                } else {
                    alert(response.message);
                }
            },
            error: function(){
                alert('提交失败，请重试');
            }
        });
    }
}
</script>
</body>
</html> 