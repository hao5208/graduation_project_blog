<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: 20286
  Date: 2024/3/28
  Time: 下午 3:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>后台管理-评论管理</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">

    <ul class="nav nav-pills">
        <li role="presentation"><a href="/">网站首页</a></li>
        <li role="presentation" ><a href="/addcontent.jsp">发布文章</a></li>
        <li role="presentation"><a href="/contents/getusercontents">我的文章管理</a></li>
        <li role="presentation" class="active"><a>查看评论</a></li>
        <li role="presentation"><a href="/comments/getusercomments">我的评论管理</a></li>
        <c:if test="${username!=null}">
            <div class="btn-group">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        ${username} <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li>   您好: ${username}</li>
                    <li role="separator" class="divider"></li>
                    <li><a href="/setuserpass.jsp">修改密码</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="/users/logout">退出登录</a></li>
                </ul>
            </div>
        </c:if>
    </ul>

    <table class="table table-striped table-bordered">
        <tr>
            <td>昵称</td>
            <td>邮箱</td>
            <td>评论内容</td>
            <td>时间</td>
        </tr>

        <c:forEach items="${records}" var="d">
            <tr>

                <td>${d.name}</td>
                <td>${d.mail}</td>
                <td>${d.text}</td>
                <td>
                    <fmt:formatDate value="${ d.created }"  type="both" />
                </td>
            </tr>

        </c:forEach>
        <c:if test="${records=='[]'}">
            <tr>
                <td colspan="4">暂无评论</td>
            </tr>
        </c:if>

    </table>

</div>
</body>
<script src="/js/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
</html>
