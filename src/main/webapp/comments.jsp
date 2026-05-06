<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: 20286
  Date: 2024/3/20
  Time: 上午 9:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>后台管理-评论管理</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <style type="text/css">
        #pingluntxt{
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
        <li role="presentation"><a href="/contents/getcontents">文章管理</a></li>
        <li role="presentation"><a href="/types/gettypes">分类管理</a></li>
        <li role="presentation" class="active"><a href="/comments/getcomments">评论管理</a></li>
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
    <h2 class="page-header">评论管理</h2>

    <a data-toggle="modal" data-target="#addcomentsM"><span class="glyphicon glyphicon-plus btn btn-default"></span></a>
<%--    <br><br>--%>
    <table class="table table-striped table-bordered">
        <tr>
            <td><input type="checkbox" name="selectAll" onclick="selectAll(this)" class="form-check-input"></td>
            <td>id</td>
            <td>文章</td>
            <td>昵称</td>
            <td>邮箱</td>
            <td>评论内容</td>
            <td>时间</td>
            <td>状态</td>
            <td>操作</td>
        </tr>

        <c:forEach items="${records}" var="d">
            <tr>
                <td><input type="checkbox" name="product" class="form-check-input"></td>
                <td>${d.coid}</td>
                <td>${d.contents.title}</td>
                <td>${d.name}</td>
                <td>${d.mail}</td>
                <td id="pingluntxt">${d.text}</td>
                <td>
                    <fmt:formatDate value="${ d.created }"  type="both" />
                </td>
                <td>
                    <c:if test="${d.status==0}">
                        <a class="btn btn-primary" onclick="updatestatus(${d.coid},0)">隐藏</a>
                    </c:if>
                    <c:if test="${d.status==1}">
                        <a class="btn btn-success" onclick="updatestatus(${d.coid},1)"> 显示</a>
                    </c:if>
                </td>
                <td>
                    <a href="#" onclick="del(${d.coid},'${d.name}')">删除</a>
                    <a data-toggle="modal" data-target="#setcomentsM" onclick="xuigaibtn(${d.coid},${d.cid},'${d.name}','${d.mail}','${d.text}')">修改</a>
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

        <li><a href="getcomments?curr=${curr==1? 1: curr-1}">&laquo;</a></li>

        <c:forEach begin="1" end="${pages}" step="1" varStatus="m">
            <c:if test="${curr == m.index }">
                <li class="active"><a href="getcomments?curr=${m.index}">${m.index}</a></li>
            </c:if>

            <c:if test="${curr != m.index }">
                <li><a href="getcomments?curr=${m.index}">${m.index}</a></li>
            </c:if>

        </c:forEach>

        <li><a href="getcomments?curr=${curr==pages? pages: curr+1}">&raquo;</a></li>
    </ul>
</div>
<%--添加模态框--%>
<div class="modal fade" id="addcomentsM">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">增加评论</h4>
            </div>
            <div class="modal-body">
                <form id="addcoments">
                    <div class="form-group">
                        <label class="control-label">文章id:</label>
                        <input type="text" class="form-control" id="cid" name="cid">
                    </div>
                    <div class="form-group">
                        <label class="control-label">昵称:</label>
                        <input type="text" class="form-control"  id="name" name="name">
                    </div>

                    <div class="form-group">
                        <label class="control-label">邮箱:</label>
                        <input type="text" class="form-control"  id="mail" name="mail">

                    </div>

                    <div class="form-group">
                        <label class="control-label">评论内容:</label>
                        <textarea class="form-control" id="text" name="text"></textarea>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="addbaocun">保存</button>
            </div>
        </div>
    </div>
</div>

<%--修改模态框--%>
<div class="modal fade" id="setcomentsM">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改评论</h4>
            </div>
            <div class="modal-body">
                <form id="setcoments">
                    <div class="form-group">
                        <label class="control-label">评论id:</label>
                        <input type="text" class="form-control" id="scoid" name="coid" disabled="true">
                    </div>
                    <div class="form-group">
                        <label class="control-label">文章id:</label>
                        <input type="text" class="form-control" id="scid" name="cid" disabled="true">
                    </div>
                    <div class="form-group">
                        <label class="control-label">昵称:</label>
                        <input type="text" class="form-control"  id="sname" name="name">
                    </div>

                    <div class="form-group">
                        <label class="control-label">邮箱:</label>
                        <input type="text" class="form-control"  id="smail" name="mail">

                    </div>

                    <div class="form-group">
                        <label class="control-label">评论内容:</label>
                        <textarea class="form-control" id="stext" name="text"></textarea>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="setbaocun">保存</button>
            </div>
        </div>
    </div>
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
            alert("请选择要删除的评论！");
            return;
        }
        if (confirm("您确定要删除选中的评论吗？选中的评论ID为：" + selectedIds)) {
            // $.ajax({
            //     type: "get",
            //     url: "../comments/ssss/"+selectedIds,
            //     success: function (response) {
            //         //alert(response)
            //         alert("删除成功")
            //         location.reload();
            //     }
            // });

            // var DataForm = {
            //    cids: selectedIds
            // };
            // alert(selectedIds)
            $.ajax({
                url:"/comments/delcids",
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


        function del(coid,name) {
        //alert(empno)
        if(confirm("是否删除"+name+"的评论?")){
            // location.href ="delEmp?empno=" + empno
            $.ajax({
                type: "get",
                url: "/comments/delete/"+coid,
                success: function (response) {
                    if (response=="success"){
                        alert("删除成功")
                        //刷新
                        location.reload();
                    }else {
                        alert("删除失败")
                    }
                }
            });
        }
    }

    $("#addbaocun").click(function () {
        var DataForm = {
            cid: $("#cid").val(),
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
                        alert("增加成功")
                        //刷新
                        location.reload();
                    }else {
                        alert("添加失败")
                    }

        })
    })

    function xuigaibtn(coid,cid,name,mail,text) {
            $("#scoid").val(coid)
            $("#scid").val(cid)
            $("#sname").val(name)
            $("#smail").val(mail)
            $("#stext").val(text)
    }

    $("#setbaocun").click(function () {
        var DataForm = {
            coid: $("#scoid").val(),
            cid: $("#scid").val(),
            name: $("#sname").val(),
            mail: $("#smail").val(),
            text: $("#stext").val()
        };
        $.ajax({
            url:"/comments/update",
            type:"post",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(DataForm)
        }).done(function (response) {
            if (response=="success"){
                alert("成功")
                //刷新
                location.reload();
            }else {
                alert("失败")
            }

        })
    })

    function updatestatus(coid,status) {
        var DataForm = {
            coid: coid,
            status: status
        };
        $.ajax({
            url:"/comments/updatestatic",
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
