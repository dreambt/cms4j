<%--
  后台模版的首页装饰器
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-21
  Time: 下午3:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <!-- iPhone, iPad and Android specific settings -->
    <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1;">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"/>
    <!-- Create an icon and splash screen for iPhone and iPad -->
    <link rel="apple-touch-icon" href="${ctx}/static/dashboard/images/iOS_icon.png">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/dashboard/css/all.css" media="screen">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/dashboard/CMS-dashboard.css" media="screen">
    <!--[if IE 6]><link rel="stylesheet" type="text/css" href="${ctx}/static/dashboard/css/ie6.css" media="screen"/><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" type="text/css" href="${ctx}/static/dashboard/css/ie.css" media="screen"/><![endif]-->
    <script type="text/javascript" src="${ctx}/static/jquery/1.7.1/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/jquery/jquery-ui.min.js"></script>
    <!-- Load Interface Plugins -->
    <script type="text/javascript" src="${ctx}/static/js/uniform/jquery.uniform.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/js/tipsy/jquery.tipsy.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/jquery/jquery.iphoneui.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/jquery.fancybox.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/jqueryFileTree/jqueryFileTree.js"></script>
    <script type="text/javascript" src="${ctx}/static/jquery/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/dashboard/js/slidernav/slidernav.js"></script>

    <!-- This file configures the various jQuery plugins for Adminica. Contains links to help pages for each plugin.-->
    <script type="text/javascript" src="${ctx}/static/dashboard/js/adminica_ui.js"></script>
    <title>CMS后台管理系统<sitemesh:title/></title>
    <sitemesh:head/>
</head>
<body>
<div id="wrapper">
    <%@include file="sidebar.jsp" %>
    <sitemesh:body/>
</div>
</body>
</html>