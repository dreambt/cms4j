<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta http-equiv="Cache-Control" content="no-store"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <meta name="robots" content="index, follow"/>
    <meta name="keywords" content=""/>
    <meta name="title" content=""/>
    <meta name="description" content=""/>
    <title>后台登录</title>
    <link rel="shortcut icon" href="${ctx}/static/favicon.ico" type="image/x-icon" />
    <link href="${ctx}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/css/admin.min.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/static/js/jquery.min.js" type="text/javascript"></script>
</head>
<body>
<div class="row">
    <div class="span4 offset6">
        <div id="login" class="accounts-form">
            <h2>用户登录</h2>
            <hr class="small" />
            <%
                String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
                if(error != null){
                    if(error.contains("DisabledAccountException")){
            %>
            <div id="message" class="alert alert_red">
                用户已被屏蔽,请登录其他用户.
            </div>
            <%
            }else{
            %>
            <div id="message" class="alert alert_red">
                登录失败，请重试.
            </div>
            <%
                    }
                }
            %>
            <form:form id="loginForm" action="${ctx}/login" method="post">
                <div style='display:none'><input type='hidden' name='csrfmiddlewaretoken' value='c1b1696edcea586856677cc78ad76833' /></div>
                <div class="all-errors">
                </div>
                <div class="input">
                    <input type="text" name="username" id="id_email" maxlength="75" value="${username}" class="required email" placeholder="Email"  />
                </div>
                <div class="input">
                    <input type="password" name="password" id="id_password" class="required" placeholder="Password" />
                </div>
                <div class="actions clearfix">
                    <input type="submit" value="登录" id="submit" class="btn btn-success" />
                </div>
                <div id="bar" class="round_bottom">
                    <label><input type="checkbox" id="rememberMe" name="rememberMe">记住密码</label>
                    <label><a href="${ctx}/">找回密码</a></label>
                </div>
            </form:form>
        </div>
    </div>
</div>
<script src="${ctx}/static/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script>
    $(function() {
        $("#loginForm").validate();
        $(".alert").delay(1500).fadeOut("slow");
    });
</script>
</body>
</html>