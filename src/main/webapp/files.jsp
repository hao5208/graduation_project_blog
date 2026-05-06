<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: 20286
  Date: 2024/3/22
  Time: 下午 7：36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>后台管理-文件管理</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 自定义文件上传按钮样式 */
        .custom-file-input {
            display: inline-block;
            position: relative;
            overflow: hidden;
            width: 200px;
            height: 34px;
            font-size: 14px;
            line-height: 34px;
            text-align: center;
            vertical-align: middle;
            cursor: pointer;
            background-color: #337ab7;
            color: #fff;
            border: none;
            border-radius: 4px;
        }
        .custom-file-input input[type="file"] {
            position: absolute;
            top: 0;
            right: 0;
            margin: 0;
            padding: 0;
            cursor: pointer;
            opacity: 0;
            filter: alpha(opacity=0);
            font-size: 14px;
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
        <li role="presentation"><a href="/comments/getcomments">评论管理</a></li>
        <li role="presentation"><a href="/users/getusers">用户管理</a></li>
        <li role="presentation" class="active"><a href="/files/getfiles">文件管理</a></li>
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
    <h2 class="page-header">文件管理</h2>
    <a data-toggle="modal" data-target="#addusersM"><span class="glyphicon glyphicon-plus btn btn-default"></span></a>
    <table class="table table-striped table-bordered">
        <tr>
            <td><input type="checkbox" name="selectAll" onclick="selectAll(this)" class="form-check-input"></td>
            <td>id</td>
            <td>文件名</td>
            <td>文件类型</td>
            <td>上传用户</td>
            <td>url</td>
            <td>操作</td>
        </tr>

        <c:forEach items="${records}" var="d">
            <tr>
                <td><input type="checkbox" name="product" class="form-check-input"></td>
                <td>${d.fid}</td>
                <td>${d.name}</td>
                <td>${d.type}</td>
                <td>${d.users.username}</td>
                <td>${d.link}</td>
                <td>
                    <a onclick="del(${d.fid},'${d.name}')">删除</a>
                    <a href="${d.link}">查看详情</a>
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

        <li><a href="getfiles?curr=${curr==1? 1: curr-1}">&laquo;</a></li>

        <c:forEach begin="1" end="${pages}" step="1" varStatus="m">
            <c:if test="${curr == m.index }">
                <li class="active"><a href="getfiles?curr=${m.index}">${m.index}</a></li>
            </c:if>

            <c:if test="${curr != m.index }">
                <li><a href="getfiles?curr=${m.index}">${m.index}</a></li>
            </c:if>

        </c:forEach>

        <li><a href="getfiles?curr=${curr==pages? pages: curr+1}">&raquo;</a></li>
    </ul>
</div>
<%--添加模态框--%>
<div class="modal fade" id="addusersM">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">上传文件</h4>
            </div>
            <form id="uploadForm" enctype="multipart/form-data">
            <div class="modal-body">

<%--                <form action="/files/upload" method="post" enctype="multipart/form-data">--%>
<%--                   <input type="text" name="userid" value="${userid}"/> <br>--%>
<%--                    file: <input type="file" name="source" hidden id="file"/>--%>
<%--                    <br>--%>
<%--                    <input type="submit" value="提交"/>--%>
<%--                </form>--%>


                    <input type="text" name="userid" value="${userid}" hidden /> <br>
<%--                    <input type="file" name="source">--%>

                    <label class="custom-file-input">
                        <input type="file" id="fileInput" name="source">
                        选择文件
                    </label>
<%--                    <input type="submit" value="上传文件">--%>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary" id="addbaocun">上传</button>
            </div>
            </form>
        </div>
    </div>
</div>

</body>
<script src="/js/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script>

    $("#uploadForm").submit(function(event){
        event.preventDefault();

        // 获取表单数据
        var formData = new FormData($(this)[0]);

        // 发送Ajax请求
        $.ajax({
            url: '/files/upload',
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function(response){
                if(response.msg === "success") {
                    // 刷新页面
                    alert("上传成功")
                    location.reload();
                } else {
                    // 弹窗提示错误信息
                    alert("Error: " + response.msg);
                }
            },
            error: function(xhr, status, error) {
                // 弹窗提示错误信息
                alert("Error: " + error);
            }
        });
        return false;
    });
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
            alert("请选择要删除的文件！");
            return;
        }
        if (confirm("您确定要删除选中的文件吗？选中的文件ID为：" + selectedIds)) {
            $.ajax({
                url:"/files/delfids",
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


        function del(fid,name) {
        //alert(empno)
        if(confirm("是否文件"+name+"?")){
            $.ajax({
                type: "get",
                url: "/files/delete/"+fid,
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
            username: $("#username").val(),
            password: $("#password").val(),
            mail: $("#mail").val(),
            ugroup: $("#ugroup").val()
        };
        $.ajax({
            url:"/files/add",
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

</script>
</html>
