<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>住院信息详情</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <style>
        .detail-container {
            max-width: 800px;
            margin: 20px auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .detail-header {
            background: #007bff;
            color: white;
            padding: 20px;
            border-radius: 8px 8px 0 0;
            text-align: center;
        }
        .detail-content {
            padding: 30px;
        }
        .detail-row {
            display: flex;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }
        .detail-label {
            width: 120px;
            font-weight: bold;
            color: #333;
        }
        .detail-value {
            flex: 1;
            color: #666;
        }
        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 14px;
            color: white;
            display: inline-block;
        }
        .status-reserved { background: #17a2b8; }
        .status-in { background: #28a745; }
        .status-out { background: #6c757d; }
        .status-cancelled { background: #dc3545; }
        .payment-paid { background: #28a745; }
        .payment-unpaid { background: #ffc107; color: #212529; }
        .payment-partial { background: #fd7e14; }
        .insured-yes { background: #007bff; }
        .insured-no { background: #6c757d; }
        .action-buttons {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        .action-buttons a {
            margin: 0 10px;
        }
        .cost-info {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
        }
        .cost-amount {
            font-size: 24px;
            color: #dc3545;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="detail-container">
    <div class="detail-header">
        <h2><span class="icon-bed"></span> 住院信息详情</h2>
    </div>
    
    <div class="detail-content">
        <div class="detail-row">
            <div class="detail-label">住院编号:</div>
            <div class="detail-value">${hospitalization.hospitalizationId}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">房间号:</div>
            <div class="detail-value">${hospitalization.roomNumber}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">住院状态:</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${hospitalization.hospitalizationStatus == '已预约'}">
                        <span class="status-badge status-reserved">已预约</span>
                    </c:when>
                    <c:when test="${hospitalization.hospitalizationStatus == '进行中'}">
                        <span class="status-badge status-in">住院中</span>
                    </c:when>
                    <c:when test="${hospitalization.hospitalizationStatus == '已入院'}">
                        <span class="status-badge status-in">已入院</span>
                    </c:when>
                    <c:when test="${hospitalization.hospitalizationStatus == '已出院'}">
                        <span class="status-badge status-out">已出院</span>
                    </c:when>
                    <c:when test="${hospitalization.hospitalizationStatus == '已取消'}">
                        <span class="status-badge status-cancelled">已取消</span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-badge">${hospitalization.hospitalizationStatus}</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">费用信息:</div>
            <div class="detail-value">
                <div class="cost-info">
                    <div class="cost-amount">￥${hospitalization.cost}</div>
                    <div style="margin-top: 10px;">
                        <c:choose>
                            <c:when test="${hospitalization.paymentStatus == 'paid'}">
                                <span class="status-badge payment-paid">已支付</span>
                            </c:when>
                            <c:when test="${hospitalization.paymentStatus == 'unpaid'}">
                                <span class="status-badge payment-unpaid">未支付</span>
                            </c:when>
                            <c:when test="${hospitalization.paymentStatus == 'partial'}">
                                <span class="status-badge payment-partial">部分支付</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge">${hospitalization.paymentStatus}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">医保状态:</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${hospitalization.isInsured == true}">
                        <span class="status-badge insured-yes">有医保</span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-badge insured-no">无医保</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">患者姓名:</div>
            <div class="detail-value">${hospitalization.patient.pname}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">联系电话:</div>
            <div class="detail-value">${hospitalization.patient.phone}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">身份证号:</div>
            <div class="detail-value">${hospitalization.patient.idCardNumber}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">性别:</div>
            <div class="detail-value">${hospitalization.patient.gender}</div>
        </div>
        
        <div class="detail-row">
            <div class="detail-label">年龄:</div>
            <div class="detail-value">${hospitalization.patient.age}岁</div>
        </div>
        
        <div class="action-buttons">
            <c:if test="${hospitalization.hospitalizationStatus == '已预约' || hospitalization.hospitalizationStatus == '进行中'}">
                <a class="button border-red" 
                   href="javascript:if(confirm('确定要取消住院预约吗？')) location.href='user/hospitalization.do?action=cancel&hospitalizationId=${hospitalization.hospitalizationId}'">
                    取消预约
                </a>
            </c:if>
            <a class="button border-blue" href="user/hospitalization.do?action=my">返回住院列表</a>
            <a class="button border-green" href="user/hospitalizationSearch.do">高级查询</a>
        </div>
    </div>
</div>
</body>
</html> 