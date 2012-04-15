<%--
   后台菜单管理管理
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-24
  Time: 上午10:39
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>菜单管理 - 后台管理</title>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>菜单管理</h2>
        <p>这里可以管理 <strong>顶级菜单</strong> 和相应的 <strong>二级菜单</strong> .</p>
        <p>点击二级菜单的名称将跳转到与其相关的文章列表，点击其url将跳转到相应的文章/文章列表/文章摘要的预览页面。在需要进行删除操作时，非空的菜单是不能删除的，这时您得先全部删除与其相关的文章或子菜单!</p>
        <c:if test="${not empty info}">
            <div id="message" class="alert alert_blue">
                <img height="24" width="24" src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>${info}</strong>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div id="message" class="alert alert_red">
                <img height="24" width="24" src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>${error}</strong>
            </div>
        </c:if>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <form:form id="categoryForm">
    <div class="box grid_16">
        <h2 class="box_head grad_colour">顶级菜单</h2>
        <a href="#" class="grabber">&nbsp;</a>
        <a href="#" class="toggle">&nbsp;</a>
        <div class="toggle_container">
            <ul class="block content_accordion">
                <c:forEach items="${categories}" var="category" begin="0" step="1">
                    <li>
                        <h3 class="bar" id="1" title="点击展开"><a href="${ctx}/">${category.categoryName}</a> [${fn:length(category.subCategories)}]&nbsp;顺序：${category.displayOrder}&nbsp;<a class="amodify" href="${ctx}/category/edit/${category.id}"><span>【修改】</span></a>
                            <a class="amodify delete" href="${ctx}/category/delete/${category.id}"><span>【删除】</span></a></h3>
                        <c:if test="${fn:length(category.subCategories) > 0}">
                            <div class="content">
                                    <table class="display menu_sec">
                                        <thead>
                                        <tr class="box-head grad_colour">
                                            <th>名称</th>
                                            <th>显示顺序</th>
                                            <th>Url</th>
                                            <th>允许评论</th>
                                            <th>允许发表</th>
                                            <th>显示类型</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${category.subCategories}" var="subCategory" begin="0" step="1">
                                            <tr>
                                                <td><a href="${ctx}/article/listByCategory/${subCategory.id}">${subCategory.categoryName}</a></td>
                                                <td>${subCategory.displayOrder}</td>
                                                <td><a href="${ctx}/${subCategory.url}" target="_blank">${subCategory.url}</a></td>
                                                <td><c:choose><c:when test="${subCategory.allowComment}"><img src="${ctx}/static/dashboard/images/success.png"/></c:when><c:otherwise><img  src="${ctx}/static/dashboard/images/error.png"/></c:otherwise></c:choose></td>
                                                <td><c:choose><c:when test="${subCategory.allowPublish}"><img src="${ctx}/static/dashboard/images/success.png"/></c:when><c:otherwise><img src="${ctx}/static/dashboard/images/error.png"/></c:otherwise></c:choose></td>
                                                <td><c:forEach items="${showTypes}" var="showType" begin="0" step="1"><c:if test="${showType.value==subCategory.showType.value}">${showType.displayName}</c:if></c:forEach>
                                                </td>
                                                <td><a href="${ctx}/category/edit/${subCategory.id}" type="submit">【修改】</a> <a href="${ctx}/category/delete/${subCategory.id}" type="submit" class="delete">【删除】</a></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                            </div>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    </form:form>
</div>
<script type="text/javascript">
    $('.delete').click(function(){
        if(confirm("确定要删除吗？")){
            return true;
        } else{
            return false;
        }
    });
</script>
</body>
</html>