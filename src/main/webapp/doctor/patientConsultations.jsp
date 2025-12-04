<%--
  患者咨询记录管理页面
  Created by IntelliJ IDEA.
  User: 王知涵
  Date: 2025/1/10
  Time: 23:40
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>患者病历管理</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong class="icon-file-text"> 患者病历管理</strong>
        <a href="${pageContext.request.contextPath}/doctor/patients.do" class="button button-little bg-gray pull-right icon-arrow-left"> 返回患者列表</a>
    </div>
    
    <!-- 显示消息 -->
    <c:if test="${not empty param.message}">
        <div class="alert alert-success">
            <span class="close" onclick="this.parentNode.style.display='none';">&times;</span>
            ${param.message}
        </div>
    </c:if>
    
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
            <span class="close" onclick="this.parentNode.style.display='none';">&times;</span>
            ${errorMessage}
        </div>
    </c:if>
    
    <!-- 患者基本信息 -->
    <div class="padding border-bottom" style="background-color: #fff;">
        <div class="alert alert-info" style="border-left: 4px solid #3498db; background-color: #f8f9fa; border-radius: 4px;">
            <h4 style="margin-bottom: 15px; color: #2c3e50;">
                <i class="icon-user"></i> <strong>患者基本信息</strong>
            </h4>
            
            <div class="patient-info-grid" style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px 30px; max-width: 800px;">
                <div class="info-item">
                    <span class="info-label" style="font-weight: bold; color: #34495e; display: inline-block; width: 80px;">姓名：</span>
                    <span class="info-value" style="color: #2c3e50;">${patient.pname}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label" style="font-weight: bold; color: #34495e; display: inline-block; width: 80px;">身份证：</span>
                    <span class="info-value" style="color: #2c3e50;">
                        <c:choose>
                            <c:when test="${not empty patient.idCardNumber}">
                                ${patient.idCardNumber}
                            </c:when>
                            <c:otherwise>
                                <span style="color: #95a5a6; font-style: italic;">未填写</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                
                <div class="info-item">
                    <span class="info-label" style="font-weight: bold; color: #34495e; display: inline-block; width: 80px;">联系电话：</span>
                    <span class="info-value" style="color: #2c3e50;">
                        <c:choose>
                            <c:when test="${not empty patient.phone}">
                                ${patient.phone}
                            </c:when>
                            <c:otherwise>
                                <span style="color: #95a5a6; font-style: italic;">未填写</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                
                <div class="info-item">
                    <span class="info-label" style="font-weight: bold; color: #34495e; display: inline-block; width: 80px;">账户余额：</span>
                    <span class="info-value" style="color: #27ae60; font-weight: bold;">
                        <c:choose>
                            <c:when test="${patient.balance != null}">
                                ￥${patient.balance}
                            </c:when>
                            <c:otherwise>￥0.00</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 添加咨询记录表单 -->
    <div class="padding border-bottom" style="background-color: #f8f9fa;">
        <h4 style="margin-bottom: 20px; color: #2c3e50;">
            <i class="icon-plus-circle"></i> <strong>添加咨询记录</strong>
        </h4>
        
        <form method="post" action="${pageContext.request.contextPath}/doctor/patientConsultations.do" style="max-width: 800px;">
            <input type="hidden" name="action" value="add" />
            <input type="hidden" name="patientId" value="${patient.patientId}" />
            
            <div class="form-group" style="margin-bottom: 20px;">
                <div class="form-row">
                    <div class="form-label-container" style="width: 120px; display: inline-block; vertical-align: top; padding-top: 8px;">
                        <label style="font-weight: bold; color: #34495e;">医疗建议：</label>
                    </div>
                    <div class="form-input-container" style="display: inline-block; width: calc(100% - 140px); vertical-align: top;">
                        <textarea name="medicalAdviceCase" 
                                  class="input" 
                                  rows="4" 
                                  style="width: 100%; min-height: 100px; padding: 10px; border: 1px solid #ddd; border-radius: 4px; resize: vertical; font-family: inherit;" 
                                  placeholder="请详细描述医疗建议、诊断意见、用药指导或其他医疗相关内容..." 
                                  required></textarea>
                    </div>
                </div>
            </div>
            
            <div class="form-group" style="margin-bottom: 15px;">
                <div class="form-row">
                    <div style="width: 120px; display: inline-block;"></div>
                    <div style="display: inline-block; width: calc(100% - 140px);">
                        <div class="alert alert-info" style="margin: 0; padding: 8px 12px; font-size: 12px; background-color: #e3f2fd; border: 1px solid #bbdefb; border-radius: 4px;">
                            <i class="icon-info-circle"></i>
                            <strong>提示：</strong>is_hospital_registered（医院注册状态）和 is_hospitalized（住院状态）将自动设置为默认值，如需修改请联系系统管理员
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="form-group" style="margin-top: 25px;">
                <div class="form-row">
                    <div style="width: 120px; display: inline-block;"></div>
                    <div style="display: inline-block; width: calc(100% - 140px);">
                        <button type="submit" 
                                class="button bg-main icon-plus" 
                                style="padding: 10px 20px; font-size: 14px; border-radius: 4px;">
                            添加咨询记录
                        </button>
                        <button type="reset" 
                                class="button bg-gray icon-refresh" 
                                style="padding: 10px 20px; font-size: 14px; border-radius: 4px; margin-left: 10px;">
                            清空内容
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <!-- 统计信息 -->
    <div class="padding" style="background-color: #fff;">
        <div class="alert alert-info" style="border: 1px solid #d1ecf1; background-color: #d1ecf1; border-radius: 4px; margin-bottom: 20px;">
            <i class="icon-bar-chart"></i>
            <strong style="color: #0c5460;">咨询记录统计：</strong>
            共有 <strong style="color: #dc3545; font-size: 16px;">${pageInfo.total}</strong> 条咨询记录，
            当前第 <strong style="color: #495057;">${pageInfo.pageNum}</strong> 页，
            共 <strong style="color: #495057;">${pageInfo.pages}</strong> 页
        </div>
    </div>
    
    <!-- 咨询记录列表 -->
    <div style="background-color: #fff; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
        <table class="table table-hover" style="margin-bottom: 0; border-radius: 4px; overflow: hidden;">
            <thead style="background-color: #f8f9fa;">
                <tr>
                    <th width="8%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">咨询ID</th>
                    <th width="12%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">医生姓名</th>
                    <th width="15%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">咨询时间</th>
                    <th width="10%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">是否住院</th>
                    <th width="35%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">医疗建议</th>
                    <th width="10%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">操作</th>
                </tr>
            </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty pageInfo.list}">
                    <tr>
                        <td colspan="7" class="text-center text-gray">
                            <i class="icon-info-circle"></i> 该患者暂无咨询记录
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${pageInfo.list}" var="consultation">
                        <tr style="transition: background-color 0.2s;">
                            <td style="padding: 12px; vertical-align: middle; color: #495057;">${consultation.consultationId}</td>
                            <td style="padding: 12px; vertical-align: middle;">
                                <strong style="color: #2c3e50;">
                                    <c:choose>
                                        <c:when test="${not empty consultation.doctor.name}">
                                            ${consultation.doctor.name}
                                        </c:when>
                                        <c:otherwise>未知医生</c:otherwise>
                                    </c:choose>
                                </strong>
                            </td>
                            <td style="padding: 12px; vertical-align: middle; color: #495057;">
                                <fmt:formatDate value="${consultation.consultationTime}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                            <td style="padding: 12px; vertical-align: middle; text-align: center;">
                                <c:choose>
                                    <c:when test="${consultation.isHospitalized}">
                                        <span class="label bg-red" style="padding: 4px 8px; border-radius: 3px;">已住院</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="label bg-gray" style="padding: 4px 8px; border-radius: 3px;">未住院</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="padding: 12px; vertical-align: middle; max-width: 300px; word-wrap: break-word;">
                                <c:choose>
                                    <c:when test="${not empty consultation.medicalAdviceCase}">
                                        <span style="color: #495057; line-height: 1.4;">${consultation.medicalAdviceCase}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-gray" style="font-style: italic;">无</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="padding: 12px; vertical-align: middle; text-align: center;">
                                <c:if test="${consultation.doctorId == doctor.doctorId}">
                                    <a href="javascript:void(0);" onclick="deleteConsultation(${consultation.consultationId}, ${patient.patientId})" 
                                       class="button button-little bg-red icon-trash" 
                                       style="padding: 6px 12px; border-radius: 3px; font-size: 12px;"> 删除</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
        </table>
    </div>
    
    <!-- 分页导航 -->
    <c:if test="${pageInfo.pages > 1}">
        <div class="panel-foot text-center">
            <div class="pagination">
                <c:if test="${pageInfo.hasPreviousPage}">
                    <a href="${pageContext.request.contextPath}/doctor/patientConsultations.do?patientId=${patient.patientId}&page=1" 
                       class="button border">首页</a>
                    <a href="${pageContext.request.contextPath}/doctor/patientConsultations.do?patientId=${patient.patientId}&page=${pageInfo.prePage}" 
                       class="button border">上一页</a>
                </c:if>
                
                <c:forEach items="${pageInfo.navigatepageNums}" var="nav">
                    <c:choose>
                        <c:when test="${nav == pageInfo.pageNum}">
                            <span class="button bg-main">${nav}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/doctor/patientConsultations.do?patientId=${patient.patientId}&page=${nav}" 
                               class="button border">${nav}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <c:if test="${pageInfo.hasNextPage}">
                    <a href="${pageContext.request.contextPath}/doctor/patientConsultations.do?patientId=${patient.patientId}&page=${pageInfo.nextPage}" 
                       class="button border">下一页</a>
                    <a href="${pageContext.request.contextPath}/doctor/patientConsultations.do?patientId=${patient.patientId}&page=${pageInfo.pages}" 
                       class="button border">尾页</a>
                </c:if>
            </div>
            <p class="text-gray">
                第 ${pageInfo.pageNum} 页 / 共 ${pageInfo.pages} 页，总共 ${pageInfo.total} 条记录
            </p>
        </div>
    </c:if>
</div>

<script>
function deleteConsultation(consultationId, patientId) {
    if (confirm("确定要删除这条咨询记录吗？删除后无法恢复！")) {
        var form = document.createElement("form");
        form.method = "POST";
        form.action = "${pageContext.request.contextPath}/doctor/patientConsultations.do";
        
        var actionInput = document.createElement("input");
        actionInput.type = "hidden";
        actionInput.name = "action";
        actionInput.value = "delete";
        form.appendChild(actionInput);
        
        var consultationIdInput = document.createElement("input");
        consultationIdInput.type = "hidden";
        consultationIdInput.name = "consultationId";
        consultationIdInput.value = consultationId;
        form.appendChild(consultationIdInput);
        
        var patientIdInput = document.createElement("input");
        patientIdInput.type = "hidden";
        patientIdInput.name = "patientId";
        patientIdInput.value = patientId;
        form.appendChild(patientIdInput);
        
        document.body.appendChild(form);
        form.submit();
    }
}
</script>
</body>
</html> 