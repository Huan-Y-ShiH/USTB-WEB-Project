<%--
  Created by IntelliJ IDEA.
  User: 20821
  Date: 2025/7/16
  Time: 23:02
  To change this template use File | Settings | File Templates.
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
  <title>添加排班</title>
  <link rel="stylesheet" href="css/pintuer.css">
  <link rel="stylesheet" href="css/admin.css">
  <script src="js/jquery.js"></script>
  <script src="js/pintuer.js"></script>
  <script>
    $(document).ready(function() {
      // 一级科室变更事件
      $("select[name='departmentFirstId']").change(function() {
        var firstId = $(this).val();
        if(firstId) {
          loadSecondDepartments(firstId);
          // 重置医生和日期选择
          $("#doctorId").empty().append('<option value="">请选择医生</option>');
          $("#date").val('');
          $("#shiftTime").empty().append('<option value="">请选择时间段</option>');
        }
      });

      // 二级科室变更事件
      $("select[name='departmentSecondId']").change(function() {
        var secondId = $(this).val();
        if(secondId) {
          loadDoctors(secondId);
          // 重置日期选择
          $("#date").val('');
          $("#shiftTime").empty().append('<option value="">请选择时间段</option>');
        }
      });

      // 医生变更事件
      $("select[name='doctorId']").change(function() {
        var doctorId = $(this).val();
        if(doctorId) {
          // 清空日期和时间段
          $("#date").val('');
          $("#shiftTime").empty().append('<option value="">请选择时间段</option>');
        }
      });

      // 日期变更事件
      $("input[name='date']").change(function() {
        var doctorId = $("select[name='doctorId']").val();
        var date = $(this).val();
        if(doctorId && date) {
          loadAvailableShiftTimes(doctorId, date);
        } else {
          $("#shiftTime").empty().append('<option value="">请选择时间段</option>');
        }
      });

      // 加载二级科室的函数
      function loadSecondDepartments(firstId) {
        $.ajax({
          "url": "${pageContext.request.contextPath}/manager/getSecondDepartments.do",
          "type": "GET",
          "data": { departmentFirstId: firstId, time:Math.random() },
          "dataType": "json",
          "success": function(data) {
            var $select = $("select[name='departmentSecondId']");
            $select.empty().append('<option value="">请选择二级科室</option>');
            $.each(data, function(i, item) {
              $select.append('<option value="' + item.departmentId + '">' + item.departmentName + '</option>');
            });
          },
          error: function() {
            console.log("加载二级科室失败");
          }
        });
      }

      // 加载医生的函数
      function loadDoctors(departmentId) {
        $.ajax({
          "url": "${pageContext.request.contextPath}/manager/getDoctorsByDepartment.do",
          "type": "GET",
          "data": { departmentId: departmentId, time:Math.random() },
          "dataType": "json",
          "success": function(data) {
            var $select = $("select[name='doctorId']");
            $select.empty().append('<option value="">请选择医生</option>');
            $.each(data, function(i, item) {
              $select.append('<option value="' + item.doctorId + '">' + item.name + '</option>');
            });
          },
          error: function() {
            console.log("加载医生失败");
          }
        });
      }

      // 加载可用时间段的函数
      function loadAvailableShiftTimes(doctorId, date) {
        var $select = $("select[name='shiftTime']");
        var $errorSpan = $("#shiftTimeError");

        // 清空并显示加载状态
        $select.empty().append('<option value="">加载中...</option>');
        $errorSpan.text("").removeClass("text-danger");

        $.ajax({
          "url": "${pageContext.request.contextPath}/manager/getAvailableShiftTimes.do",
          "type": "GET",
          "data": {
            doctorId: doctorId,
            date: date,
            time: Math.random()
          },
          "dataType": "json",
          "success": function(data) {
            $select.empty().append('<option value="">请选择时间段</option>');

            if (data && data.length > 0) {
              $.each(data, function(i, item) {
                $select.append('<option value="' + item + '">' + item + '</option>');
              });
              $errorSpan.text("");
            } else {
              $select.append('<option value="" disabled>该日期无可用时间段</option>');
              $errorSpan.text("该医生在此日期已排满，请选择其他日期").addClass("text-danger");
              disableSubmitButton(); // 禁用提交按钮
            }
          },
          error: function() {
            $select.empty().append('<option value="">加载失败</option>');
            $errorSpan.text("加载时间段失败，请重试").addClass("text-danger");
            disableSubmitButton(); // 禁用提交按钮
          }
        });
      }

      // 禁用提交按钮的函数
      function disableSubmitButton() {
        $("button[type='submit']").prop("disabled", true)
                .removeClass("bg-main")
                .addClass("bg-gray")
                .text("无法提交");
      }

      // 启用提交按钮的函数
      function enableSubmitButton() {
        $("button[type='submit']").prop("disabled", false)
                .removeClass("bg-gray")
                .addClass("bg-main")
                .text("提交");
      }

      // 当用户更改选择时重新启用按钮
      $("select[name='shiftTime']").change(function() {
        if ($(this).val()) {
          enableSubmitButton();
        }
      });

      // 当用户更改日期时重新启用按钮
      $("input[name='date']").change(function() {
        enableSubmitButton();
      });
    });
  </script>
