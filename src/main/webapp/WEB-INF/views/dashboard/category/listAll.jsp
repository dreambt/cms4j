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
    <title>显示所有菜单 - 后台管理</title>
</head>

<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>显示所有菜单</h2>

        <p>Try it out and you'll see how <strong>powerful yet easy to use</strong> it is.</p>
    </div>
</div>
<div class="main_container container_16 clearfix fullsize">
    <div class="box grid_16">
        <h2 class="box_head grad_colour">
            一级菜单
        </h2>
        <a href="#" class="grabber">&nbsp;</a>
        <a href="#" class="toggle">&nbsp;</a>

        <div class="toggle_container">
            <ul class="block content_accordion">
                <c:forEach items="${categories}" var="category" begin="0" step="1">
                    <li>
                        <form>
                            <a href="#" class="handle">&nbsp;</a>
                            <input id="Mname" type="text" name="name" value="${category.categoryName}" readonly="yes" class="menu">
                            <button type="submit"><a class="amodify" href="${ctx}/category/edit/${category.id}">修改</a></button>
                            <button id="d" class="deleteSingle" type="submit"><span><a class="amodify" href="${ctx}/category/delete/${category.id}">删除</a></span></button>
                        </form>
                        <h3 class="bar" id="1" title="${category.displayOrder+1}">
                            &nbsp;&nbsp;&nbsp;子菜单数量：${fn:length(category.subCategories)}
                        </h3>
                        <c:if test="${fn:length(category.subCategories) > 0}">
                            <div class="content">
                                <form action="#">
                                    <table class="display menu_sec">
                                        <thead>
                                        <tr class="box-head grad_colour">
                                            <th>名称</th>
                                            <th>显示顺序</th>
                                            <th>Url</th>
                                            <th>允许评论</th>
                                            <th>作为导航</th>
                                            <th>允许发表</th>
                                            <th>显示类型</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${category.subCategories}" var="subCategory" begin="0" step="1">
                                            <tr>
                                                <td>
                                                    <input type="text" name="categoryName" value="${subCategory.categoryName}" class="menu">
                                                </td>
                                                <td>
                                                    <input type="text" name="displayOrder" value="${subCategory.displayOrder}" class="menu">
                                                </td>
                                                <td>
                                                    <input type="text" name="url" size="20px" class="menu" value="${subCategory.url}">
                                                </td>
                                                <td>
                                                    <input type="checkbox" name="allowComment" class="menu" <c:if test="${subCategory.allowComment}">checked="checked"</c:if>>
                                                </td>
                                                <td>
                                                    <input type="checkbox" class="menu" name="allowPublish" <c:if test="${subCategory.allowPublish}">checked="checked"</c:if>>
                                                </td>
                                                <td>
                                                    <select name="showType">
                                                        <c:forEach items="${showTypes}" var="showType" begin="0" step="1" >
                                                            <option value="${showType.value}" <c:if test="${showType.value==subCategory.showType.value}">selected="selected"</c:if>>${showType.displayName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </td>
                                                <td>
                                                    <a href="${ctx}/category/edit/${subCategory.id}" type="submit">【修改】</a>
                                                    <a href="${ctx}/category/delete/${subCategory.id}" type="submit">【删除】</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </form>

                            </div>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
