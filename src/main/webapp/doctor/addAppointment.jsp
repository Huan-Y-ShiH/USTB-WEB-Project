<%--
  医生端临时加号页面
  Created by IntelliJ IDEA.
  User: 王知涵
  Date: 2025/1/10
  Time: 22:00
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
    <title>临时加号</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <style>
        .appointment-form {
            background: #fff;
            border-radius: 6px;
            padding: 20px;
            margin: 20px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-group input:focus, .form-group select:focus {
            border-color: #5cb85c;
            outline: none;
            box-shadow: 0 0 5px rgba(92, 184, 92, 0.3);
        }
        
        .required {
            color: red;
        }
        
        .tips {
            color: #666;
            font-size: 12px;
            margin-top: 5px;
            line-height: 1.4;
        }
        
        .patient-switch {
            display: flex;
            margin-bottom: 20px;
            background: #f8f9fa;
            border-radius: 4px;
            padding: 10px;
        }
        
        .patient-switch label {
            margin-right: 20px;
            display: flex;
            align-items: center;
            cursor: pointer;
            font-weight: normal;
        }
        
        .patient-switch input[type="radio"] {
            margin-right: 5px;
            width: auto;
        }
        
        .emergency-notice {
            background: linear-gradient(135deg, #ffeaa7, #fab1a0);
            border: 1px solid #e17055;
            border-radius: 6px;
            padding: 15px;
            margin-bottom: 20px;
            color: #2d3436;
        }
        
        .emergency-notice h4 {
            margin: 0 0 10px 0;
            color: #d63031;
            font-size: 16px;
        }
        
        .doctor-info {
            background: #e8f4fd;
            border: 1px solid #b6e1ff;
            border-radius: 4px;
            padding: 15px;
            margin-bottom: 20px;
        }
        
        .btn-container {
            text-align: center;
            padding: 20px 0;
            border-top: 1px solid #eee;
            margin-top: 20px;
        }
        
        .btn-container button {
            margin: 0 10px;
            padding: 10px 30px;
            font-size: 16px;
        }
        
        .patient-existing, .patient-temp {
            display: none;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            padding: 15px;
            margin-top: 15px;
            background: #f8f9fa;
        }
        
        .patient-existing.active, .patient-temp.active {
            display: block;
        }
        
        .row {
            display: flex;
            gap: 20px;
        }
        
        .col-half {
            flex: 1;
        }
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong class="icon-plus-circle"> 临时加号 - ${doctor.name}医生</strong>
    </div>
    
    <div class="appointment-form">
        <!-- 医生信息展示 -->
        <div class="doctor-info">
            <h4><span class="icon-user-md"></span> 医生信息</h4>
            <p><strong>姓名：</strong>${doctor.name} &nbsp;&nbsp; 
               <strong>科室：</strong>${doctor.departments.departmentName} &nbsp;&nbsp;
               <strong>职称：</strong>${doctor.titles.titleName}</p>
        </div>
        
        <!-- 临时加号说明 -->
        <div class="emergency-notice">
            <h4><span class="icon-exclamation-triangle"></span> 临时加号说明</h4>
            <p>• 临时加号不受预约数量限制，适用于紧急情况<br>
               • 您只能为自己的科室添加预约<br>
               • 建议优先选择现有患者，如果是新患者请联系前台登记</p>
        </div>
        
        <!-- 错误信息显示 -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <span class="close" onclick="this.parentNode.style.display='none';">&times;</span>
                ${errorMessage}
            </div>
        </c:if>
        
        <form method="post" action="${pageContext.request.contextPath}/doctor/addAppointment.do">
            
            <!-- 患者类型选择 -->
            <div class="form-group">
                <label>患者类型<span class="required">*</span></label>
                <div class="patient-switch">
                    <label>
                        <input type="radio" name="useExistingPatient" value="true" checked onchange="togglePatientType()">
                        现有患者（推荐）
                    </label>
                    <label>
                        <input type="radio" name="useExistingPatient" value="false" onchange="togglePatientType()">
                        临时患者
                    </label>
                </div>
            </div>
            
            <!-- 现有患者选择 -->
            <div class="patient-existing active" id="existingPatient">
                <div class="form-group">
                    <label>选择患者<span class="required">*</span></label>
                    <select name="patientId">
                        <option value="">请选择患者</option>
                        <c:forEach items="${patientsList}" var="patient">
                            <option value="${patient.patientId}">
                                ${patient.pname} - ${patient.phone} - ${patient.idCardNumber}
                            </option>
                        </c:forEach>
                    </select>
                    <div class="tips">从系统中选择已注册的患者</div>
                </div>
            </div>
            
            <!-- 临时患者信息 -->
            <div class="patient-temp" id="tempPatient">
                <div class="row">
                    <div class="col-half">
                        <div class="form-group">
                            <label>患者姓名<span class="required">*</span></label>
                            <input type="text" name="patientName" placeholder="请输入患者姓名">
                            <div class="tips">请输入患者的真实姓名</div>
                        </div>
                    </div>
                    <div class="col-half">
                        <div class="form-group">
                            <label>联系电话<span class="required">*</span></label>
                            <input type="tel" name="patientPhone" placeholder="请输入联系电话">
                            <div class="tips">请输入有效的联系方式</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 预约信息 -->
            <div class="row">
                <div class="col-half">
                    <div class="form-group">
                        <label>预约日期<span class="required">*</span></label>
                        <input type="date" name="appointmentDate" 
                               min="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>">
                        <div class="tips">只能选择今天或未来的日期</div>
                    </div>
                </div>
                <div class="col-half">
                    <div class="form-group">
                        <label>预约时间<span class="required">*</span></label>
                        <select name="appointmentTime">
                            <option value="">请选择时间段</option>
                            <option value="上午">上午（08:00-12:00）</option>
                            <option value="下午">下午（14:00-18:00）</option>
                        </select>
                        <div class="tips">选择患者就诊的时间段</div>
                    </div>
                </div>
            </div>
            
            <!-- 提交按钮 -->
            <div class="btn-container">
                <button type="submit" class="button bg-main">
                    <span class="icon-plus"></span> 确认临时加号
                </button>
                <button type="button" class="button bg-gray" onclick="window.location.href='${pageContext.request.contextPath}/doctor/appointments.do'">
                    <span class="icon-arrow-left"></span> 返回预约列表
                </button>
            </div>
        </form>
    </div>
</div>

<script>
$(document).ready(function() {
    // 表单验证
    $('form').submit(function(e) {
        var useExistingPatient = $('input[name="useExistingPatient"]:checked').val();
        var appointmentDate = $('input[name="appointmentDate"]').val();
        var appointmentTime = $('select[name="appointmentTime"]').val();
        
        if (!appointmentDate) {
            alert('请选择预约日期');
            return false;
        }
        
        if (!appointmentTime) {
            alert('请选择预约时间');
            return false;
        }
        
        if (useExistingPatient === 'true') {
            // 验证现有患者
            var patientId = $('select[name="patientId"]').val();
            if (!patientId) {
                alert('请选择患者');
                return false;
            }
        } else {
            // 验证临时患者
            var patientName = $('input[name="patientName"]').val();
            var patientPhone = $('input[name="patientPhone"]').val();
            
            if (!patientName || !patientPhone) {
                alert('临时患者请填写完整的姓名和联系电话');
                return false;
            }
            
            // 简单的电话号码验证
            var phonePattern = /^[1][3-9]\d{9}$/;
            if (!phonePattern.test(patientPhone)) {
                alert('请输入正确的手机号码格式');
                return false;
            }
        }
        
        return true;
    });
});

// 切换患者类型
function togglePatientType() {
    var useExisting = $('input[name="useExistingPatient"]:checked').val() === 'true';
    
    if (useExisting) {
        $('#existingPatient').addClass('active');
        $('#tempPatient').removeClass('active');
        
        // 清空临时患者输入
        $('input[name="patientName"]').val('');
        $('input[name="patientPhone"]').val('');
    } else {
        $('#existingPatient').removeClass('active');
        $('#tempPatient').addClass('active');
        
        // 清空患者选择
        $('select[name="patientId"]').val('');
    }
}
</script>

</body>
</html> 