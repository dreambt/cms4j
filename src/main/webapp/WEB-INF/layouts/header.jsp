<%--
  Header模块
  User: baitao.jibt@gmail.com
  Date: 12-8-24
  Time: 下午15:42
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!-- 页眉 -->
<div class="row">
<div class="span12">
    <div id="top-header">
        <div class="logo"><a href="${ctx}"><img src="${ctx}/static/images/logo.jpg" alt="" style="vertical-align:middle;margin-right: 10px;margin-bottom:0px;" /><h1>山东省金融信息工程技术研究中心</h1></a></div>
    </div>
    <div class="navbar">
        <div class="navbar-inner">
            <ul class="nav" role="navigation">
                <li class="active"><a href="${ctx}/">首页</a></li>
                <c:forEach items="${categories}" var="category" begin="0" step="1" varStatus="stauts">
                    <c:choose>
                        <c:when test="${category.showType eq 'NONE'}"><li class="dropdown"><a id="drop${stauts.index}" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a></c:when>
                        <c:when test="${category.showType eq 'LIST'}"><li class="dropdown"><a id="drop${stauts.index}" href="${ctx}/article/list/${category.id}" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a></c:when>
                        <c:when test="${category.showType eq 'DIGEST'}"><li class="dropdown"><a id="drop${stauts.index}" href="${ctx}/article/digest/${category.id}" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a></c:when>
                        <c:when test="${category.showType eq 'GALLERY'}"><li class="dropdown"><a id="drop${stauts.index}" href="${ctx}/gallery/photo/${category.url}" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a></c:when>
                        <c:when test="${category.showType eq 'ALBUM'}"><li class="dropdown"><a id="drop${stauts.index}" href="${ctx}/gallery/album/${category.url}" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a></c:when>
                        <c:when test="${category.showType eq 'CONTENT'}"><li class="dropdown"><a id="drop${stauts.index}" href="${ctx}/article/${category.url}" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a></c:when>
                        <c:when test="${category.showType eq 'FULL'}"><li class="dropdown"><a id="drop${stauts.index}" href="${ctx}/article/full/${category.url}" role="button" class="dropdown-toggle" data-toggle="dropdown">${category.categoryName} <b class="caret"></b></a></c:when>
                        <c:when test="${category.showType eq 'LINK'}"><li><a href="${category.url}" role="button">${category.categoryName}</a></li></c:when>
                    </c:choose>
                    <c:if test="${fn:length(category.subCategories) > 0}">
                        <ul class="dropdown-menu" role="menu" aria-labelledby="drop${stauts.index}">
                            <c:forEach items="${category.subCategories}" var="subCategory" begin="0" step="1">
                            <c:choose>
                            <c:when test="${subCategory.showType eq 'NONE'}"><li><a tabindex="-1" href="${ctx}/${subCategory.url}">${subCategory.categoryName}</a></li></c:when>
                            <c:when test="${subCategory.showType eq 'LIST'}"><li><a tabindex="-1" href="${ctx}/article/list/${subCategory.id}">${subCategory.categoryName}</a></li></c:when>
                            <c:when test="${subCategory.showType eq 'DIGEST'}"><li><a tabindex="-1" href="${ctx}/article/digest/${subCategory.id}">${subCategory.categoryName}</a></li></c:when>
                            <c:when test="${subCategory.showType eq 'GALLERY'}"><li><a tabindex="-1" href="${ctx}/gallery/photo/${subCategory.url}">${subCategory.categoryName}</a></li></c:when>
                            <c:when test="${subCategory.showType eq 'ALBUM'}"><li><a tabindex="-1" href="${ctx}/gallery/album/${subCategory.url}">${subCategory.categoryName}</a></li></c:when>
                            <c:when test="${subCategory.showType eq 'CONTENT'}"><li><a tabindex="-1" href="${ctx}/article/${subCategory.url}">${subCategory.categoryName}</a></li></c:when>
                            <c:when test="${subCategory.showType eq 'FULL'}"><li><a tabindex="-1" href="${ctx}/article/full/${subCategory.url}">${subCategory.categoryName}</a></li></c:when>
                            <c:when test="${subCategory.showType eq 'LINK'}"><li><a tabindex="-1" href="${subCategory.url}">${subCategory.categoryName}</a></li></c:when>
                            </c:choose>
                            </c:forEach>
                        </ul>
                    </c:if>
                    </li>
                </c:forEach>
            </ul>
            <form name="s" class="form-search">
                <input type="text" class="input-medium search-query" id="q" name="wd" autocomplete="on" value="Search"
                       onblur="if (this.value == ''){this.value = 'Search'; }"
                       onfocus="if (this.value == 'Search') {this.value = ''; }">&nbsp;<input type="image" class="go" onclick="window.open('http://www.google.com.hk/search?q='+s.wd.value,'')" src="${ctx}/static/images/search-icon.gif"/>
            </form>
        </div>
    </div>
</div>
</div>