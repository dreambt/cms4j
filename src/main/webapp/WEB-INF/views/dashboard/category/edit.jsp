<%--
   添加菜单
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-27
  Time: 下午3:07
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>菜单管理 - 添加菜单</title>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>添加菜单</h2>

        <p>请认真按照要求填写菜单信息</p>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <form:form id="category" modelAttribute="category" action="${ctx}/category/save/${category.id}" method="post">
        <div class="box gird_16">
            <h2 class="box_head grad_colour round_top">添加&修改菜单</h2>

            <div class="toggle_container">
                <div class="block">

                    <input type="hidden" name="id" value="${category.id}">
                    <input type="hidden" name="id" value="${category.fatherCategoryId}">
                    <label class="menuLbl">菜单名:</label><input name="categoryName" type="text"
                                                              value="${category.categoryName}">
                    <label class="menuLbl">URL:</label><input name="url" type="text" value="${category.url}">
                    <label class="menuLbl">显示顺序:</label><input name="displayOrder" type="text"
                                                               value="${category.displayOrder}"><br>
                    <strong>父级菜单</strong>
                    <select name="fatherCategoryId">
                        <option value="1" <c:if test="${category.fatherCategoryId==1}">selected="selected"</c:if>>无
                        </option>
                        <c:forEach items="${fatherCategories}" var="fatherCategory" begin="0" step="1">
                            <option value="${fatherCategory.id}"
                                    <c:if test="${fatherCategory.id==category.fatherCategoryId}">selected="selected"</c:if>>${fatherCategory.categoryName}</option>
                        </c:forEach>
                    </select><br><br>
                    <strong>显示类型</strong>
                    <form:select path="showType" items="${showTypes}" itemLabel="displayName"
                                 itemValue="value"></form:select>
                        <%--<select name="showType">--%>
                        <%--<c:forEach items="${showTypes}" var="showType" begin="0" step="1" >--%>
                        <%--<option value="${showType.value}" <c:if test="${showType.value==category.showType.value}">selected="selected"</c:if>>${showType.displayName}</option>--%>
                        <%--</c:forEach>--%>
                        <%--</select> <br><br>--%>
                    <strong>允许评论</strong>
                    <input name="allowComment" type="checkbox" class="menuLbl"
                           <c:if test="${category.allowComment==true}">checked="checked"</c:if> >
                    <strong>允许发表</strong>
                    <input name="allowPublish" type="checkbox" class="menuLbl"
                           <c:if test="${category.allowPublish==true}">checked="checked"</c:if>><br><br>
                    <label class="menuLbl">描述信息:</label><br>
                    <textarea name="description" style="width:530px" cols="30"
                              rows="50">${category.description}</textarea>

                </div>
            </div>
        </div>
        <button type="submit" class="button_colour"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/Listw_Image.png"><span>提交</span>
        </button>
    </form:form>
</div>
</body>
</html>