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
    <div class="well">
        <ul class="nav nav-list">
            <li class="nav-header">搜索文章</li>
        </ul>
        <form class="form-search">
            <input type="text" class="input-medium search-query" id="s" value="Search"
                   onblur="if (this.value == ''){this.value = 'Search'; }"
                   onfocus="if (this.value == 'Search') {this.value = ''; }">&nbsp;<input type="image" class="go" src="${ctx}/static/images/search-icon.gif"/>
        </form>
    </div>
    <div class="well sidebar-nav">
        <ul class="nav nav-list">
            <li class="nav-header">最新文章</li>
            <c:forEach items="${newArticles}" var="newArticle" begin="0" step="1">
                <li><a href="${ctx}/article/content/${newArticle.id}">${fn:substring(newArticle.subject,0,16)}<c:if
                        test="${fn:length(newArticle.subject)>16}">...</c:if></a></li>
            </c:forEach>
            <li class="nav-header">存档分类</li>
            <c:forEach items="${archives}" var="archive" begin="0" step="1" end="10">
                <li><a href="${ctx}/archive/list/${archive.id}">${archive.title}&nbsp;(${archive.count})</a></li>
            </c:forEach>
            <li><a href="${ctx}/archive/list">更多存档...</a></li>
        </ul>
    </div>
</div>