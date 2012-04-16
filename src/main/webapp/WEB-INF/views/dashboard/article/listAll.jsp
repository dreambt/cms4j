<%--
  查看所有文章
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-24
  Time: 下午11:32
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
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>文章列表</h2>
        <p>下面列出了所有文章列表, 您可以对文章进行 <strong>修改</strong> <strong>置顶</strong> <strong>审核</strong> 和 <strong>删除</strong>.</p>
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
    <form:form modelAttribute="article" id="articleForm" method="post">
        <div class="box grid_16 round_all">
            <table class="display table">
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
        </div>
        <button class="button_colour" id="auditAll"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/BendedArrowRight.png"/><span>批量审核</span></button>
        <button class="button_colour" id="deleteAll"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/BendedArrowRight.png"/><span>批量删除</span></button>
    </form:form>
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