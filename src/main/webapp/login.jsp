<%--
  Created by IntelliJ IDEA.
  User: 20286
  Date: 2024/3/20
  Time: 下午 2:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录/注册</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/login1.css">
</head>
<body>
<!-- signin end -->
<section class="signin">
    <div class="container">

        <div class="sign-content">
            <h2>登录</h2>

            <div class="row">
                <div class="col-sm-12">
                    <div class="signin-form">
                        <form action="/users/login" method="post">
                            <div class="form-group">
                                <label>用户名</label>
                                <input type="text" name="username" class="form-control" placeholder="请输入正确的用户名" required>
                            </div><!--/.form-group -->
                            <div class="form-group">
                                <label>密码</label>
                                <input type="password" name="password" class="form-control" placeholder="请输入密码" required>
                            </div><!--/.form-group -->
                            <button type="submit" class="btn signin_btn" data-target=".signin_modal">
                                登录
                            </button>
                        </form><!--/form -->
                    </div><!--/.signin-form -->
                </div><!--/.col -->
            </div><!--/.row -->

            <div class="row">
                <div class="col-sm-12">
                    <div class="signin-footer">
                        <p>
                            还不是本站用户?
                            <a href="#" data-toggle="modal" data-target=".signin_modal">注册</a>
                        </p>
                    </div><!--/.signin-footer -->
                </div><!--/.col-->
            </div><!--/.row -->

        </div><!--/.sign-content -->

        <div class="modal fade signin_modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="sign-content">

                        <div class="modal-header">
                            <h2>注册</h2>
                        </div><!--/.modal-header -->

                        <div class="modal-body">
                            <div class="signin-form">
                                <div class=" ">
                                    <div class=" ">
                                        <form id="setusers">
                                            <div class="form-group">
                                                <label>用户名</label>
                                                <input type="text" class="form-control" id="username" name="username" placeholder="请输入正确用户名(8-12位字母数字组合)" required onblur="seluser()">
                                            </div><!--/.form-group -->
                                            <div class="form-group">
                                                <label>邮箱</label>
                                                <input type="email" class="form-control" id="mail" name="mail" placeholder="请输入正确邮箱" required>
                                            </div><!--/.form-group -->
                                            <div class="form-group">
                                                <label>密码</label>
                                                <input type="password" class="form-control" id="password" name="password" placeholder="密码(密码必须为8-15位字母数字组合)" required>
                                            </div><!--/.form-group -->
                                            <div class="form-group">
                                                <label>确认密码</label>
                                                <input type="password" class="form-control" id="qpassword" name="qpassword" placeholder="确认密码(密码必须为8-15位字母数字组合)" required>
                                            </div><!--/.form-group -->
                                        </form><!--/form -->
                                    </div><!--/.col -->
                                </div><!--/.row -->
                            </div><!--/.signin-form -->

                            <div class="signin-password">
                                <div class="awesome-checkbox-list">
                                    <ul class="unstyled centered">

                                        <li>
                                            <input class="styled-checkbox" id="styled-checkbox-3" type="checkbox" value="value3">
                                            <label for="styled-checkbox-3">接受  <a style="color: #1c7cf8" href="/yhxy.jsp">用户协议</a></label>

                                        </li>

                                        <li></li>
                                    </ul>
                                </div><!--/.awesome-checkbox-list -->
                            </div><!--/.signin-password -->

                            <div class="signin-footer">
                                <button type="button" class="btn signin_btn" id="addbaocun">
                                    注册
                                </button>

                            </div><!--/.signin-footer -->
                        </div><!--/.modal-body -->
                    </div><!--/.sign-content -->
                </div><!--/.modal-content -->
            </div><!--/.modal-dialog -->
        </div><!--/.modal -->
        <!-- modal part end -->
    </div><!--/.container -->
</section><!--/.signin -->
</body>
<script src="/js/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script>
    $("#addbaocun").prop("disabled", true);
    $("#addbaocun").click(function () {

        var username = $("#username").val();
        var mail = $("#mail").val();
        var password = $("#password").val();
        var qpassword = $("#qpassword").val();

        if(password==qpassword){

            if (username!=""&&mail!=""&&password!=""&&qpassword!=""){

                if (!/^[a-zA-Z0-9]{8,12}$/.test(username)) {
                    alert("用户名必须为8-12位字母数字组合")
                    return;
                }
                if (!/^[a-zA-Z0-9]{8,15}$/.test(password)) {
                    alert("密码必须为8-15位字母数字组合")
                    return;
                }
                if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(mail)) {
                   alert("邮箱格式不正确")
                   return;
                }


                $.ajax({
                    url:"/users/addsel/"+username,
                    type:"get"
                }).done(function (response) {
                    if (response=="error"){
                        alert("用户名已存在，请换一个")
                        return;
                    }
                })

                    var DataForm = {
                        username: $("#username").val(),
                        password: $("#password").val(),
                        mail: $("#mail").val(),
                        ugroup:"user"

                    };
                    $.ajax({
                        url:"/users/add",
                        type:"post",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(DataForm)
                    }).done(function (response) {
                        if (response=="success"){
                            alert("注册成功")
                            //刷新
                            location.reload();
                        }else {
                            alert("注册失败，请联系管理员")
                        }

                    })
            }else {
                alert("请填写完整信息")
            }
        }else{
            alert('两次密码不一致')
        }
    })


    $(document).ready(function() {
        $("#styled-checkbox-3").change(function() {
            if ($(this).is(":checked")) {
                $("#addbaocun").prop("disabled", false);
            } else {
                $("#addbaocun").prop("disabled", true);
            }
        });
    });
    function seluser(){
        var username = $("#username").val();

        $.ajax({
            url:"/users/addsel/"+username,
            type:"get"
        }).done(function (response) {
            if (response=="error"){
                alert("用户名已存在，请换一个")

            }
        })
    }
</script>
</html>
