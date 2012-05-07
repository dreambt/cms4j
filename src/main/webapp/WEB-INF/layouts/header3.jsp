<%--
  Header模块
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-18
  Time: 下午5:09
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!-- BEGIN HEADER -->
<div class="row-fluid">
    <div id="top-header">
        <div class="logo"><img src="${ctx}/static/images/logo.jpg" style="vertical-align:middle;margin-right: 10px;margin-bottom:15px;"/><h1>山东省金融信息工程技术研究中心</h1></div>
    </div>
    <div class="navbar-inner"></div>
    <div class="bottom-header container">
        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span> </a>
        <div id="nav-menu" class="nav-collapse">
            <ul class="sf-menu nav">
                <li><a href="${ctx}/">首页</a></li>
                <c:forEach items="${categories}" var="category" begin="0" step="1">
                    <c:choose>
                        <c:when test="${category.showType eq 'NONE'}"><li><a href="${ctx}/${category.url}">${category.categoryName}</a></c:when>
                        <c:when test="${category.showType eq 'LIST'}"><li><a href="${ctx}/article/list/${category.id}">${category.categoryName}</a></c:when>
                        <c:when test="${category.showType eq 'DIGEST'}"><li><a href="${ctx}/article/digest/${category.id}">${category.categoryName}</a></c:when>
                        <c:when test="${category.showType eq 'GALLERY'}"><li><a href="${ctx}/gallery/photo/${category.url}">${category.categoryName}</a></c:when>
                        <c:when test="${category.showType eq 'ALBUM'}"><li><a href="${ctx}/gallery/album/${category.url}">${category.categoryName}</a></c:when>
                        <c:when test="${category.showType eq 'CONTENT'}"><li><a href="${ctx}/article/content/${category.url}">${category.categoryName}</a></c:when>
                        <c:when test="${category.showType eq 'FULL'}"><li><a href="${ctx}/article/content/full/${category.url}">${category.categoryName}</a></c:when>
                        <c:when test="${category.showType eq 'LINK'}"><li><a href="${category.url}">${category.categoryName}</a></c:when>
                    </c:choose>
                    <c:if test="${fn:length(category.subCategories) > 0}">
                        <ul>
                            <c:forEach items="${category.subCategories}" var="subCategory" begin="0" step="1">
                                <c:choose>
                                    <c:when test="${subCategory.showType eq 'NONE'}"><li><a href="${ctx}/${subCategory.url}">${subCategory.categoryName}</a></li></c:when>
                                    <c:when test="${subCategory.showType eq 'LIST'}"><li><a href="${ctx}/article/list/${subCategory.id}">${subCategory.categoryName}</a></li></c:when>
                                    <c:when test="${subCategory.showType eq 'DIGEST'}"><li><a href="${ctx}/article/digest/${subCategory.id}">${subCategory.categoryName}</a></li></c:when>
                                    <c:when test="${subCategory.showType eq 'GALLERY'}"><li><a href="${ctx}/gallery/photo/${subCategory.url}">${subCategory.categoryName}</a></li></c:when>
                                    <c:when test="${subCategory.showType eq 'ALBUM'}"><li><a href="${ctx}/gallery/album/${subCategory.url}">${subCategory.categoryName}</a></li></c:when>
                                    <c:when test="${subCategory.showType eq 'CONTENT'}"><li><a href="${ctx}/article/content/${subCategory.url}">${subCategory.categoryName}</a></c:when>
                                    <c:when test="${subCategory.showType eq 'FULL'}"><li><a href="${ctx}/article/content/full/${subCategory.url}">${subCategory.categoryName}</a></c:when>
                                    <c:when test="${subCategory.showType eq 'LINK'}"><li><a href="${subCategory.url}">${subCategory.categoryName}</a></c:when>
                                </c:choose>
                            </c:forEach>
                        </ul>
                    </c:if>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function(){
        $("ul.sf-menu li:first").css('border-left','none');
    });
</script>
<!-- END OF HEADER -->