<%--
  患者住院记录管理页面
  Created by IntelliJ IDEA.
  User: 王知涵
  Date: 2025/1/11
  Time: 10:30
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
    <title>患者住院管理</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong class="icon-home"> 患者住院管理</strong>
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
    
    <!-- 添加住院记录表单 -->
    <div class="padding border-bottom" style="background-color: #f8f9fa;">
        <h4 style="margin-bottom: 20px; color: #2c3e50;">
            <i class="icon-plus-circle"></i> <strong>添加住院记录</strong>
        </h4>
        
        <form method="post" action="${pageContext.request.contextPath}/doctor/patientHospitalizations.do" style="max-width: 800px;">
            <input type="hidden" name="action" value="add" />
            <input type="hidden" name="patientId" value="${patient.patientId}" />
            
            <div class="form-grid" style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px 30px; margin-bottom: 20px;">
                <div class="form-group">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <label style="font-weight: bold; color: #34495e; width: 80px; flex-shrink: 0;">房间号：</label>
                        <input type="text" name="roomNumber" class="input" 
                               placeholder="请输入房间号" required
                               style="flex: 1; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px;" />
                    </div>
                </div>
                
                <div class="form-group">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <label style="font-weight: bold; color: #34495e; width: 80px; flex-shrink: 0;">费用：</label>
                        <input type="number" name="cost" class="input" step="0.01" min="0"
                               placeholder="请输入费用" 
                               style="flex: 1; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px;" />
                    </div>
                </div>
                
                <div class="form-group">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <label style="font-weight: bold; color: #34495e; width: 80px; flex-shrink: 0;">支付状态：</label>
                        <select name="paymentStatus" class="input" 
                                style="flex: 1; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px;">
                            <option value="unpaid">未支付</option>
                            <option value="paid">已支付</option>
                            <option value="partially_paid">部分支付</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <label style="font-weight: bold; color: #34495e; width: 80px; flex-shrink: 0;">是否有保险：</label>
                        <select name="isInsured" class="input" 
                                style="flex: 1; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px;">
                            <option value="false">无保险</option>
                            <option value="true">有保险</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <label style="font-weight: bold; color: #34495e; width: 80px; flex-shrink: 0;">住院状态：</label>
                        <select name="hospitalizationStatus" class="input" 
                                style="flex: 1; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px;">
                            <option value="admitted">已入院</option>
                            <option value="in_progress">进行中</option>
                            <option value="discharged">已出院</option>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="form-actions" style="text-align: center; padding-top: 15px; border-top: 1px solid #dee2e6;">
                <button type="submit" class="button bg-main icon-plus" 
                        style="padding: 10px 20px; font-size: 14px; border-radius: 4px; margin-right: 10px;">
                    添加住院记录
                </button>
                <button type="reset" class="button bg-gray icon-refresh" 
                        style="padding: 10px 20px; font-size: 14px; border-radius: 4px;">
                    清空内容
                </button>
            </div>
        </form>
    </div>
    
    <!-- 统计信息 -->
    <div class="padding" style="background-color: #fff;">
        <div class="alert alert-info" style="border: 1px solid #d1ecf1; background-color: #d1ecf1; border-radius: 4px; margin-bottom: 20px;">
            <i class="icon-bar-chart"></i>
            <strong style="color: #0c5460;">住院记录统计：</strong>
            共有 <strong style="color: #dc3545; font-size: 16px;">${pageInfo.total}</strong> 条住院记录，
            当前第 <strong style="color: #495057;">${pageInfo.pageNum}</strong> 页，
            共 <strong style="color: #495057;">${pageInfo.pages}</strong> 页
        </div>
    </div>
    
    <!-- 住院记录列表 -->
    <div style="background-color: #fff; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
        <table class="table table-hover" style="margin-bottom: 0; border-radius: 4px; overflow: hidden;">
            <thead style="background-color: #f8f9fa;">
                <tr>
                    <th width="8%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">住院ID</th>
                    <th width="12%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">房间号</th>
                    <th width="12%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">费用</th>
                    <th width="12%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">支付状态</th>
                    <th width="10%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">是否有保险</th>
                    <th width="12%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">住院状态</th>
                    <th width="34%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty pageInfo.list}">
                        <tr>
                            <td colspan="7" class="text-center text-gray" style="padding: 40px;">
                                <i class="icon-info-circle"></i> 该患者暂无住院记录
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${pageInfo.list}" var="hospitalization">
                            <tr style="transition: background-color 0.2s;">
                                <td style="padding: 12px; vertical-align: middle; color: #495057;">${hospitalization.hospitalizationId}</td>
                                <td style="padding: 12px; vertical-align: middle; color: #495057;">${hospitalization.roomNumber}</td>
                                <td style="padding: 12px; vertical-align: middle; text-align: center;">
                                    <c:choose>
                                        <c:when test="${hospitalization.cost != null}">
                                            <span style="color: #27ae60; font-weight: bold;">￥${hospitalization.cost}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #95a5a6;">未设置</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="padding: 12px; vertical-align: middle; text-align: center;">
                                    <c:choose>
                                        <c:when test="${hospitalization.paymentStatus == 'paid'}">
                                            <span class="label bg-green" style="padding: 4px 8px; border-radius: 3px;">已支付</span>
                                        </c:when>
                                        <c:when test="${hospitalization.paymentStatus == 'partially_paid'}">
                                            <span class="label bg-yellow" style="padding: 4px 8px; border-radius: 3px;">部分支付</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="label bg-red" style="padding: 4px 8px; border-radius: 3px;">未支付</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="padding: 12px; vertical-align: middle; text-align: center;">
                                    <c:choose>
                                        <c:when test="${hospitalization.isInsured}">
                                            <span class="label bg-green" style="padding: 4px 8px; border-radius: 3px;">有保险</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="label bg-gray" style="padding: 4px 8px; border-radius: 3px;">无保险</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="padding: 12px; vertical-align: middle; text-align: center;">
                                    <c:choose>
                                        <c:when test="${hospitalization.hospitalizationStatus == 'admitted'}">
                                            <span class="label bg-blue" style="padding: 4px 8px; border-radius: 3px;">已入院</span>
                                        </c:when>
                                        <c:when test="${hospitalization.hospitalizationStatus == 'in_progress'}">
                                            <span class="label bg-yellow" style="padding: 4px 8px; border-radius: 3px;">进行中</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="label bg-green" style="padding: 4px 8px; border-radius: 3px;">已出院</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="padding: 12px; vertical-align: middle; text-align: center;">
                                    <div style="display: flex; gap: 5px; justify-content: center; flex-wrap: wrap;">
                                        <button onclick="editHospitalization(${hospitalization.hospitalizationId})" 
                                                class="button button-little bg-blue icon-edit" 
                                                style="padding: 6px 10px; border-radius: 3px; font-size: 12px;">修改</button>
                                        
                                        <select onchange="updateStatus(${hospitalization.hospitalizationId}, ${patient.patientId}, this.value)" 
                                                class="button button-little bg-yellow" 
                                                style="padding: 4px 8px; border-radius: 3px; font-size: 12px; border: none;">
                                            <option value="">状态更新</option>
                                            <option value="admitted">已入院</option>
                                            <option value="in_progress">进行中</option>
                                            <option value="discharged">已出院</option>
                                        </select>
                                        
                                        <button onclick="deleteHospitalization(${hospitalization.hospitalizationId}, ${patient.patientId})" 
                                                class="button button-little bg-red icon-trash" 
                                                style="padding: 6px 10px; border-radius: 3px; font-size: 12px;">删除</button>
                                    </div>
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
                    <a href="${pageContext.request.contextPath}/doctor/patientHospitalizations.do?patientId=${patient.patientId}&page=1" 
                       class="button border">首页</a>
                    <a href="${pageContext.request.contextPath}/doctor/patientHospitalizations.do?patientId=${patient.patientId}&page=${pageInfo.prePage}" 
                       class="button border">上一页</a>
                </c:if>
                
                <c:forEach items="${pageInfo.navigatepageNums}" var="nav">
                    <c:choose>
                        <c:when test="${nav == pageInfo.pageNum}">
                            <span class="button bg-main">${nav}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/doctor/patientHospitalizations.do?patientId=${patient.patientId}&page=${nav}" 
                               class="button border">${nav}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <c:if test="${pageInfo.hasNextPage}">
                    <a href="${pageContext.request.contextPath}/doctor/patientHospitalizations.do?patientId=${patient.patientId}&page=${pageInfo.nextPage}" 
                       class="button border">下一页</a>
                    <a href="${pageContext.request.contextPath}/doctor/patientHospitalizations.do?patientId=${patient.patientId}&page=${pageInfo.pages}" 
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
function editHospitalization(hospitalizationId) {
    alert("修改功能开发中... 住院ID: " + hospitalizationId);
    // TODO: 跳转到修改页面或显示修改表单
}

