<%--
  患者列表查询页面
  Created by IntelliJ IDEA.
  User: 王知涵
  Date: 2025/1/10
  Time: 20:30
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
    <title>患者管理</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head">
        <strong class="icon-users"> 患者管理 - ${queryTypeText}</strong>
    </div>
    
    <!-- 显示错误消息 -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
            <span class="close" onclick="this.parentNode.style.display='none';">&times;</span>
            ${errorMessage}
        </div>
    </c:if>
    
    <!-- 查询选项卡 -->
    <div class="padding border-bottom">
        <div class="form-inline">
            <div class="form-group">
                <a href="${pageContext.request.contextPath}/doctor/patients.do?action=all" 
                   class="button ${action == 'all' ? 'bg-main' : 'bg-gray'}">所有患者</a>
            </div>
        </div>
    </div>
    
    <!-- 搜索条件 -->
    <div class="padding border-bottom" style="background-color: #f8f9fa;">
        <h4 style="margin-bottom: 20px; color: #2c3e50;">
            <i class="icon-search"></i> <strong>患者搜索</strong>
        </h4>
        
        <form method="get" action="${pageContext.request.contextPath}/doctor/patients.do" style="max-width: 1000px;">
            <input type="hidden" name="action" value="${action}" />
            
            <div class="search-grid" style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px 30px; margin-bottom: 20px;">
            <div class="form-group">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <label style="font-weight: bold; color: #34495e; width: 80px; flex-shrink: 0;">患者姓名：</label>
                        <input type="text" name="patientName" class="input" value="${searchVo.patientName}" 
                               placeholder="请输入患者姓名" 
                               style="flex: 1; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px;" />
                    </div>
            </div>
            
            <div class="form-group">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <label style="font-weight: bold; color: #34495e; width: 80px; flex-shrink: 0;">身份证号：</label>
                        <input type="text" name="idCardNumber" class="input" value="${searchVo.idCardNumber}" 
                               placeholder="请输入身份证号" 
                               style="flex: 1; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px;" />
                    </div>
            </div>
            
            <div class="form-group">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <label style="font-weight: bold; color: #34495e; width: 80px; flex-shrink: 0;">手机号：</label>
                        <input type="text" name="phone" class="input" value="${searchVo.phone}" 
                               placeholder="请输入手机号" 
                               style="flex: 1; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px;" />
                    </div>
            </div>
            
            <div class="form-group">
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <label style="font-weight: bold; color: #34495e; width: 80px; flex-shrink: 0;">余额范围：</label>
                        <div style="flex: 1; display: flex; align-items: center; gap: 8px;">
                            <input type="number" name="minBalance" class="input" value="${searchVo.minBalance}" 
                                   placeholder="最小余额" step="0.01" 
                                   style="flex: 1; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px;" />
                            <span style="color: #6c757d; font-weight: bold;">-</span>
                            <input type="number" name="maxBalance" class="input" value="${searchVo.maxBalance}" 
                                   placeholder="最大余额" step="0.01" 
                                   style="flex: 1; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px;" />
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="form-actions" style="text-align: center; padding-top: 15px; border-top: 1px solid #dee2e6;">
                <button type="submit" class="button bg-main icon-search" 
                        style="padding: 10px 20px; font-size: 14px; border-radius: 4px; margin-right: 10px;">
                    查询患者
                </button>
                <button type="button" class="button bg-gray icon-refresh" onclick="clearSearch()" 
                        style="padding: 10px 20px; font-size: 14px; border-radius: 4px;">
                    重置条件
                </button>
            </div>
        </form>
    </div>
    
    <!-- 统计信息 -->
    <div class="padding" style="background-color: #fff;">
        <div class="alert alert-info" style="border: 1px solid #d1ecf1; background-color: #d1ecf1; border-radius: 4px; margin-bottom: 20px;">
            <i class="icon-bar-chart"></i>
            <strong style="color: #0c5460;">查询结果：</strong>
            共找到 <strong style="color: #dc3545; font-size: 16px;">${pageInfo.total}</strong> 名患者，
            当前第 <strong style="color: #495057;">${pageInfo.pageNum}</strong> 页，
            共 <strong style="color: #495057;">${pageInfo.pages}</strong> 页
            <span style="color: #6c757d; margin-left: 20px;">
                <i class="icon-info-circle"></i> 显示类型：${queryTypeText}
            </span>
        </div>
    </div>
    
    <!-- 患者列表 -->
    <div style="background-color: #fff; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
        <table class="table table-hover" style="margin-bottom: 0; border-radius: 4px; overflow: hidden;">
            <thead style="background-color: #f8f9fa;">
            <tr>
                    <th width="8%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">患者ID</th>
                    <th width="12%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">姓名</th>
                    <th width="15%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">身份证号</th>
                    <th width="12%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">联系电话</th>
                    <th width="15%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">邮箱</th>
                    <th width="10%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">账户余额</th>
                    <th width="10%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">头像</th>
                    <th width="18%" style="padding: 15px 12px; font-weight: bold; color: #495057; border-bottom: 2px solid #dee2e6;">操作</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty pageInfo.list}">
                    <tr>
                        <td colspan="8" class="text-center text-gray">
                            <i class="icon-info-circle"></i> 暂无患者数据
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${pageInfo.list}" var="patient">
                        <tr style="transition: background-color 0.2s;">
                            <td style="padding: 12px; vertical-align: middle; color: #495057; font-weight: bold;">${patient.patientId}</td>
                            <td style="padding: 12px; vertical-align: middle;">
                                <strong style="color: #2c3e50; font-size: 15px;">${patient.pname}</strong>
                            </td>
                            <td style="padding: 12px; vertical-align: middle; color: #495057; font-family: monospace;">
                                <c:choose>
                                    <c:when test="${not empty patient.idCardNumber}">
                                        ${patient.idCardNumber}
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #95a5a6; font-style: italic;">未填写</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="padding: 12px; vertical-align: middle; color: #495057;">
                                <c:choose>
                                    <c:when test="${not empty patient.phone}">
                                        <span style="font-family: monospace;">${patient.phone}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #95a5a6; font-style: italic;">未填写</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="padding: 12px; vertical-align: middle; color: #495057; max-width: 200px; word-wrap: break-word;">
                                <c:choose>
                                    <c:when test="${not empty patient.email}">
                                        ${patient.email}
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #95a5a6; font-style: italic;">未填写</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="padding: 12px; vertical-align: middle; text-align: center;">
                                <c:choose>
                                    <c:when test="${patient.balance != null}">
                                        <span style="color: #27ae60; font-weight: bold; font-size: 14px;">￥${patient.balance}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #95a5a6; font-weight: bold;">￥0.00</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="padding: 12px; vertical-align: middle; text-align: center;">
                                <c:choose>
                                    <c:when test="${not empty patient.avatar}">
                                        <img src="${patient.avatar}" 
                                             style="width: 40px; height: 40px; border-radius: 50%; border: 2px solid #dee2e6; object-fit: cover;" 
                                             alt="头像" />
                                    </c:when>
                                    <c:otherwise>
                                        <div style="width: 40px; height: 40px; border-radius: 50%; background-color: #f8f9fa; border: 2px solid #dee2e6; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
                                            <i class="icon-user" style="font-size: 18px; color: #95a5a6;"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="padding: 12px; vertical-align: middle; text-align: center;">
                                <div style="display: flex; gap: 5px; justify-content: center; flex-wrap: wrap;">
                                <a href="${pageContext.request.contextPath}/doctor/patientDetail.do?patientId=${patient.patientId}" 
                                       class="button button-little bg-blue icon-eye" 
                                       style="padding: 6px 10px; border-radius: 3px; font-size: 12px; white-space: nowrap;"> 详情</a>
                                                                    <a href="javascript:void(0);" onclick="addHospitalization(${patient.patientId})" 
                                       class="button button-little bg-green icon-plus" 
                                       style="padding: 6px 10px; border-radius: 3px; font-size: 12px; white-space: nowrap;"> 住院</a>
                                    <a href="${pageContext.request.contextPath}/doctor/patientConsultations.do?patientId=${patient.patientId}" 
                                       class="button button-little bg-yellow icon-list" 
                                       style="padding: 6px 10px; border-radius: 3px; font-size: 12px; white-space: nowrap;"> 病历</a>
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
                    <a href="${pageContext.request.contextPath}/doctor/patients.do?action=${action}&pageNum=1&patientName=${searchVo.patientName}&idCardNumber=${searchVo.idCardNumber}&phone=${searchVo.phone}&minBalance=${searchVo.minBalance}&maxBalance=${searchVo.maxBalance}" 
                       class="button border">首页</a>
                    <a href="${pageContext.request.contextPath}/doctor/patients.do?action=${action}&pageNum=${pageInfo.prePage}&patientName=${searchVo.patientName}&idCardNumber=${searchVo.idCardNumber}&phone=${searchVo.phone}&minBalance=${searchVo.minBalance}&maxBalance=${searchVo.maxBalance}" 
                       class="button border">上一页</a>
                </c:if>
                
                <c:forEach items="${pageInfo.navigatepageNums}" var="nav">
                    <c:choose>
                        <c:when test="${nav == pageInfo.pageNum}">
                            <span class="button bg-main">${nav}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/doctor/patients.do?action=${action}&pageNum=${nav}&patientName=${searchVo.patientName}&idCardNumber=${searchVo.idCardNumber}&phone=${searchVo.phone}&minBalance=${searchVo.minBalance}&maxBalance=${searchVo.maxBalance}" 
                               class="button border">${nav}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <c:if test="${pageInfo.hasNextPage}">
                    <a href="${pageContext.request.contextPath}/doctor/patients.do?action=${action}&pageNum=${pageInfo.nextPage}&patientName=${searchVo.patientName}&idCardNumber=${searchVo.idCardNumber}&phone=${searchVo.phone}&minBalance=${searchVo.minBalance}&maxBalance=${searchVo.maxBalance}" 
                       class="button border">下一页</a>
                    <a href="${pageContext.request.contextPath}/doctor/patients.do?action=${action}&pageNum=${pageInfo.pages}&patientName=${searchVo.patientName}&idCardNumber=${searchVo.idCardNumber}&phone=${searchVo.phone}&minBalance=${searchVo.minBalance}&maxBalance=${searchVo.maxBalance}" 
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
function clearSearch() {
    window.location.href = "${pageContext.request.contextPath}/doctor/patients.do?action=${action}";
}

function addHospitalization(patientId) {
    // 跳转到住院管理页面
    window.location.href = "${pageContext.request.contextPath}/doctor/patientHospitalizations.do?patientId=" + patientId;
}
</script>
</body>
</html> 