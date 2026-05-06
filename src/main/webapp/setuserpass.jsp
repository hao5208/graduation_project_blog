<%--
  Created by IntelliJ IDEA.
  User: 20286
  Date: 2024/3/26
  Time: 下午 5:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改密码</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <h2 class="text-center">修改密码</h2>
            <form id="changePasswordForm">
                <div class="form-group">
                    <label for="newPassword">新密码:</label>
                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">确认新密码:</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">确认修改</button>
            </form>
            <div id="message" class="text-center" style="margin-top: 20px;"></div>
        </div>
    </div>
</div>

<script src="/js/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function() {
        $("#changePasswordForm").submit(function(event) {
            event.preventDefault(); // 阻止表单默认提交行为

            var newPassword = $("#newPassword").val();
            var confirmPassword = $("#confirmPassword").val();

            if (newPassword !== confirmPassword) {
                $("#message").html('<div class="alert alert-danger">新密码和确认密码不匹配</div>');
                return;
            }

            // 构造要发送的 JSON 数据
            var dataToSend = {
                uid:${userid},
                password: newPassword
            };

            // 使用 jQuery 的 $.ajax 方法发送 POST 请求
            $.ajax({
                url: '/users/updatepass',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(dataToSend),
                success: function(response) {
                    // 处理成功响应
                    if (response === 'success') {
                      alert("修改成功，请重新登录")
                        location.href="/login.jsp"
                    } else {
                        $("#message").html('<div class="alert alert-danger">密码修改失败：未知错误</div>');
                    }
                },
                error: function(xhr, status, error) {
                    // 处理错误响应
                    $("#message").html('<div class="alert alert-danger">密码修改失败：' + error + '</div>');
                }
            });
        });
    });
</script>

</body>
</html>