function updateStatus(hospitalizationId, patientId, newStatus) {
    if (newStatus && confirm("确定要更新住院状态为'" + newStatus + "'吗？\n此操作将同步更新患者的咨询记录中的住院状态。")) {
        var form = document.createElement("form");
        form.method = "POST";
        form.action = "${pageContext.request.contextPath}/doctor/patientHospitalizations.do";
        
        var actionInput = document.createElement("input");
        actionInput.type = "hidden";
        actionInput.name = "action";
        actionInput.value = "updateStatus";
        form.appendChild(actionInput);
        
        var hospitalizationIdInput = document.createElement("input");
        hospitalizationIdInput.type = "hidden";
        hospitalizationIdInput.name = "hospitalizationId";
        hospitalizationIdInput.value = hospitalizationId;
        form.appendChild(hospitalizationIdInput);
        
        var patientIdInput = document.createElement("input");
        patientIdInput.type = "hidden";
        patientIdInput.name = "patientId";
        patientIdInput.value = patientId;
        form.appendChild(patientIdInput);
        
        var statusInput = document.createElement("input");
        statusInput.type = "hidden";
        statusInput.name = "newStatus";
        statusInput.value = newStatus;
        form.appendChild(statusInput);
        
        document.body.appendChild(form);
        form.submit();
    }
}

function deleteHospitalization(hospitalizationId, patientId) {
    if (confirm("确定要删除这条住院记录吗？删除后无法恢复！")) {
        var form = document.createElement("form");
        form.method = "POST";
        form.action = "${pageContext.request.contextPath}/doctor/patientHospitalizations.do";
        
        var actionInput = document.createElement("input");
        actionInput.type = "hidden";
        actionInput.name = "action";
        actionInput.value = "delete";
        form.appendChild(actionInput);
        
        var hospitalizationIdInput = document.createElement("input");
        hospitalizationIdInput.type = "hidden";
        hospitalizationIdInput.name = "hospitalizationId";
        hospitalizationIdInput.value = hospitalizationId;
        form.appendChild(hospitalizationIdInput);
        
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