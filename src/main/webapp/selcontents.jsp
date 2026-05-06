<%--
  Created by IntelliJ IDEA.
  User: 20286
  Date: 2024/3/24
  Time: 下午 12:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>搜索文章</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/blog.css" rel="stylesheet">
    <style>
        #contents img{
            max-width: 100% !important;
            height: auto !important;
        }
        #newComment li,.blog-post-title,#wenzhang11,#newContent li{
            width: 100%;
            /*background-color: #1c7cf8;*/
            overflow: hidden;
            white-space: normal;
            word-break: break-all;
        }
    </style>
</head>
<body>

<div class="blog-masthead">
    <div class="container">
        <nav class="blog-nav" style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <a class="blog-nav-item" href="/">首页</a>

                <c:if test="${username==null}">
                    <a class="blog-nav-item" href="/login.jsp">登录/注册</a>
                </c:if>
                <c:if test="${ugroup=='admin'}">
                    <a class="blog-nav-item" href="/adminIndex.jsp">后台管理</a>
                </c:if>
                <c:if test="${username!=null}">
                    您好: ${username}
                    <a class="blog-nav-item" href="/users/logout">退出</a>
                </c:if>
            </div>

            <nav class="blog-nav">
                <form style="margin: 0;" action="/contents/selcontentlike" method="get">
                    <input type="text" name="title" style="line-height: 20px;">
                    <button type="submit" style="line-height: 20px;">搜索</button>
                </form>
            </nav>
        </nav>
    </div>
</div>
<div class="container">
    <div class="blog-header">

    </div>

    <div class="row">

        <div class="col-sm-8 blog-main" id="contents">
<%--            <div class="blog-post">--%>
<%--                <h2 class="blog-post-title">${content.title}</h2>--%>
<%--                <p class="blog-post-meta"><fmt:formatDate value="${ content.created }"  type="both" />by <a href="#">${ content.users.username }</a></p>--%>
<%--                ${content.text}--%>

<%--            </div>--%>
    <c:forEach items="${contents}" var="d">
        <div class="blog-post">
            <h2 class="blog-post-title"><a href="/index/getcontent/${d.cid}">${d.title}</a></h2>
            <p class="blog-post-meta"><fmt:formatDate value="${ d.created }"  type="both" /> by <a href="/contents/getcontentByUid/${d.uid}">admin</a> | <a href="/contents/getcontentByMid/${d.type}">${d.types.name}</a></p>
            <div id='wenzhang11'>${d.text}</div>
        </div>


    </c:forEach>
    <c:if test="${contents=='[]'}">
    <div class="blog-post">
        <h2>未找到相关文章,换个条件吧！</h2>
    </div>
    </c:if>

        </div>
        <div class="col-sm-3 col-sm-offset-1 blog-sidebar">
            <div class="sidebar-module">
                <h4>最新文章</h4>
                <ol class="list-unstyled" id="newContent">

                </ol>
            </div>
            <div class="sidebar-module">
                <h4>最近回复</h4>
                <ol class="list-unstyled" id="newComment">

                </ol>
            </div>
            <div class="sidebar-module">
                <h4>分类</h4>
                <ol class="list-unstyled" id="typess">
                </ol>
            </div>
<%--            <div class="sidebar-module">--%>
<%--                <h4>友情链接</h4>--%>
<%--                <ol class="list-unstyled">--%>
<%--                    <li><a href="#">GitHub</a></li>--%>
<%--                </ol>--%>
<%--            </div>--%>
        </div>



    </div>


</div>
<footer class="blog-footer">
    © 2024 <a href="#">blog</a>.
</footer>
</body>
<script src="/js/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script>
    var curr=1;
    function loadIndex(page){
        $.getJSON("/index/getindex?curr="+page,
            function (r) {
                curr=r.curr

                //右侧最新文章
                $('#newContent').empty();
                for (var i = 0; i < r.newContent.records.length; i++) {
                    $('#newContent').append("<li> <a href='/index/getcontent/"+r.newContent.records[i].cid+"'>"+r.newContent.records[i].title+"</a></li>")

                }
                //右侧最新回复
                $('#newComment').empty();
                for (var i = 0; i < r.newComment.records.length; i++) {
                    $('#newComment').append("<li><a href='/index/getcontent/"+r.newComment.records[i].cid+"'>"+r.newComment.records[i].name+"</a>:"+r.newComment.records[i].text+"</li>")

                }
                //翻页
                // if (r.pages==r.curr){
                //     $('#contents').append("<nav><ul class='pager'><li><a onclick='shang()'>上一页</a></li></ul></nav>")
                // }else if (r.curr==1){
                //     $('#contents').append("<nav><ul class='pager'><li><a onclick='xia()'>下一页</a></li></ul></nav>")
                // }else {
                //     $('#contents').append("<nav><ul class='pager'><li><a onclick='shang()'>上一页</a></li><li><a onclick='xia()'>下一页</a></li></ul></nav>")
                // }


                //分类
                $('#typess').empty();
                for (var i = 0; i < r.types.length; i++) {
                    $('#typess').append("<li><a href='/contents/getcontentByMid/"+r.types[i].mid+"'>"+r.types[i].name+"</a></li>")

                }

            }
        );
    }
    loadIndex(1);




</script>
</html>
