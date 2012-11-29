<%--
   菜单管理
  User: baitao.jibt@gmail.com
  Date: 12-8-25
  Time: 下午21:24
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>菜单管理</title>
</head>
<body>
<div class="row">
    <div class="span12">
    <form:form id="categoryForm">
        <div class="accordion" id="accordion2">
            <c:forEach items="${categories}" var="category" begin="0" step="1">
            <div class="accordion-group">
                <div class="accordion-heading">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse${category.id}">${category.categoryName} [子菜单: ${fn:length(category.subCategories)} | 显示顺序: ${category.displayOrder}]</a>
                </div>
                <div id="collapse${category.id}" class="accordion-body collapse">
                    <div class="accordion-inner">
                        <h5><a href="${ctx}/">${category.categoryName}</a> <a href="${ctx}/category/update/${category.id}"><span>【修改】</span></a> <a href="${ctx}/category/delete/${category.id}"><span>【删除】</span></a></h5>
                        <c:if test="${fn:length(category.subCategories) > 0}">
                        <table class="table table-hover">
                            <thead>
                            <tr>
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
                                    <td><c:choose><c:when test="${subCategory.allowComment}"><i class="icon-ok"></i></c:when><c:otherwise><i class="icon-remove"></i></c:otherwise></c:choose></td>
                                    <td><c:choose><c:when test="${subCategory.allowPublish}"><i class="icon-ok"></i></c:when><c:otherwise><i class="icon-remove"></i></c:otherwise></c:choose></td>
                                    <td><c:forEach items="${showTypes}" var="showType" begin="0" step="1"><c:if test="${showType.value==subCategory.showType.value}">${showType.displayName}</c:if></c:forEach></td>
                                    <td><a href="${ctx}/category/update/${subCategory.id}" type="submit">修改</a> <a href="${ctx}/category/delete/${subCategory.id}" type="submit" class="delete">删除</a></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        </c:if>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
    </form:form>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $("#category_page").addClass("active");
        $('.delete').click(function(){
            if(confirm("确定要删除吗？")){
                return true;
            } else{
                return false;
            }
        });
    });
</script>
</body>
</html>