<%--
  查看友情链接
  User: baitao.jibt@gmail.com
  Date: 12-8-25
  Time: 下午21:25
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>友情链接列表</title>
</head>
<body>
<div class="row">
    <div class="span12">
        <form action="${ctx}/link/batchDelete" id="LnkList" method="post">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>选择</th>
                    <th>名称</th>
                    <th>URL</th>
                    <th>类别</th>
                    <th>创建时间</th>
                    <th>最后修改</th>
                    <th>审核状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${links}" var="link" begin="0" step="1">
                    <tr>
                        <td><input type="checkbox" name="isSelected" value="${link.id}"></td>
                        <td><a href="${link.url}" target="_blank">${link.title}</a></td>
                        <td><a href="${link.url}" target="_blank" >${link.url}</a></td>
                        <td><c:forEach items="${linkCategories}" var="linkCategory" begin="0" step="1"><c:if test="${linkCategory.value==link.category}">${linkCategory.displayName}</c:if></c:forEach></td>
                        <td><fmt:formatDate value="${link.createdDate}" type="both"></fmt:formatDate></td>
                        <td><fmt:formatDate value="${link.lastModifiedDate}" type="both"></fmt:formatDate></td>
                        <td><a href="${ctx}/link/audit/${link.id}"><c:choose><c:when test="${link.status}"><span class="green_text">已审核</span></c:when><c:otherwise><span class="red_text">未审核</span></c:otherwise></c:choose></a></td>
                        <td><a href="${ctx}/link/edit/${link.id}">【修改】</a> <a href="${ctx}/link/delete/${link.id}">【删除】</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="control-group">
                <div class="controls">
                    <button class="btn btn-primary" id="auditAll"><i class="icon-flag icon-white"></i> 批量审核</button>
                    <button class="btn btn-primary" id="deleteAll"><i class="icon-remove icon-white"></i> 批量删除</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    $(function () {
        $('#deleteAll').click(function () {
            if (confirm("确定批量删除吗？")) {
                //$("#articleForm").attr("action", "${ctx}/link/deleteAll").submit();
            } else {
                return false;
            }
        });
    });
</script>
</body>
</html>