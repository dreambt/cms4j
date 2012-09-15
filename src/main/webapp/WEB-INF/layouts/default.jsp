<%--
  默认模板
  User: baitao.jibt@gmail.com
  Date: 12-8-24
  Time: 下午15:51
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <title><sitemesh:title/> - 山东省金融信息工程技术研究中心</title>
    <link rel="shortcut icon" href="${ctx}/static/favicon.ico" type="image/x-icon" />
    <link href="${ctx}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/style/main.min.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/static/js/jquery.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/main.min.js" type="text/javascript"></script>
    <sitemesh:head/>
</head>
<body>
<div class="container">
    <%@ include file="/static/layouts/menu.html" %>
    <sitemesh:body/>
    <%@ include file="/static/layouts/link.html" %>
    <%@ include file="/WEB-INF/layouts/footer.jsp" %>
</div>
<c:if test="${not empty info}">
    <div class="tips alert alert-info fade in">
        <button type="button" class="close" data-dismiss="alert">×</button>
        <h4>提示!</h4>
            ${info}
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="tips alert alert-error fade in">
        <button type="button" class="close" data-dismiss="alert">×</button>
        <h4>出错啦!</h4>
            ${error}
    </div>
</c:if>
<script src="${ctx}/static/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
</body>
</html>