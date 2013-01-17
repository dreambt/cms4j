<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset='utf-8'>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta http-equiv="Cache-Control" content="max-age=604800"/>
    <meta http-equiv="Last-Modified" content="Fri, 12 May 2012 18:53:33 GMT"/>
    <meta name="robots" content="index, follow"/>
    <meta name="keywords" content=""/>
    <meta name="title" content=""/>
    <meta name="description" content=""/>
    <title>后台登录 - 后台管理</title>
    <link rel="shortcut icon" href="${ctx}/static/favicon.ico" type="image/x-icon" />
    <%--<link href="${ctx}/min?t=css&f=/style/bootstrap.css,/style/bootstrap-responsive.css,/style/datepicker.css,/js/msgUI/msgGrowl.css,/js/validation/validate.css,/style/admin.css" rel="stylesheet" type="text/css" />--%>
    <%--<script src="${ctx}/min?t=js&f=/js/jquery.js,/js/bootstrap.js,/js/bootstrap-datepicker.js,/js/easing.js,/js/msgUI/msgGrowl.js,/js/main.js" type="text/javascript"></script>--%>
    <link href="${ctx}/static/admin.min.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/static/admin.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/validation/jquery.validate.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/validation/messages_bs_cn.js" type="text/javascript"></script>
    <style type="text/css">
        body {
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #f5f5f5;
        }
        .form-signin {
            max-width: 300px;
            padding: 19px 29px 29px;
            margin: 0 auto 20px;
            background-color: #fff;
            border: 1px solid #e5e5e5;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
            -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
            box-shadow: 0 1px 2px rgba(0,0,0,.05);
        }
        .form-signin .form-signin-heading, form-signin .checkbox {
            margin-bottom: 10px;
        }
        .form-signin input[type="text"], .form-signin input[type="password"] {
            font-size: 16px;
            height: auto;
            margin-bottom: 15px;
            padding: 7px 9px;
        }
    </style>
</head>
<body>
<div class="container">
    <form:form id="form-signin" action="${ctx}/login" method="post" cssClass="form-signin">
        <input type='hidden' name='csrfmiddlewaretoken' value='c1b1696edcea586856677cc78ad76833' />
        <h2 class="form-signin-heading">后台登录</h2>
        <%
            String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
            if(error != null){
        %>
        <div id="message" class="alert alert-block alert-error">
            <button type="button" class="close" data-dismiss="alert">×</button>
            <strong>Warning!</strong>
            <%
                if(error.contains("AuthenticationException")){
                    out.print("请检查您输入的账户、密码、验证码是否正确.");
                }
                else if(error.contains("UnknownAccountException")){
                    out.print("请检查您输入的账户、密码、验证码是否正确.");
                }
                else if(error.contains("DisabledAccountException")){
                    out.print("未经审核的账户不允许登录.");
                }
                else{
                    out.print("登录失败，请重试.");
                }
            %>
        </div>
        <%
            }
        %>
        <input type="text" id="username" name="username" value="${username}" class="input-block-level enail required" placeholder="Email"/>
        <input type="password" name="password" class="input-block-level required" placeholder="Password"/>
        <div id="imgid" style="display:block;margin:1px 0 0 200px;position:absolute;z-index:999;"></div>
        <input type="text" id="captcha" name="captcha" class="input-block-level required" autocomplete="off" placeholder="Captcha"/>
        <label class="checkbox">
            <input type="checkbox" id="rememberMe" name="rememberMe"> 记住密码
        </label>
        <button type="submit" class="btn btn-large btn-primary">登 录</button>
        <button type="button" class="btn btn-large" onclick="history.go(-1)">返 回</button>
    </form:form>
</div>
<script>
    $(function() {
        $("#username").focus();
        $("#form-signin").validate();
        $(".alert").delay(5000).fadeOut("slow");

        //验证码点击时显示
        $('#captcha').focus(function(){
            var img=$("<img id='checkNum' alt='验证码' style='cursor:pointer;vertical-align:text-bottom;height:33px'/>");
            img.attr("src","${ctx}/captcha.png?seed="+Math.random());
            $('#imgid').append(img);
        }).blur(function(){
            $('#imgid').contents().remove();
        });
    });
</script>
</body>
</html>