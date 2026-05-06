<%--
  Created by IntelliJ IDEA.
  User: 20286
  Date: 2024/3/22
  Time: 上午 11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>文章修改</title>
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
<!-- Place the first <script> tag in your HTML's <head> -->
<%--<script src="https://cdn.tiny.cloud/1/2uzqr4gtzzjrey2tv6m1ytylmpoeuex4v388g6rd77tk6m28/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>--%>
<link href="/css/bootstrap.min.css" rel="stylesheet">
<%--<script>--%>
<%--    tinymce.init({--%>
<%--        selector: 'textarea',--%>
<%--        language: 'zh_CN',--%>
<%--        plugins: 'anchor autolink charmap codesample image link lists media searchreplace table visualblocks wordcount',--%>
<%--        toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | addcomment showcomments | spellcheckdialog a11ycheck typography | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat',--%>
<%--        tinycomments_mode: 'embedded',--%>
<%--        tinycomments_author: 'Author name',--%>
<%--        mergetags_list: [--%>
<%--            { value: 'First.Name', title: 'First Name' },--%>
<%--            { value: 'Email', title: 'Email' },--%>
<%--        ],--%>
<%--        ai_request: (request, respondWith) => respondWith.string(() => Promise.reject("See docs to implement AI Assistant")),--%>
<%--    });--%>
<%--</script>--%>
<div class="container">
    <h2 class="page-header">修改文章</h2>
    <form>
        文章id：<input type="text" class="form-control" id="cid" name="cid" disabled="true" value="${con.cid}">
        标题：<input  id="title" name="title" class="form-control" value="${con.title}"><br>
        文章：<textarea id="text1" name="text">${con.text}</textarea><br>
        文件上传(最大10mb)：
        <div>
            <%--            <input type="file" id="fileInput">--%>
            <label class="custom-file-input">
                <input type="file" id="fileInput">
                选择文件
            </label>
            <div id="a1"></div>
            <div id="a2">

            </div>

        </div>
        文章分类：
        <select id="type" name="type" class="form-control" values="${con.type}">

        </select>

<%--        <input type="text" id="type" name="type" class="form-control" value="${con.type}">--%>
        用户:<input type="text" class="form-control"  id="username" name="username" value="${con.users.username}" disabled="true">
        <input type="text" id="uid" name="uid" value="${con.uid}" hidden="hidden">
<%--        <select id="type" name="type" class="form-control" ${con.title}>--%>
<%--        <option value="1">111</option>--%>
<%--    </select>--%>
    </form>
    <br>
    <button class="btn btn-primary" onclick="bc()">保存文章</button>
</div>
</body>
<script src="/js/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/tinymce/tinymce.min.js"></script>
<script>
    tinymce.init({
        selector: 'textarea',
        language: 'zh_CN',
        plugins: 'anchor autolink charmap codesample image link lists media searchreplace table visualblocks wordcount image',
        toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table mergetags | addcomment showcomments | spellcheckdialog a11ycheck typography | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
        // images_upload_url: '/files/tinyupload',
        // images_upload_base_path: '/',


        // tinycomments_mode: 'embedded',
        // tinycomments_author: 'Author name',
        // mergetags_list: [
        //     { value: 'First.Name', title: 'First Name' },
        //     { value: 'Email', title: 'Email' },
        // ],
        // ai_request: (request, respondWith) => respondWith.string(() => Promise.reject("See docs to implement AI Assistant")),
    });
    function bc(){
        var editor = tinymce.get('text1');
        var content = editor.getContent();


        var DataForm = {
            cid: $("#cid").val(),
            title: $("#title").val(),
            text: content,
            type: $("#type").val(),
            uid: $("#uid").val()
        };
        $.ajax({
            url:"/contents/update",
            type:"post",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(DataForm)
        }).done(function (response) {
            if (response=="success"){
                alert("成功")
                //刷新
                window.location.href = document.referrer;
            }else {
                alert("失败")
            }

        })
    }

    $.ajax({
        url:"/types/queryAllType",
        type:"post",
        contentType: "application/json; charset=utf-8"
    }).done(function (r) {
        for (let i = 0; i < r.length; i++) {

            if (r[i].mid==${con.type}){
                $('#type').append("<option value='"+r[i].mid+"' selected>"+r[i].name+"</option>")
            }else {
                $('#type').append("<option value='"+r[i].mid+"'>"+r[i].name+"</option>")
            }
        }

    })

    $(document).ready(function() {
        $('#fileInput').change(function() {
            uploadFile();
        });
    });

    function uploadFile() {
        const fileInput = $('#fileInput')[0];
        const file = fileInput.files[0];
        const formData = new FormData();
        formData.append('source', file);
        formData.append("userid",1)

        // 给定的URL
        var urlString = window.location.href;

        // 使用URL对象解析URL
        var url = new URL(urlString);

        // 构建带协议的完整主机部分
        var fullHost = url.protocol + "//" + url.host;
        $.ajax({
            url: '/files/upload',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(data) {
                const imageUrl = ""+data.url; // 假设返回的 JSON 数据中包含图片链接字段
                // $('#a2').append('<p> '+ imageUrl +' </p>');
                $('#a2').append('<input class="form-control" type="text" id="'+ data.sj +'" value="'+ fullHost+imageUrl +' "onclick=copyText("'+data.sj+'")>')
            },
            error: function(error) {
                console.error('上传失败:', error);

            }
        });
    }
    function copyText(ss) {
        const textBox = document.getElementById(ss);
        textBox.select();
        document.execCommand('copy');
        alert('内容已复制到剪贴板！');
    }
</script>
</html>
