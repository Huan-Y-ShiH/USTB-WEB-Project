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
    <title>住院信息查询</title>
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>
    <script src="js/pintuer.js"></script>
    <style>
        .search-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .search-form .form-group {
            margin-bottom: 15px;
        }
        .search-form label {
            display: inline-block;
            width: 100px;
            text-align: right;
            margin-right: 10px;
        }
        .search-form input, .search-form select {
            width: 180px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        .search-buttons {
            text-align: center;
            margin-top: 20px;
        }
        .search-buttons button {
            margin: 0 10px;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a {
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid #ddd;
            text-decoration: none;
            color: #333;
        }
        .pagination a:hover {
            background: #007bff;
            color: white;
        }
        .pagination .active a {
            background: #007bff;
            color: white;
        }
        .status-badge {
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 12px;
            color: white;
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
    </style>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong><span class="icon-search"></span> 住院信息查询</strong></div>
    
    <!-- 搜索表单 -->
    <div class="search-form">
        <form method="get" action="user/hospitalizationSearch.do">
            <div class="form-group">
                <label>房间号:</label>
                <input type="text" name="roomNumber" value="${searchVo.roomNumber}" placeholder="请输入房间号">
                
                <label style="margin-left: 20px;">住院状态:</label>
                <select name="hospitalizationStatus">
                    <option value="">全部状态</option>
                    <option value="in_progress" ${searchVo.hospitalizationStatus == 'in_progress' ? 'selected' : ''}>住院中</option>
                    <option value="admitted" ${searchVo.hospitalizationStatus == 'admitted' ? 'selected' : ''}>已入院</option>
                    <option value="discharged" ${searchVo.hospitalizationStatus == 'discharged' ? 'selected' : ''}>已出院</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>支付状态:</label>
                <select name="paymentStatus">
                    <option value="">全部状态</option>
                    <option value="paid" ${searchVo.paymentStatus == 'paid' ? 'selected' : ''}>已支付</option>
                    <option value="unpaid" ${searchVo.paymentStatus == 'unpaid' ? 'selected' : ''}>未支付</option>
                    <option value="partial" ${searchVo.paymentStatus == 'partial' ? 'selected' : ''}>部分支付</option>
                </select>
                
                <label style="margin-left: 20px;">医保状态:</label>
                <select name="isInsured">
                    <option value="">全部</option>
                    <option value="1" ${searchVo.isInsured == '1' ? 'selected' : ''}>有医保</option>
                    <option value="0" ${searchVo.isInsured == '0' ? 'selected' : ''}>无医保</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>费用范围:</label>
                <input type="number" name="minCost" value="${searchVo.minCost}" placeholder="最小费用" step="0.01">
                
                <label style="margin-left: 20px;">至:</label>
                <input type="number" name="maxCost" value="${searchVo.maxCost}" placeholder="最大费用" step="0.01">
            </div>
            
            <div class="search-buttons">
                <button type="submit" class="button border-main icon-search">查询</button>
                <button type="button" class="button border-yellow" onclick="resetForm()">重置</button>
                <a href="user/hospitalization.do?action=my" class="button border-blue">返回我的住院</a>
            </div>
        </form>
    </div>
    
    <!-- 搜索结果 -->
    <div class="padding border-bottom">
        <ul class="search">
            <li>
                <span class="icon-info-circle"></span> 共找到 <strong>${total}</strong> 条住院记录
            </li>
        </ul>
    </div>
    
    <table class="table table-hover text-center">
        <tr>
            <th>住院ID</th>
            <th>房间号</th>
            <th>费用</th>
            <th>支付状态</th>
            <th>医保状态</th>
            <th>住院状态</th>
            <th>患者姓名</th>
        </tr>
        <c:forEach var="hospitalization" items="${hospitalizations}">
            <tr>
                <td>${hospitalization.hospitalizationId}</td>
                <td>${hospitalization.roomNumber}</td>
                <td>￥${hospitalization.cost}</td>
                <td>
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
                </td>
                <td>
                    <c:choose>
                        <c:when test="${hospitalization.isInsured == true}">
                            <span class="status-badge insured-yes">有医保</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge insured-no">无医保</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${hospitalization.hospitalizationStatus == 'in_progress'}">
                            <span class="status-badge status-in">住院中</span>
                        </c:when>
                        <c:when test="${hospitalization.hospitalizationStatus == 'admitted'}">
                            <span class="status-badge status-in">已入院</span>
                        </c:when>
                        <c:when test="${hospitalization.hospitalizationStatus == 'discharged'}">
                            <span class="status-badge status-out">已出院</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge">${hospitalization.hospitalizationStatus}</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${hospitalization.patient.pname}</td>
            </tr>
        </c:forEach>
    </table>
    
    <!-- 分页 -->
    <c:if test="${totalPages > 1}">
        <div class="panel-foot text-center">
            <ul class="pagination">
                <c:if test="${currentPage > 1}">
                    <li><a href="user/hospitalizationSearch.do?page=${currentPage-1}&roomNumber=${searchVo.roomNumber}&hospitalizationStatus=${searchVo.hospitalizationStatus}&paymentStatus=${searchVo.paymentStatus}&isInsured=${searchVo.isInsured}&minCost=${searchVo.minCost}&maxCost=${searchVo.maxCost}">上一页</a></li>
                </c:if>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <li class="active"><a href="#">${i}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="user/hospitalizationSearch.do?page=${i}&roomNumber=${searchVo.roomNumber}&hospitalizationStatus=${searchVo.hospitalizationStatus}&paymentStatus=${searchVo.paymentStatus}&isInsured=${searchVo.isInsured}&minCost=${searchVo.minCost}&maxCost=${searchVo.maxCost}">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <c:if test="${currentPage < totalPages}">
                    <li><a href="user/hospitalizationSearch.do?page=${currentPage+1}&roomNumber=${searchVo.roomNumber}&hospitalizationStatus=${searchVo.hospitalizationStatus}&paymentStatus=${searchVo.paymentStatus}&isInsured=${searchVo.isInsured}&minCost=${searchVo.minCost}&maxCost=${searchVo.maxCost}">下一页</a></li>
                </c:if>
            </ul>
        </div>
    </c:if>
</div>

<script>
function resetForm() {
    document.querySelector('input[name="roomNumber"]').value = '';
    document.querySelector('select[name="hospitalizationStatus"]').value = '';
    document.querySelector('select[name="paymentStatus"]').value = '';
    document.querySelector('select[name="isInsured"]').value = '';
    document.querySelector('input[name="minCost"]').value = '';
    document.querySelector('input[name="maxCost"]').value = '';
}
</script>
</body>
</html> 