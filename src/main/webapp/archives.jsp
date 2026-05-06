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
    <title>文章-搜索结果</title>
    <link href="/css/blog.css" rel="stylesheet">
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <style>
        #contents img{
            max-width: 100% !important;
            height: auto !important;
        }
        .pinglunkuang{
            width: 100%;
            /*background-color: #1c7cf8;*/
            overflow: hidden;
            white-space: normal;
            word-break: break-all;
        }
        #newComment li,#newContent li,.blog-post-title,#wenzhang11{
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
                <c:if test="${ugroup=='user'}">
                    <a class="blog-nav-item" href=" /contents/getusercontents">用户后台</a>
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
            <div class="blog-post">
                <h2 class="blog-post-title">${content.title}</h2>
                <p class="blog-post-meta"><fmt:formatDate value="${ content.created }"  type="both" />by <a href="/contents/getcontentByUid/${content.uid}">${ content.users.username }</a> | <a href="/contents/getcontentByMid/${content.type}">${content.types.name}</a></p>
                <div id='wenzhang11'>${content.text}</div>

            </div>
            <hr>
            <h3>已有 ${comment.size()} 条评论</h3>
            <ol class="list-unstyled"  id="pinglun">
                <c:forEach items="${comment}" var="d">
                    <li>
                        <div><a>${d.name}</a></div>
                        <div class="blog-post-meta"><fmt:formatDate value="${ d.created }"  type="both" /></div>
                        <div class="pinglunkuang">${d.text}</div>
                    </li>
                </c:forEach>


            </ol>
            <h3>添加新评论</h3>
            <form id="addcoments">

                <c:if test="${username==null}">
                    <div class="form-group">
                        <label class="control-label">称呼</label>
                        <input type="text" class="form-control" id="name" name="name">
                    </div>
                    <div class="form-group">
                        <label class="control-label">邮箱</label>
                        <input type="text" class="form-control" id="mail" name="mail">
                    </div>
                </c:if>
                <c:if test="${username!=null}">
                    <div class="form-group">
                        <label class="control-label">称呼</label>
                        <input type="text" class="form-control" id="name" name="name" disabled="true" value="${username}">
                    </div>

                    <div class="form-group">
                        <label class="control-label">邮箱</label>
                        <input type="text" class="form-control" id="mail" name="mail" disabled="true" value="${mail}">
                    </div>
                </c:if>

                <div class="form-group">
                    <label class="control-label">内容</label>
                    <textarea rows="8" cols="50" name="text" id="text" class="form-control" required=""></textarea>
                </div>

            </form>
            <p>
                <button id="addbaocun" class="btn btn-primary">提交评论</button>
            </p>

            <ul class="list-unstyled">
                <c:if test="${shang!=null}">
                    <li>上一篇: <a href="/index/getcontent/${shang.cid}">${shang.title}</a></li>
                </c:if>
                <c:if test="${shang==null}">
                    <li>上一篇: 没有了</li>
                </c:if>

                <c:if test="${xia!=null}">
                    <li>下一篇: <a href="/index/getcontent/${xia.cid}">${xia.title}</a></li>
                </c:if>
                <c:if test="${xia==null}">
                    <li>下一篇: 没有了</li>
                </c:if>

            </ul>
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
                //中心文章
                // $('#contents').empty();
                // for (var i = 0; i < r.records.length; i++) {
                //
                //     $('#contents').append(
                //         "<div class='blog-post'>" +
                //         "<h2 class='blog-post-title'><a>"+r.records[i].title+"</a></h2>"+
                //         "<p class='blog-post-meta'>"+r.records[i].created+" by <a href='#'>"+r.records[i].users.username+"</a></p>"+
                //         r.records[i].text+"</div>"
                //     );
                //     //$('#newContent').append("<li><a href='#'>"+r.+"</a></li>")
                // }

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

    function xia(){
        loadIndex(curr+1);
    }
    function shang(){
        loadIndex(curr-1);
    }

    $("#addbaocun").click(function () {
        var DataForm = {
            cid: ${content.cid},
            name: $("#name").val(),
            mail: $("#mail").val(),
            text: $("#text").val()
        };
        $.ajax({
            url:"/comments/add",
            type:"post",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(DataForm)
        }).done(function (response) {
            if (response=="success"){
                alert("评论成功")
                //刷新
                location.reload();
            }else {
                alert("评论失败")
            }

        })
    })
</script>
</html>
