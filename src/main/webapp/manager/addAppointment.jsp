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
    <title>添加预约</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <style>
        .appointment-form-table {
            width: 100%;
            margin: 20px 0;
        }
        
        .appointment-form-table td {
            padding: 10px;
            vertical-align: middle;
        }
        
        .label-cell {
            width: 150px;
            text-align: right;
            font-weight: bold;
            background-color: #f5f5f5;
        }
        
        .input-cell {
            width: auto;
            padding-left: 20px;
        }
        
        .input-cell input, .input-cell select, .input-cell textarea {
            width: 300px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .input-cell textarea {
            width: 400px;
            height: 80px;
            resize: vertical;
        }
        
        .required {
            color: red;
        }
        
        .tips {
            color: #999;
            font-size: 12px;
            margin-top: 5px;
        }
        
        .form-actions {
            text-align: center;
            padding: 20px;
            border-top: 1px solid #ddd;
            margin-top: 20px;
        }
        
        .error-message {
            background-color: #f2dede;
            border: 1px solid #ebccd1;
            color: #a94442;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        
        .emergency-notice {
            background-color: #fcf8e3;
            border: 1px solid #faebcc;
            border-radius: 4px;
            padding: 15px;
            margin-bottom: 20px;
            color: #8a6d3b;
        }
        
        .emergency-notice strong {
            color: #d63384;
        }
        
        .checkbox-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .checkbox-container input[type="checkbox"] {
            width: auto;
            margin: 0;
        }
    </style>
</head>
<body>
<div class="panel admin-panel margin-top">
    <div class="panel-head" id="add"><strong><span class="icon-pencil-square-o"></span>添加预约</strong></div>
    <div class="body-content">
        
        <!-- 临时加号功能说明 -->
        <div class="emergency-notice">
            <strong>临时加号功能说明：</strong>
            <br>普通预约：系统会检查医生该时间段的预约数量，超过限制时无法预约
            <br>临时加号：勾选"临时加号"可突破预约数量限制，适用于紧急情况
        </div>
        
        <!-- 错误信息显示 -->
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                ${errorMessage}
            </div>
        </c:if>
        
        <form method="post" action="${pageContext.request.contextPath}/manager/addAppointment.do">
            <table class="appointment-form-table">
                
                <tr>
                    <td class="label-cell">患者<span class="required">*</span>：</td>
                    <td class="input-cell">
                        <select name="patientId" data-validate="required:请选择患者">
                            <option value="">请选择患者</option>
                            <c:forEach items="${patientsList}" var="patient">
                                <option value="${patient.patientId}">${patient.pname} - ${patient.idCardNumber} - ${patient.phone}</option>
                            </c:forEach>
                        </select>
                        <div class="tips">请选择要预约的患者（必选）</div>
                    </td>
                </tr>
                
                <tr>
                    <td class="label-cell">医生<span class="required">*</span>：</td>
                    <td class="input-cell">
                        <select name="doctorId" data-validate="required:请选择医生">
                            <option value="">请选择医生</option>
                            <c:forEach items="${doctorsList}" var="doctor">
                                <option value="${doctor.doctorId}">${doctor.name} - ${doctor.departments.departmentName} - ${doctor.titles.titleName}</option>
                            </c:forEach>
                        </select>
                        <div class="tips">请选择预约的医生（必选）</div>
                    </td>
                </tr>
                
                <tr>
                    <td class="label-cell">预约日期<span class="required">*</span>：</td>
                    <td class="input-cell">
                        <input type="date" name="appointmentDate" value="" data-validate="required:请选择预约日期" min="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>" />
                        <div class="tips">请选择预约日期（不能选择过去的日期）</div>
                    </td>
                </tr>
                
                <tr>
                    <td class="label-cell">预约时间<span class="required">*</span>：</td>
                    <td class="input-cell">
                        <select name="appointmentTime" data-validate="required:请选择预约时间">
                            <option value="">请选择时间段</option>
                            <option value="上午">上午（08:00-12:00）</option>
                            <option value="下午">下午（14:00-18:00）</option>
                        </select>
                        <div class="tips">请选择预约的时间段（必选）</div>
                    </td>
                </tr>
                
                <tr>
                    <td class="label-cell">临时加号：</td>
                    <td class="input-cell">
                        <div class="checkbox-container">
                            <input type="checkbox" name="isEmergency" value="1" id="emergencyCheck" />
                            <label for="emergencyCheck">临时加号（可突破预约数量限制）</label>
                        </div>
                        <div class="tips">勾选此项可在预约满时强制添加预约，适用于紧急情况</div>
                    </td>
                </tr>
                
            </table>
            
            <div class="form-actions">
                <input type="submit" class="button bg-main" value="确认添加预约" />
                <input type="button" class="button bg-gray" value="返回列表" onclick="window.location.href='${pageContext.request.contextPath}/manager/appointments.do'" />
            </div>
        </form>
    </div>
</div>

<script>
$(document).ready(function() {
    // 表单验证
    $('form').submit(function(e) {
        var patientId = $('select[name="patientId"]').val();
        var doctorId = $('select[name="doctorId"]').val();
        var appointmentDate = $('input[name="appointmentDate"]').val();
        var appointmentTime = $('select[name="appointmentTime"]').val();
        
        if (!patientId) {
            alert('请选择患者');
            return false;
        }
        
        if (!doctorId) {
            alert('请选择医生');
            return false;
        }
        
        if (!appointmentDate) {
            alert('请选择预约日期');
            return false;
        }
        
        if (!appointmentTime) {
            alert('请选择预约时间');
            return false;
        }
        
        // 检查日期是否为今天或未来
        var selectedDate = new Date(appointmentDate);
        var today = new Date();
        today.setHours(0, 0, 0, 0);
        
        if (selectedDate < today) {
            alert('预约日期不能选择过去的日期');
            return false;
        }
        
        return true;
    });
    
    // 科室变化时过滤医生
    function filterDoctorsByDepartment() {
        // 这里可以添加根据科室过滤医生的逻辑
        // 暂时保持简单，显示所有医生
    }
});
</script>

</body>
</html> 