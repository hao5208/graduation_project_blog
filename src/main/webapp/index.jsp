<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>首页</title>
    <link href="/css/blog.css" rel="stylesheet">
    <link href="/css/bootstrap.min.css" rel="stylesheet">
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
<%--    <div class="container">--%>
<%--        <nav class="blog-nav">--%>
<%--            <a class="blog-nav-item active" href="/">首页</a>--%>

<%--            <c:if test="${username==null}">--%>
<%--                <a class="blog-nav-item" href="/login.jsp">登录</a>--%>
<%--            </c:if>--%>
<%--            <c:if test="${ugroup=='admin'}">--%>
<%--                <a class="blog-nav-item" href="/adminIndex.jsp">后台管理</a>--%>
<%--            </c:if>--%>
<%--            <c:if test="${username!=null}">--%>
<%--                您好: ${username}--%>
<%--                <a class="blog-nav-item" href="/users/logout">退出</a>--%>
<%--            </c:if>--%>
<%--                <nav class="blog-nav" style="float: right;line-height: 20px">--%>
<%--                    <form style="">--%>
<%--                        <input type="text" id="ss">--%>
<%--                        <button id="ss1">搜索</button>--%>
<%--                    </form>--%>
<%--                </nav>--%>
<%--        </nav>--%>

<%--    </div>--%>
    <div class="container">
        <nav class="blog-nav" style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <a class="blog-nav-item active" href="/">首页</a>

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
<%--        <h1 class="blog-title">区域1</h1>--%>
<%--        <p class="lead blog-description">The official example template of creating a blog with Bootstrap.</p>--%>
<%--   轮播图--%>
<%--        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">--%>
<%--            <!-- Indicators -->--%>
<%--            <ol class="carousel-indicators">--%>
<%--                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>--%>
<%--                <li data-target="#carousel-example-generic" data-slide-to="1"></li>--%>
<%--                <li data-target="#carousel-example-generic" data-slide-to="2"></li>--%>
<%--            </ol>--%>
<%--    --%>
<%--            <!-- Wrapper for slides -->--%>
<%--            <div class="carousel-inner" role="listbox">--%>
<%--                <div class="item active">--%>
<%--                    <img src="https://api.dujin.org/bing/1366.php" alt="...">--%>
<%--                    <div class="carousel-caption">--%>
<%--                        描述1--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="item">--%>
<%--                    <img src="https://api.btstu.cn/sjbz/api.php?lx=fengjing&format=images" alt="...">--%>
<%--                    <div class="carousel-caption">--%>
<%--                       描述2--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="item">--%>
<%--                    <img src="https://api.btstu.cn/sjbz/api.php?lx=meizi&format=images" alt="...">--%>
<%--                    <div class="carousel-caption">--%>
<%--                        描述3--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--    --%>
<%--            <!-- Controls -->--%>
<%--            <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">--%>
<%--                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>--%>
<%--                <span class="sr-only">Previous</span>--%>
<%--            </a>--%>
<%--            <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">--%>
<%--                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>--%>
<%--                <span class="sr-only">Next</span>--%>
<%--            </a>--%>
<%--        </div>--%>
    </div>

    <div class="row">

        <div class="col-sm-8 blog-main" id="contents">
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
<%--                    <li><a href="#">March 2014</a></li>--%>
                </ol>
            </div>
            <div class="sidebar-module">
                <h4>分类</h4>
                <ol class="list-unstyled" id="typess">
<%--                    <li><a href="#">October 2013</a></li>--%>
                </ol>
            </div>
            <div class="sidebar-module">
                <h4>友情链接</h4>
                <ol class="list-unstyled">
<%--                    <li><a href="https://www.cync.edu.cn/">朝阳师范高等专科学校</a></li>--%>
                    <li><a href="https://github.com/">GitHub</a></li>
                </ol>
            </div>
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
                $('#contents').empty();
                for (var i = 0; i < r.records.length; i++) {

                    $('#contents').append(
                        "<div class='blog-post'>" +
                        "<h2 class='blog-post-title'><a href='/index/getcontent/"+r.records[i].cid+"'>"+r.records[i].title+"</a></h2>"+
                        "<p class='blog-post-meta'>"+r.records[i].created+" by <a href='/contents/getcontentByUid/"+r.records[i].uid+"'>"+r.records[i].users.username+"</a> | <a href='/contents/getcontentByMid/"+r.records[i].type+"'>"+r.records[i].types.name+"</a></p><div id='wenzhang11'>"+
                        r.records[i].text+"</div></div>"
                    );
                    //$('#newContent').append("<li><a href='#'>"+r.+"</a></li>")
                }

                //右侧最新文章
                $('#newContent').empty();
                for (var i = 0; i < r.newContent.records.length; i++) {
                    $('#newContent').append("<li><a href='/index/getcontent/"+r.newContent.records[i].cid+"'>"+r.newContent.records[i].title+"</a></li>")

                }
                //右侧最新回复
                $('#newComment').empty();
                for (var i = 0; i < r.newComment.records.length; i++) {
                    $('#newComment').append("<li><a href='/index/getcontent/"+r.newComment.records[i].cid+"'>"+r.newComment.records[i].name+"</a>:"+r.newComment.records[i].text+"</li>")

                }
                //翻页


                if(r.counts>=10){
                    if (r.pages==r.curr){
                        $('#contents').append("<nav><ul class='pager'><li><a onclick='shang()'>上一页</a></li></ul></nav>")
                    }else if (r.curr==1){
                        $('#contents').append("<nav><ul class='pager'><li><a onclick='xia()'>下一页</a></li></ul></nav>")
                    }else {
                        $('#contents').append("<nav><ul class='pager'><li><a onclick='shang()'>上一页</a></li><li><a onclick='xia()'>下一页</a></li></ul></nav>")
                    }
                }else {
                    $('#contents').append("<nav><ul class='pager'><li>没有更多页了</li></ul></nav>")
                }



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
</script>
</html>
