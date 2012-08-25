<%--
  查看所有文章
  User: baitao.jibt@gmail.com
  Date: 12-8-25
  Time: 下午20:32
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>文章列表</title>
</head>
<body>
<div class="row">
    <div class="span12">
        <form:form modelAttribute="article" id="articleForm" method="post">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>选择</th>
                    <th>标题</th>
                    <th>作者</th>
                    <th>类别</th>
                    <th>评分</th>
                    <th>浏览</th>
                    <th>创建时间</th>
                    <th>最后修改</th>
                    <th>审核状态</th>
                    <th>评论</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${articles}" var="article" begin="0" step="1" varStatus="stat">
                    <tr class="gradeA">
                        <td><input type="checkbox" name="isSelected" value="${article.id}"></td>
                        <td><a href="${ctx}/article/content/${article.id}" target="_blank">${article.subject}</a></td>
                        <td>${article.user.username}</td>
                        <td>${article.category.categoryName}</td>
                        <td>${article.rate}</td>
                        <td>${article.views}</td>
                        <td><fmt:formatDate value="${article.createdDate}" type="date"/></td>
                        <td><fmt:formatDate value="${article.lastModifiedDate}" type="date"/></td>
                        <td><a href="${ctx}/article/audit/${article.id}"><c:choose><c:when test="${article.status}"><span class="green_text">已审核</span></c:when><c:otherwise><span class="red_text">未审核</span></c:otherwise></c:choose></a></td>
                        <td><a href="${ctx}/article/allow/${article.id}"><c:choose><c:when test="${article.allowComment}">允许</c:when><c:otherwise>不允许</c:otherwise></c:choose></a></td>
                        <td><a href="${ctx}/article/edit/${article.id}">【编辑】</a><a href="${ctx}/article/top/${article.id}"><c:choose><c:when test="${article.top}">【置顶】</c:when><c:otherwise>【未置顶】</c:otherwise></c:choose></a>
                            <a href="${ctx}/article/delete/${article.id}"><c:choose><c:when test="${article.deleted}">【恢复】</c:when><c:otherwise>【删除】</c:otherwise></c:choose></a></td>
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
        </form:form>
    </div>
</div>
<script>
    $(function () {
        $(".alert").delay(1500).fadeOut("slow");

        $('#auditAll').click(function () {
            if (confirm("确定批量审核吗？")) {
                $("#articleForm").attr("action", "${ctx}/article/auditAll").submit();
            } else {
                return false;
            }
        });
        $('#deleteAll').click(function () {
            if (confirm("确定批量删除吗？")) {
                $("#articleForm").attr("action", "${ctx}/article/deleteAll").submit();
            } else {
                return false;
            }
        });
    });
</script>
</body>
</html>