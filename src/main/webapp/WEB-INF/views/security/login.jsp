<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta name="robots" content="none"/>
    <!-- iPhone, iPad and Android specific settings -->
    <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1;">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"/>
    <title>后台登录</title>
    <link rel="shortcut icon" href="${ctx}/static/favicon.ico" type="image/x-icon" />
    <!-- Create an icon and splash screen for iPhone and iPad -->
    <link rel="apple-touch-icon" href="images/iOS_icon.png">
    <link rel="apple-touch-startup-image" href="images/iOS_startup.png">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/dashboard/css/reset.css" media="screen">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/dashboard/css/text.css" media="screen">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/dashboard/css/main.css" media="screen">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/dashboard/css/theme/theme_base.css" media="screen">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/dashboard/css/buttons.css" media="screen">
    <!--[if IE 6]><link rel="stylesheet" type="text/css" href="${ctx}/static/dashboard/css/ie6.css" media="screen"/><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" type="text/css" href="${ctx}/static/dashboard/css/ie.css" media="screen"/><![endif]-->
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/jquery-validation/validate.css" />
    <script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
    <!--[if (gte IE 6)&(lte IE 8)]><script type="text/javascript" src="${ctx}/static/js/selectivizr.js"></script><![endif]-->
    <script type="text/javascript" src="${ctx}/static/js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/uniform/jquery.uniform.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/js/tipsy/jquery.tipsy.js"  charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/jquery/jquery.iphoneui.js"  charset="utf-8"></script>
    <script src="${ctx}/static/js/jquery-validation/jquery.validate.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/jquery-validation/messages_cn.js" type="text/javascript"></script>
</head>
<body>
<div id="login_box" class="round_all clearfix">
    <form:form id="loginForm" action="${ctx}/login" method="post">
        <%
            String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
            if(error != null){
                if(error.contains("DisabledAccountException")){
        %>
        <div id="message" class="alert alert_red">
            <img height="24" width="24" src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>用户已被屏蔽,请登录其他用户.</strong>
        </div>
        <%
        }else{
        %>
        <div id="message" class="alert alert_red">
            <img height="24" width="24" src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>登录失败，请重试.</strong>
        </div>
        <%
                }
            }
        %>
        <label class="fields"><strong>用户名</strong><input type="text" id="username" name="username" value="${username}" class="indent round_all required email2 email"></label>
        <label class="fields"><strong>密码</strong><input type="password" id="password" name="password" class="indent round_all required"></label>
        <button type="submit" class="button_colour round_all"><img width="24" height="24" src="${ctx}/static/dashboard/images/icons/Locked2.png"><span> 登  录</span></button>
        <div id="bar" class="round_bottom">
            <label><input type="checkbox" id="rememberMe" name="rememberMe">记住密码</label>
            <label><a href="${ctx}/">找回密码</a></label>
        </div>
    </form:form>
    <a href="${ctx}" id="login_logo"><span>CMS4j</span></a>
    <script>
        $(function() {
            $("#loginForm").validate();
            $(".alert").delay(1500).fadeOut("slow");
        });
    </script>
</div>
</body>
</html>