</head>
<body>
<div class="panel admin-panel margin-top">
  <div class="panel-head" id="add"><strong><span class="icon-pencil-square-o"></span>添加排班</strong></div>
  <div class="body-content">
    <form method="post" class="form-x" action="${pageContext.request.contextPath}/manager/addSchedule.do">
      <!-- 一级科室 -->
      <div class="form-group">
        <div class="label">
          <label>一级科室：</label>
        </div>
        <div class="field">
          <select name="departmentFirstId" class="input" style="width:200px;" data-validate="required:请选择一级科室">
            <option value="">请选择一级科室</option>
            <c:forEach items="${departmentsFirstList}" var="d">
              <option value="${d.departmentId}">${d.departmentName}</option>
            </c:forEach>
          </select>
        </div>
      </div>

      <!-- 二级科室 -->
      <div class="form-group">
        <div class="label">
          <label>二级科室：</label>
        </div>
        <div class="field">
          <select name="departmentSecondId" class="input" style="width:200px;" data-validate="required:请选择二级科室">
            <option value="">请选择二级科室</option>
          </select>
        </div>
      </div>

      <!-- 医生 -->
      <div class="form-group">
        <div class="label">
          <label>医生姓名：</label>
        </div>
        <div class="field">
          <select name="doctorId" id="doctorId" class="input" style="width:200px;" data-validate="required:请选择医生">
            <option value="">请选择医生</option>
          </select>
        </div>
      </div>

      <!-- 排班日期 -->
      <div class="form-group">
        <div class="label">
          <label>排班日期：</label>
        </div>
        <div class="field">
          <input type="date" id="date" class="input w50" name="date" value="" data-validate="required:请选择排班日期" />
        </div>
      </div>

      <!-- 时间段 -->
      <div class="form-group">
        <div class="label">
          <label>时间段：</label>
        </div>
        <div class="field">
          <select name="shiftTime" id="shiftTime" class="input" style="width:100px;"
                  data-validate="required:请选择时间段">
            <option value="">请选择时间段</option>
          </select>
          <span id="shiftTimeError" class="text-danger" style="margin-left:10px;"></span>
          <div class="tip">可选时间段：上午(8:00-12:00), 下午(13:30-17:30)</div>
        </div>
      </div>

      <!-- 是否可用 -->
      <div class="form-group">
        <div class="label">
          <label>是否可用：</label>
        </div>
        <div class="field">
          <select name="isAvailable" class="input" style="width:100px;" data-validate="required:请选择状态">
            <option value="true">是</option>
            <option value="false">否</option>
          </select>
        </div>
      </div>

      <!-- 总人数 -->
      <div class="form-group">
        <div class="label">
          <label>总人数：</label>
        </div>
        <div class="field">
          <input type="number" class="input w50" name="sumCount" value="30" min="1" data-validate="required:请输入总人数,number:必须是数字" />
        </div>
      </div>

      <!-- 备注 -->
      <div class="form-group">
        <div class="label">
          <label>备注：</label>
        </div>
        <div class="field">
          <textarea class="input" name="remarks" style="height:80px;"></textarea>
        </div>
      </div>

      <div class="form-group">
        <div class="label">
          <label></label>
        </div>
        <div class="field">
          <button class="button bg-main icon-check-square-o" type="submit">提交</button>
        </div>
      </div>
    </form>
  </div>
</div>
</body>
</html>
