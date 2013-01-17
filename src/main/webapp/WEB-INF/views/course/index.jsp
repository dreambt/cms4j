<%--
  文章摘要模式
  User: baitao.jibt@gmail.com
  Date: 12-8-24
  Time: 下午20:52
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>${category.categoryName}</title>
</head>
<body>
<!-- 左边栏 -->
<%@include file="/WEB-INF/layouts/sidebar.jsp" %>
<div class="index_right">
    <div class="blog-header">
        ${category.categoryName}
    </div>
    ${category.description}
    <c:forEach items="${categories}" var="category" begin="0" step="1" varStatus="stat">
        <c:choose>
            <c:when test="${category.showType eq 'COURSE'}">
                <div class="right2 fl">
                    <div class="title">
                        <h2 class="b f14 fl"><a href="${ctx}/course/list" title="${category.categoryName}">${category.categoryName}</a></h2>
                        <div class="fr" style="height:28px"><a href="${ctx}/course/list" target="_blank"><img src="${ctx}/static/images/more.gif" target="_blank" height="28" width="54"></a></div>
                    </div>
                    <div class="right2_1">
                        <c:forEach items="${courses}" var="item" begin="0" step="1">
                            <div class="thumbnail" style="margin:0 5px 10px 5px;clear:both;">
                                <div class="caption">
                                    <h5 style="margin:0"><a href="${ctx}/article/${item.id}" title="${item.courseName}"><c:if test="${item.top}"><img src="${ctx}/static/images/top.gif" /></c:if>${fn:substring(item.courseName,0,23)}<c:if test="${fn:length(item.courseName)>23}">...</c:if></a></h5>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:when>
            <c:when test="${category.showType eq 'FREE'}">
                <div class="right2 fl">
                    <div class="title">
                        <h2 class="b f14 fl"><a href="${ctx}/course/list" title="${category.categoryName}">${category.categoryName}</a></h2>
                        <div class="fr" style="height:28px"><a href="${ctx}/course/list" target="_blank"><img src="${ctx}/static/images/more.gif" target="_blank" height="28" width="54"></a></div>
                    </div>
                    <div class="right2_1">
                        <c:forEach items="${freeCourses}" var="item" begin="0" step="1">
                            <div class="thumbnail" style="margin:0 5px 10px 5px;clear:both;">
                                <div class="caption">
                                    <h5 style="margin:0"><a href="${ctx}/article/${item.id}" title="${item.courseName}"><c:if test="${item.top}"><img src="${ctx}/static/images/top.gif" /></c:if>${fn:substring(item.courseName,0,23)}<c:if test="${fn:length(item.courseName)>23}">...</c:if></a></h5>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="right2 fl">
                    <div class="title">
                        <h2 class="b f14 fl"><a href="${ctx}/article/list/${category.id}" title="${category.categoryName}">${category.categoryName}</a></h2>
                        <div class="fr" style="height:28px"><a href="${ctx}/article/list/${category.id}" target="_blank"><img src="${ctx}/static/images/more.gif" target="_blank" height="28" width="54"></a></div>
                    </div>
                    <div class="right2_1">
                        <c:forEach items="${category.articleList}" var="item" begin="0" step="1">
                            <div class="thumbnail" style="margin-bottom:10px;clear:both;">
                                <img src="${ctx}/static/uploads/image-thumb/${item.imageName}" alt="" class="imgleft" width="134px" height="134px"/>
                                <div class="caption">
                                    <h5 style="margin:0"><a href="${ctx}/article/${item.id}" title="${item.subject}"><c:if test="${item.top}"><img src="${ctx}/static/images/top.gif" /></c:if>${fn:substring(item.subject,0,23)}<c:if test="${fn:length(item.subject)>23}">...</c:if></a></h5>
                                    <p>${item.digest}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</div>
</body>
</html>