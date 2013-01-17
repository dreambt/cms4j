<%--
  侧边栏
  User: baitao.jibt@gmail.com
  Date: 12-8-24
  Time: 下午16:18
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div class="span3">
<c:if test="${fn:length(categories) > 0}">
    <div class="well sidebar-nav">
        <ul class="nav nav-list">
            <li class="nav-header">相关分类</li>
	    <c:forEach items="${categories}" var="category" begin="0" step="1" varStatus="stauts">
                <c:choose>
                    <c:when test="${category.showType eq 'NONE'}"><li><a href="#">${category.categoryName}</a></c:when>
                    <c:when test="${category.showType eq 'LIST'}"><li><a href="${ctx}/article/list/${category.id}">${category.categoryName}</a></c:when>
                    <c:when test="${category.showType eq 'DIGEST'}"><li><a href="${ctx}/article/digest/${category.id}">${category.categoryName}</a></c:when>
                    <c:when test="${category.showType eq 'GALLERY'}"><li><a href="${ctx}/gallery/photo/${category.url}">${category.categoryName}</a></c:when>
                    <c:when test="${category.showType eq 'CONTENT'}"><li><a href="${ctx}/article/${category.url}">${category.categoryName}</a></c:when>
                    <c:when test="${category.showType eq 'FULL'}"><li><a href="${ctx}/article/full/${category.url}">${category.categoryName}</a></c:when>
                    <c:when test="${category.showType eq 'LINK'}"><li><a href="${category.url}" role="button">${category.categoryName}</a></li></c:when>
                </c:choose>
                </li>
            </c:forEach>
        </ul>
    </div>
    </c:if>
    <div class="well sidebar-nav">
        <ul class="nav nav-list">
            <li class="nav-header">最新文章</li>
            <c:forEach items="${newArticles}" var="newArticle" begin="0" step="1">
                <li><a href="${ctx}/article/${newArticle.id}">${fn:substring(newArticle.subject,0,18)}<c:if test="${fn:length(newArticle.subject)>18}">...</c:if></a></li>
            </c:forEach>
        </ul>
    </div>
    <div class="well sidebar-nav">
        <ul class="nav nav-list">
            <li class="nav-header">存档分类</li>
            <c:forEach items="${archives}" var="archive" begin="0" step="1" end="10">
                <li><a href="${ctx}/archive/list/${archive.id}">${archive.title}&nbsp;(${archive.count})</a></li>
            </c:forEach>
            <li><a href="${ctx}/archive/list">更多存档...</a></li>
        </ul>
    </div>
</div>