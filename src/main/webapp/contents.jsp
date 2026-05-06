<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: 20286
  Date: 2024/3/20
  Time: 下午 5:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>后台管理-文章管理</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        #wenzhangtitle{
            width: 30%;
            /*background-color: #1c7cf8;*/
            overflow: hidden;
            white-space: normal;
            word-break: break-all;
        }
    </style>
</head>
<body>
<div class="container">
    <ul class="nav nav-pills">
        <li role="presentation"><a href="/">网站首页</a></li>
        <li role="presentation"><a href="/adminIndex.jsp">后台首页</a></li>
        <li role="presentation" class="active"><a href="/contents/getcontents">文章管理</a></li>
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
    <h2 class="page-header">文章管理</h2>
    <a href="/addcontent.jsp"><span class="glyphicon glyphicon-plus btn btn-default"></span></a>
    <table class="table table-striped table-bordered">
        <tr>
            <td><input type="checkbox" name="selectAll" onclick="selectAll(this)" class="form-check-input"></td>
            <td>id</td>
            <td>标题</td>
<%--            <td>内容</td>--%>
            <td>分类</td>
            <td>用户</td>
            <td>发布时间</td>
            <td>最新修改时间</td>
            <td>阅读量</td>
            <td>状态</td>
            <td>操作</td>
        </tr>

        <c:forEach items="${records}" var="d">
            <tr>
                <td><input type="checkbox" name="product" class="form-check-input"></td>
                <td>${d.cid}</td>
                <td id="wenzhangtitle">${d.title}</td>
<%--                <td>${d.text}</td>--%>
                <td>${d.types.name}</td>
                <td>${d.users.username}</td>
                <td>
                    <fmt:formatDate value="${ d.created }"  type="both" />
                </td>
                <td>
                    <fmt:formatDate value="${ d.modified }"  type="both" />
                </td>
                <td>${d.readingcount}</td>
                <td>
                    <c:if test="${d.status==0}">
                        <a class="btn btn-primary" onclick="updatestatus(${d.cid},0)">隐藏</a>
                    </c:if>
                    <c:if test="${d.status==1}">
                        <a class="btn btn-success" onclick="updatestatus(${d.cid},1)"> 显示</a>
                    </c:if>
                </td>
                <td>
                    <a href="#" onclick="del(${d.cid},'${d.title}')">删除</a>
                    <a href="/contents/updatesel/${d.cid}">修改</a>
                </td>
            </tr>

        </c:forEach>
    </table>
    <a onclick="deleteSelected()" class="btn btn-danger">删除选中</a>
    <p align="center">
        总页数: ${pages }
        当前页码: ${curr }
        总记录数: ${counts}
    </p>
    <ul class="pagination">

        <li><a href="getcontents?curr=${curr==1? 1: curr-1}">&laquo;</a></li>

        <c:forEach begin="1" end="${pages}" step="1" varStatus="m">
            <c:if test="${curr == m.index }">
                <li class="active"><a href="getcontents?curr=${m.index}">${m.index}</a></li>
            </c:if>

            <c:if test="${curr != m.index }">
                <li><a href="getcontents?curr=${m.index}">${m.index}</a></li>
            </c:if>

        </c:forEach>

        <li><a href="getcontents?curr=${curr==pages? pages: curr+1}">&raquo;</a></li>
    </ul>
</div>

</body>
<script src="/js/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script>

    function selectAll(source) {
        checkboxes = document.getElementsByName('product');
        for(var i=0, n=checkboxes.length;i<n;i++) {
            checkboxes[i].checked = source.checked;
        }
    }
    function deleteSelected() {
        var selectedIds = [];
        checkboxes = document.getElementsByName('product');
        for(var i=0, n=checkboxes.length;i<n;i++) {
            if(checkboxes[i].checked) {
                var row = checkboxes[i].parentNode.parentNode;
                var id = row.cells[1].innerText; // Assuming ID is in the second cell
                selectedIds.push(id);
            }
        }
        if(selectedIds.length === 0) {
            alert("请选择要删除的文章！");
            return;
        }
        if (confirm("您确定要删除选中的文章吗？选中的文章ID为：" + selectedIds)) {
            $.ajax({
                url:"/contents/delcids",
                type:"post",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(selectedIds)
            }).done(function (response) {
                if (response=="success"){
                    alert("删除成功")
                    //刷新
                    location.reload();
                }else {
                    alert("删除失败")
                }

            })
        }
    }


        function del(cid,name) {
        //alert(empno)
        if(confirm("是否删除文章"+name+"?")){
            // location.href ="delEmp?empno=" + empno
            $.ajax({
                type: "get",
                url: "/contents/delete/"+cid,
                success: function (response) {
                    //alert(response)
                    // alert("删除成功")
                    // location.reload();
                    if (response=="success"){
                        alert("删除成功")
                        //刷新
                        location.reload();
                    }else {
                        alert("删除失败，请确认相关评论是否删除")
                    }
                }
            });
        }
    }


    function updatestatus(cid,status) {
        var DataForm = {
            cid: cid,
            status: status
        };
        $.ajax({
            url:"/contents/updatestatic",
            type:"post",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(DataForm)
        }).done(function (response) {
            if (response=="success"){
                // alert("成功")
                //刷新
                location.reload();
            }else {
                alert("失败")
            }

        })
    }
</script>
</html>
