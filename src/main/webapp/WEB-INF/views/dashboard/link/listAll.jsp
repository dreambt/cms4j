<%--
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-4-8
  Time: 下午12:36
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>友情管理列表</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-validation/1.9.0/validate.min.css">
    <script type="text/javascript" src="${ctx}/static/jquery-validation/1.9.0/jquery.validate.min.js"
            charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/jquery-validation/1.9.0/messages_cn.js" charset="utf-8"></script>
</head>

<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_10">
        <h2>友情管理列表</h2>
        <p>下面列出了所有友情链接, 您可以对友情链接进行 <strong>修改</strong><strong>删除</strong>.点击链接名称或URL可以直接进入相应的网站.</p>
        <c:if test="${not empty info}">
            <div id="message" class="alert alert_blue">
                <img height="24" width="24"
                     src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>${info}</strong>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div id="message" class="alert alert_red">
                <img height="24" width="24"
                     src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>${error}</strong>
            </div>
        </c:if>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <form action="${ctx}/link/batchDelete" id="LnkList" method="post">
        <div class="box grid_16 round_all">
            <table class="display table">
                <thead>
                <tr>
                    <th>选择</th>
                    <th>名称</th>
                    <th>URL</th>
                    <th>创建时间</th>
                    <th>最后修改</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${links}" var="link" begin="0" step="1">
                    <tr>
                        <td><input type="checkbox" name="isSelected" value="${link.id}"></td>
                        <td><a href="${link.title}">${link.title}</a></td>
                        <td><a href="${link.url}">${link.url}</a></td>
                        <td><fmt:formatDate value="${link.createTime}" type="both"></fmt:formatDate></td>
                        <td><fmt:formatDate value="${link.modifyTime}" type="both"></fmt:formatDate></td>
                        <td><a href="${ctx}/link/edit/${link.id}">【修改】</a>
                            <a href="${ctx}/link/delete/${link.id}"><c:choose><c:when test="${!link.deleted}">【删除】</c:when><c:otherwise>【恢复】</c:otherwise></c:choose></a></td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
        <button class="button_colour" id="deleteAll"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/BendedArrowRight.png"/>
            <span>批量删除</span>
        </button>
    </form>
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