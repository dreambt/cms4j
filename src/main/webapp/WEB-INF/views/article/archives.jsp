<%--
 归档列表
  User: baitao.jibt@gmail.com
  Date: 12-8-25
  Time: 下午16:37
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>存档分类</title>
</head>
<body>
<!-- 导航 -->
<div class="row">
    <div class="span13">
        <ul class="breadcrumb">
            <li><a href="#">首页</a> <span class="divider">/</span></li>
            <li>存档</li>
        </ul>
    </div>
</div>
<!-- 存档列表 -->
<div class="row">
    <!-- 左边 -->
    <div class="span9">
        <!-- 列表 -->
        <ul id="article_load" class="nav nav-tabs nav-stacked">
            <c:forEach items="${archives}" var="archive" begin="0" step="1" >
                <li><a href="${ctx}/archive/list/${archive.id}"> ${archive.title}&nbsp;(${archive.count})</a></li>
            </c:forEach>
        </ul>
    </div>
    <!-- 边栏 -->
    <%@include file="/WEB-INF/layouts/sidebar.jsp" %>
</div>
</body>
</html>