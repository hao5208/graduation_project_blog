<%--
  Created by IntelliJ IDEA.
  User: 20286
  Date: 2024/3/23
  Time: 下午 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>后台管理-首页</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">

    <ul class="nav nav-pills">
        <li role="presentation"><a href="/">网站首页</a></li>
        <li role="presentation" class="active"><a href="/adminIndex.jsp">后台首页</a></li>
        <li role="presentation"><a href="/contents/getcontents">文章管理</a></li>
        <li role="presentation"><a href="/types/gettypes">分类管理</a></li>
        <li role="presentation"><a href="/comments/getcomments">评论管理</a></li>
        <li role="presentation"><a href="/users/getusers">用户管理</a></li>
        <li role="presentation"><a href="/files/getfiles">文件管理</a></li>
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
    <h2 class="page-header">数据统计</h2>

    <div class="row">
        <div class="col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">文章数量</h3>
                </div>
                <div class="panel-body">
                    <h2 id="concount"></h2>
                    <h2 id="concount2"></h2>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h3 class="panel-title">评论数量</h3>
                </div>
                <div class="panel-body">
                    <h2 id="comcount"></h2>
                    <h2 id="comcount2"></h2>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title">访问量</h3>
                </div>
                <div class="panel-body">
                    <h2 id="redcount"></h2>
                    <h2 id="redcount2"></h2>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="panel panel-warning">
                <div class="panel-heading">
                    <h3 class="panel-title">用户数量</h3>
                </div>
                <div class="panel-body">
                    <h2 id="usercount"></h2>
                    <h2 id="usercount2"></h2>
                </div>
            </div>
        </div>
    </div>

</div>

</body>
<script src="/js/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script>
    // $.getJSON("/index/getcount", function (r) {
    //     $('#redcount').innerHTML = r.redcount
    //     $('#concount').innerText = r.concount
    //     $('#comcount').innerText = r.comcount
    //     $('#usercount').innerText = r.usercount
    // })
    $(document).ready(function(){
        $.get("/index/getcount", function(data){
            $("#comcount").text("总评论："+data.comcount);
            $("#comcount2").text("今日新增评论："+data.comdaycount);
            $("#usercount").text("总记录："+data.usercount);
            $("#usercount2").text("今日新增："+data.userdaycount);
            $("#concount").text("总文章数："+data.concount);
            $("#concount2").text("今日新增文章："+data.condaycount);
            $("#redcount").text("总文章访问量："+data.redcount);
             // $("#redcount2").text("今日新增："+data.reddaycount);
        });
    });
</script>
</html>
