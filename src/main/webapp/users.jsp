<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: 20286
  Date: 2024/3/22
  Time: 下午 3：56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>后台管理-用户管理</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">

    <ul class="nav nav-pills">
        <li role="presentation"><a href="/">网站首页</a></li>
        <li role="presentation"><a href="/adminIndex.jsp">后台首页</a></li>
        <li role="presentation"><a href="/contents/getcontents">文章管理</a></li>
        <li role="presentation"><a href="/types/gettypes">分类管理</a></li>
        <li role="presentation"><a href="/comments/getcomments">评论管理</a></li>
        <li role="presentation" class="active"><a href="/users/getusers">用户管理</a></li>
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
    <h2 class="page-header">用户管理</h2>
    <a data-toggle="modal" data-target="#addusersM"><span class="glyphicon glyphicon-plus btn btn-default"></span></a>
    <table class="table table-striped table-bordered">
        <tr>
            <td><input type="checkbox" name="selectAll" onclick="selectAll(this)" class="form-check-input"></td>
            <td>id</td>
            <td>用户名</td>
            <td>邮箱</td>
            <td>注册时间</td>
            <td>最近活动</td>
            <td>用户权限</td>
            <td>状态</td>
            <td>操作</td>
        </tr>

        <c:forEach items="${records}" var="d">
            <tr>
                <td><input type="checkbox" name="product" class="form-check-input"></td>
                <td>${d.uid}</td>
                <td>${d.username}</td>
                <td>${d.mail}</td>

                <td>
                    <fmt:formatDate value="${ d.created }"  type="both" />
                </td>
                <td>
                    <fmt:formatDate value="${ d.activated }"  type="both" />
                </td>
                <td>${d.ugroup}</td>
                <td>
                    <c:if test="${d.status==0}">
                        <a class="btn btn-primary" onclick="updatestatus(${d.uid},0)">封禁</a>
                    </c:if>
                    <c:if test="${d.status==1}">
                        <a class="btn btn-success" onclick="updatestatus(${d.uid},1)">正常</a>
                    </c:if>
                </td>
                <td>
                    <a onclick="del(${d.uid},'${d.username}')">删除</a>
                    <a data-toggle="modal" data-target="#setusersM" onclick="xuigaibtn(${d.uid},'${d.username}','${d.password}','${d.mail}','${d.ugroup}')">修改</a>
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

        <li><a href="getusers?curr=${curr==1? 1: curr-1}">&laquo;</a></li>

        <c:forEach begin="1" end="${pages}" step="1" varStatus="m">
            <c:if test="${curr == m.index }">
                <li class="active"><a href="getusers?curr=${m.index}">${m.index}</a></li>
            </c:if>

            <c:if test="${curr != m.index }">
                <li><a href="getusers?curr=${m.index}">${m.index}</a></li>
            </c:if>

        </c:forEach>

        <li><a href="getusers?curr=${curr==pages? pages: curr+1}">&raquo;</a></li>
    </ul>
</div>
<%--添加模态框--%>
<div class="modal fade" id="addusersM">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">增加用户</h4>
            </div>
            <div class="modal-body">
                <form id="addusers">
                    <div class="form-group">
                        <label class="control-label">用户名:</label>
                        <input type="text" class="form-control" id="username" name="username">
                    </div>
                    <div class="form-group">
                        <label class="control-label">密码:</label>
                        <input type="password" class="form-control"  id="password" name="password">
                    </div>

                    <div class="form-group">
                        <label class="control-label">邮箱:</label>
                        <input type="text" class="form-control"  id="mail" name="mail">
                    </div>

                    <div class="form-group">
                        <label class="control-label">用户类:</label>
<%--                        <input type="text" class="form-control"  id="ugroup" name="ugroup">--%>
                        <select id="type" name="type" class="form-control">
                            <option value="user">普通用户</option>
                            <option value="admin">管理员</option>
                        </select>
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
<div class="modal fade" id="setusersM">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改评论</h4>
            </div>
            <div class="modal-body">
                <form id="setusers">
                    <div class="form-group">
                        <label class="control-label">用户id:</label>
                        <input type="text" class="form-control" id="suid" name="uid" disabled="true">
                    </div>
                    <div class="form-group">
                        <label class="control-label">用户名:</label>
                        <input type="text" class="form-control" id="susername" name="username">
                    </div>
                    <div class="form-group">
                        <label class="control-label">密码:</label>
                        <input type="password" class="form-control"  id="spassword" name="password">
                    </div>

                    <div class="form-group">
                        <label class="control-label">邮箱:</label>
                        <input type="text" class="form-control"  id="smail" name="mail">
                    </div>

                    <div class="form-group">
                        <label class="control-label">用户类:</label>
                        <input type="text" class="form-control"  id="sugroup" name="ugroup">
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
            alert("请选择要删除的用户！");
            return;
        }
        if (confirm("您确定要删除选中的用户吗？选中的用户ID为：" + selectedIds)) {
            $.ajax({
                url:"/users/delcids",
                type:"post",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(selectedIds)
            }).done(function (response) {
                if (response=="success"){
                    alert("删除成功")
                    //刷新
                    location.reload();
                }else {
                    alert("删除失败,请先删除相关用户的数据")
                }

            })
        }
    }


        function del(uid,name) {
        //alert(empno)
        if(confirm("是否用户"+name+"?")){
            $.ajax({
                type: "get",
                url: "/users/delete/"+uid,
                success: function (response) {
                    if (response=="success"){
                        alert("删除成功")
                        //刷新
                        location.reload();
                    }else {
                        alert("删除失败,请先删除相关用户的数据")
                    }
                }
            });
        }
    }

    $("#addbaocun").click(function () {
        var DataForm = {
            username: $("#username").val(),
            password: $("#password").val(),
            mail: $("#mail").val(),
            ugroup: $("#type").val()
        };
        $.ajax({
            url:"/users/add",
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

    function xuigaibtn(uid,username,password,mail,ugroup) {
            $("#suid").val(uid)
            $("#susername").val(username)
            $("#spassword").val(password)
            $("#smail").val(mail)
            $("#sugroup").val(ugroup)

    }

    $("#setbaocun").click(function () {
        var DataForm = {
            uid: $("#suid").val(),
            username: $("#susername").val(),
            password: $("#spassword").val(),
            mail: $("#smail").val(),
            ugroup: $("#sugroup").val()
        };
        $.ajax({
            url:"/users/update",
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

    function updatestatus(uid,status) {
        var DataForm = {
            uid: uid,
            status: status
        };
        $.ajax({
            url:"/users/updatestatic",
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
