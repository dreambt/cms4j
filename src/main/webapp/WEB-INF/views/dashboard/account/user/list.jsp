<%--
  查看所有用户
  User: baitao.jibt@gmail.com
  Date: 12-4-3
  Time: 下午15:32
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户列表</title>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>用户列表</h2>

        <p>下面列出了所有用户, 您可以对用户进行 <strong>修改</strong> <strong>重置密码</strong> <strong>审核</strong> 和 <strong>删除</strong>.</p>
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
    <form:form modelAttribute="article" id="articleForm" method="post">
        <div class="box grid_16 round_all">
            <table class="display table">
                <thead>
                <tr>
                    <th>选择</th>
                    <th>用户名</th>
                    <th>邮箱</th>
                    <th>用户组</th>
                    <th>创建时间</th>
                    <th>最后登录时间</th>
                    <th>最后登录IP</th>
                    <th>审核</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="user" begin="0" step="1" varStatus="stat">
                    <tr class="gradeA">
                        <td><input type="checkbox" name="isSelected" value="${user.id}"></td>
                        <td>${user.username}</td>
                        <td>${user.email} <c:choose><c:when test="${user.emailStatus}"><img
                                src="${ctx}/static/jquery-validation/1.9.0/images/checked.gif"/></c:when><c:otherwise><img
                                src="${ctx}/static/jquery-validation/1.9.0/images/unchecked.gif"/></c:otherwise></c:choose>
                        </td>
                        <td><c:forEach items="${user.groupList}" begin="0" step="1" var="group">${group.groupName} </c:forEach></td>
                        <td><fmt:formatDate value="${user.createTime}" type="both"/></td>
                        <td><fmt:formatDate value="${user.lastTime}" type="both"/></td>
                        <td>${user.lastLoginIP}</td>
                        <td><a href="${ctx}/account/user/audit/${user.id}"><c:choose><c:when test="${user.status}">【已审核】</c:when><c:otherwise>【未审核】</c:otherwise></c:choose></a></td>
                        <td>${article.deleted}<a href="${ctx}/account/user/repass/${user.id}">【密码找回】</a> <a href="${ctx}/account/user/edit/${user.id}">【编辑】</a> <a href="${ctx}/account/user/delete/${user.id}"><c:choose><c:when test="${article.deleted}">【恢复】</c:when><c:otherwise>【删除】</c:otherwise></c:choose></a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <button class="button_colour" id="auditAll"><img height="24" width="24" alt="Bended Arrow Right"
                                                         src="${ctx}/static/dashboard/images/icons/BendedArrowRight.png"/><span>批量审核</span>
        </button>
        <button class="button_colour" id="deleteAll"><img height="24" width="24" alt="Bended Arrow Right"
                                                          src="${ctx}/static/dashboard/images/icons/BendedArrowRight.png"/><span>批量删除</span>
        </button>
    </form:form>
</div>
<script>
    $(function () {
        $(".alert").delay(1500).fadeOut("slow");

        $('#auditAll').click(function () {
            if (confirm("确定批量审核吗？")) {
                $("#articleForm").attr("action", "${ctx}/account/user/auditAll").submit();
            } else {
                return false;
            }
        });

        $('#deleteAll').click(function () {
            if (confirm("确定批量删除吗？")) {
                $("#articleForm").attr("action", "${ctx}/account/user/deleteAll").submit();
            } else {
                return false;
            }
        });
    });
</script>
</body>
</html>