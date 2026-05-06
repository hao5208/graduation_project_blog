<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: 20286
  Date: 2024/3/22
  Time: 下午 1:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>后台管理-分类管理</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">

    <ul class="nav nav-pills">
        <li role="presentation"><a href="/">网站首页</a></li>
        <li role="presentation"><a href="/adminIndex.jsp">后台首页</a></li>
        <li role="presentation"><a href="/contents/getcontents">文章管理</a></li>
        <li role="presentation" class="active"><a href="/types/gettypes">分类管理</a></li>
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
    <h2 class="page-header">分类管理</h2>
    <a data-toggle="modal" data-target="#addtypesM"><span class="glyphicon glyphicon-plus btn btn-default"></span></a>
    <table class="table table-striped table-bordered">
        <tr>
            <td><input type="checkbox" name="selectAll" onclick="selectAll(this)" class="form-check-input"></td>
            <td>id</td>
            <td>分类名</td>
            <td>描述</td>
            <td>父类</td>
            <td>操作</td>
        </tr>

        <c:forEach items="${records}" var="d">
            <tr>
                <td><input type="checkbox" name="product" class="form-check-input"></td>
                <td>${d.mid}</td>
                <td>${d.name}</td>
                <td>${d.description}</td>
                <td>${d.parent}</td>
                <td>
                    <a href="#" onclick="del(${d.mid},'${d.name}')">删除</a>
                    <a data-toggle="modal" data-target="#settypesM" onclick="xuigaibtn(${d.mid},'${d.name}','${d.description}',${d.parent})">修改</a>
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

        <li><a href="gettypes?curr=${curr==1? 1: curr-1}">&laquo;</a></li>

        <c:forEach begin="1" end="${pages}" step="1" varStatus="m">
            <c:if test="${curr == m.index }">
                <li class="active"><a href="gettypes?curr=${m.index}">${m.index}</a></li>
            </c:if>

            <c:if test="${curr != m.index }">
                <li><a href="gettypes?curr=${m.index}">${m.index}</a></li>
            </c:if>

        </c:forEach>

        <li><a href="gettypes?curr=${curr==pages? pages: curr+1}">&raquo;</a></li>
    </ul>
</div>
<%--添加模态框--%>
<div class="modal fade" id="addtypesM">
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
                        <label class="control-label">分类名:</label>
                        <input type="text" class="form-control"  id="name" name="name">
                    </div>

                    <div class="form-group">
                        <label class="control-label">描述:</label>
                        <input type="text" class="form-control"  id="description" name="description">
                    </div>

                    <div class="form-group">
                        <label class="control-label">父类:</label>
<%--                        <input type="text" class="form-control"  id="parent" name="parent">--%>
                        <select id="parent" name="parent" class="form-control">
                            <option value="0">无</option>

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
<div class="modal fade" id="settypesM">
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
                        <label class="control-label">分类id:</label>
                        <input type="text" class="form-control"  id="smid" name="mid">
                    </div>
                    <div class="form-group">
                        <label class="control-label">分类名:</label>
                        <input type="text" class="form-control"  id="sname" name="name">
                    </div>

                    <div class="form-group">
                        <label class="control-label">描述:</label>
                        <input type="text" class="form-control"  id="sdescription" name="description">
                    </div>

                    <div class="form-group">
                        <label class="control-label">父类:</label>
                        <input type="text" class="form-control"  id="sparent" name="parent">
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
<%--<script src="js/jquery-3.7.1.min.js"></script>--%>
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
        if (confirm("您确定要删除选中的分类吗？选中的分类ID为：" + selectedIds)) {
            $.ajax({
                url:"/types/delcids",
                type:"post",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(selectedIds)
            }).done(function (response) {
                if (response=="success"){
                    alert("删除成功")
                    //刷新
                    location.reload();
                }else {
                    alert("删除失败，请确认相关文章已删除")
                }

            })
        }
    }


        function del(mid,name) {
        //alert(empno)
        if(confirm("是否删除"+name+"分类?")){
            $.ajax({
                type: "get",
                url: "/types/delete/"+mid,
                success: function (response) {
                    if (response=="success"){
                        alert("删除成功")
                        //刷新
                        location.reload();
                    }else {
                        alert("删除失败，请确认相关文章已删除")
                    }
                }
            });
        }
    }

    $("#addbaocun").click(function () {
        var DataForm = {
            mid: $("#mid").val(),
            name: $("#name").val(),
            description: $("#description").val(),
            parent: $("#parent").val()
        };
        $.ajax({
            url:"/types/add",
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

    function xuigaibtn(mid,name,description,parent) {
            $("#smid").val(mid)
            $("#sname").val(name)
            $("#sdescription").val(description)
            $("#sparent").val(parent)

    }

    $("#setbaocun").click(function () {
        var DataForm = {
            mid: $("#smid").val(),
            name: $("#sname").val(),
            description: $("#sdescription").val(),
            parent: $("#sparent").val()
        };
        $.ajax({
            url:"/types/update",
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
    $.getJSON("/index/getindex?curr=1",
        function (r) {
            //分类
            // $('#parent').empty();
            for (var i = 0; i < r.types.length; i++) {
                $('#parent').append("<option value='"+r.types[i].mid+"'>"+r.types[i].name+"</option>")

            }
        })
</script>
</html>
