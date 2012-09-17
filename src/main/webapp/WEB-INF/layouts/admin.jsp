<%--
  后台模板
  User: baitao.jibt@gmail.com
  Date: 12-8-24
  Time: 下午15:51
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset='utf-8'>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta http-equiv="Cache-Control" content="no-store"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <meta name="robots" content="index, follow"/>
    <meta name="keywords" content=""/>
    <meta name="title" content=""/>
    <meta name="description" content=""/>
    <title><sitemesh:title/> - 后台管理</title>
    <link rel="shortcut icon" href="${ctx}/static/favicon.ico" type="image/x-icon" />
    <link href="${ctx}/min?t=css&f=/style/bootstrap.css,/style/bootstrap-responsive.css,/js/msgUI/msgGrowl.css,/style/admin.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/min?t=js&f=/js/jquery.js,/js/bootstrap.js,/js/msgUI/msgGrowl.js,/js/main.js" type="text/javascript"></script>
    <sitemesh:head/>
</head>
<body data-spy="scroll" data-target=".bs-docs-sidebar">
<!-- 顶部导航栏 -->
<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">
            <div class="nav-collapse collapse">
                <ul class="nav">
                    <li><a href="${ctx}/dashboard/index">后台首页</a>
                    </li>
                    <shiro:hasPermission name="article:list">
                        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">文章管理 <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="${ctx}/article/create">发表文章</a></li>
                                <li><a href="${ctx}/article/listAll">文章列表</a></li>
                                <li><a href="${ctx}/attachment/list">附件管理</a></li>
                            </ul>
                        </li>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="category:list">
                        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">菜单管理 <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="${ctx}/category/create">添加菜单</a></li>
                                <li><a href="${ctx}/category/listAll">菜单列表</a></li>
                            </ul>
                        </li>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="gallery:list">
                        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">相册管理 <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="${ctx}/gallery/create">上传图片</a></li>
                                <li><a href="${ctx}/gallery/listAll">图片列表</a></li>
                            </ul>
                        </li>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="user:list">
                        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">用户管理 <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="${ctx}/account/user/create">添加用户</a></li>
                                <li><a href="${ctx}/account/user/list">用户列表</a></li>
                            </ul>
                        </li>
                    </shiro:hasPermission>
                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">机构管理 <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="${ctx}/agency/create">添加机构</a></li>
                            <li><a href="${ctx}/agency/listAll">机构列表</a></li>
                        </ul>
                    </li>
                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">教师管理 <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="${ctx}/teacher/create">添加教师</a></li>
                            <li><a href="${ctx}/teacher/listAll">教师列表</a></li>
                        </ul>
                    </li>
                    <shiro:hasPermission name="link:list">
                        <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">友情链接 <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="${ctx}/link/create">添加友情链接</a></li>
                                <li><a href="${ctx}/link/listAll">友情链接列表</a></li>
                            </ul>
                        </li>
                    </shiro:hasPermission>
                    <li><a href="${ctx}/index">返回网站首页</a>
                </ul>
            </div>
        </div>
    </div>
</div>
<header class="jumbotron subhead" id="overview">
    <div class="container">
        <h1><sitemesh:title/></h1>
        <p class="lead">开源地址：<a href="http://dreambt.github.com/cms4j">http://dreambt.github.com/cms4j</a></p>
    </div>
</header>
<div class="container">
    <sitemesh:body/>
    <%@ include file="/WEB-INF/layouts/footer.jsp" %>
</div>
</body>
</html>