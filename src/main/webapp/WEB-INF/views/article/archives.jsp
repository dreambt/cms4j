<%--
 归档列表
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-4-2
  Time: 下午1:49
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>存档分类</title>
</head>
<body>
<!-- BEGIN PAGE TITLE -->
<div id="page-title">
    <div class="title"><!-- your title page -->
        <h2>存档分类</h2>
    </div>
    <div class="desc"></div>
</div>
<!-- END OF PAGE TITLE -->
<div id="content-inner">
    <!-- BEGIN CONTENT -->
    <div id="content-left">
        <div class="maincontent" id="article_load">
            <ul id="documentA">
                <c:forEach items="${archives}" var="archive" begin="0" step="1" >
                    <li><a href="${ctx}/archive/list/${archive.id}"> ${archive.title}&nbsp;(${archive.articleCount})</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <!--sidebox-->
    <%@include file="/WEB-INF/layouts/sidebar.jsp" %>
</div>
</body>
</html>