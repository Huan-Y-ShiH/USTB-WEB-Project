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

  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
  <meta name="renderer" content="webkit">
  <title>更新医生信息</title>
  <link rel="stylesheet" href="css/pintuer.css">
  <link rel="stylesheet" href="css/admin.css">
  <script src="js/jquery.js"></script>
  <script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-pencil-square-o"></span> 更新医生信息</strong></div>
  <div class="body-content">
    <form method="post" class="form-x" action="<%=basePath%>manager/updateDoctor.do" enctype="multipart/form-data">
      <input type="hidden" name="name" value="${doctor.name}">

      <div class="form-group">
        <div class="label">
          <label>工号：</label>
        </div>
        <div class="field">
          <input type="text" class="input w50" name="jobNumber" value="${doctor.jobNumber}" readonly/>
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label>密码：</label>
        </div>
        <div class="field">
          <input type="password" class="input w50" name="passWord" value="${doctor.password}" required/>
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label>姓名：</label>
        </div>
        <div class="field">
          <input type="text" class="input w50" name="name" value="${doctor.name}" readonly/>
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label>头像：</label>
        </div>
        <div class="field">
          <img src="<%=basePath%>${doctor.avatar}" style="width: 100px; height: 100px; margin-bottom: 10px;">
          <input type="file" name="imgFile" class="input w50"/>
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label>电话：</label>
        </div>
        <div class="field">
          <input type="text" class="input w50" name="phone" value="${doctor.phone}" required/>
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label>邮箱：</label>
        </div>
        <div class="field">
          <input type="email" class="input w50" name="email" value="${doctor.email}"/>
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label>简介：</label>
        </div>
        <div class="field">
          <textarea class="input" name="introduction" style="height: 80px;">${doctor.introduction}</textarea>
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label>挂号费：</label>
        </div>
        <div class="field">
          <input type="number" class="input w50" name="registrationFee" value="${doctor.registrationFee}" step="0.01" required/>
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label>入职日期：</label>
        </div>
        <div class="field">
          <input type="date" class="input w50" name="entryDate" value="<fmt:formatDate value='${doctor.entryDate}' pattern='yyyy-MM-dd'/>" readonly/>
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label>科室：</label>
        </div>
        <div class="field">
          <select name="departmentId" class="input w50">
            <c:forEach items="${departmentList}" var="dept">
              <option value="${dept.departmentId}" ${doctor.departmentId == dept.departmentId ? 'selected' : ''}>${dept.departmentName}</option>
            </c:forEach>
          </select>
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label>职称：</label>
        </div>
        <div class="field">
          <select name="titleId" class="input w50">
            <c:forEach items="${titleList}" var="title">
              <option value="${title.id}" ${doctor.professionalTitleId == title.id ? 'selected' : ''}>${title.titleName}</option>
            </c:forEach>
          </select>
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label></label>
        </div>
        <div class="field">
          <button class="button bg-main icon-check-square-o" type="submit"> 提交</button>
        </div>
      </div>
    </form>
  </div>
</div>
</body>
</html>