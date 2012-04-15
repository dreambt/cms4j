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
<div id="header">
    <div id="top-header">
        <div class="logo"><a href="index.html"><img src="${ctx}/static/images/logo.jpg" alt="" style="vertical-align:middle;margin-right: 10px;margin-bottom: 5px;" class="cufon" /><h1 class="cufon">山东省金融信息技术研究中心</h1></a></div>
    </div>
    <div id="bottom-header">
        <div id="nav-menu">
            <ul class="sf-menu">
                <li><a href="${ctx}/" class="cufon">首页</a></li>
                <c:forEach items="${categories}" var="category" begin="0" step="1">
                    <c:choose>
                        <c:when test="${category.showType eq 'NONE'}"><li><a href="${ctx}/${category.url}" class="cufon">${category.categoryName}</a></c:when>
                        <c:when test="${category.showType eq 'LIST'}"><li><a href="${ctx}/article/list/${category.id}" class="cufon">${category.categoryName}</a></c:when>
                        <c:when test="${category.showType eq 'DIGEST'}"><li><a href="${ctx}/article/digest/${category.id}" class="cufon">${category.categoryName}</a></c:when>
                        <c:when test="${category.showType eq 'GALLERY'}"><li><a href="${ctx}/gallery/photo/${category.url}" class="cufon">${category.categoryName}</a></c:when>
                        <c:when test="${category.showType eq 'ALBUM'}"><li><a href="${ctx}/gallery/album/${category.url}" class="cufon">${category.categoryName}</a></c:when>
                        <c:when test="${category.showType eq 'CONTENT'}"><li><a href="${ctx}/article/content/${category.url}" class="cufon">${category.categoryName}</a></c:when>
                        <c:when test="${category.showType eq 'FULL'}"><li><a href="${ctx}/article/content/full/${category.url}" class="cufon">${category.categoryName}</a></c:when>
                    </c:choose>
                    <c:if test="${fn:length(category.subCategories) > 0}">
                        <ul>
                            <c:forEach items="${category.subCategories}" var="subCategory" begin="0" step="1">
                                <c:choose>
                                    <c:when test="${subCategory.showType eq 'NONE'}"><li><a href="${ctx}/${subCategory.url}" class="cufon">${subCategory.categoryName}</a></li></c:when>
                                    <c:when test="${subCategory.showType eq 'LIST'}"><li><a href="${ctx}/article/list/${subCategory.id}" class="cufon">${subCategory.categoryName}</a></li></c:when>
                                    <c:when test="${subCategory.showType eq 'DIGEST'}"><li><a href="${ctx}/article/digest/${subCategory.id}" class="cufon">${subCategory.categoryName}</a></li></c:when>
                                    <c:when test="${subCategory.showType eq 'GALLERY'}"><li><a href="${ctx}/gallery/photo/${subCategory.url}" class="cufon">${subCategory.categoryName}</a></li></c:when>
                                    <c:when test="${subCategory.showType eq 'ALBUM'}"><li><a href="${ctx}/gallery/album/${subCategory.url}" class="cufon">${subCategory.categoryName}</a></li></c:when>
                                    <c:when test="${subCategory.showType eq 'CONTENT'}"><li><a href="${ctx}/article/content/${subCategory.url}" class="cufon">${subCategory.categoryName}</a></c:when>
                                    <c:when test="${subCategory.showType eq 'FULL'}"><li><a href="${ctx}/article/content/full/${subCategoryao.url}" class="cufon">${subCategory.categoryName}</a></c:when>
                                </c:choose>
                            </c:forEach>
                        </ul>
                    </c:if>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <!-- end of nav -->

    </div>
    <!-- end of nav -->
<script type="text/javascript">
    $(function(){
       $("ul.sf-menu li:first").css('border-left','none');
    });
</script>
</div>
<!-- END OF HEADER -->