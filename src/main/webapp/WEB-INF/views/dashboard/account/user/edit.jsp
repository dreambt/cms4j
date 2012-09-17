<%--
  个人设置
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-26
  Time: 下午8:28
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户设置</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/validation/validate.min.css">
</head>
<body>
<div class="row">
    <div class="span12">
    <form:form id="userInfo" modelAttribute="user" action="${ctx}/account/user/${action}" method="post" cssClass="form-horizontal">
        <div class="control-group">
            <label class="control-label" for="email">邮  箱</label>
            <div class="controls">
                <input type="hidden" id="user_id" name="id" value="${user.id}"/>
                <c:choose><c:when test="${user.id > 0}">${user.email}</c:when><c:otherwise><input id="email" name="email" class="required email" size="40" placeholder="Email" /></c:otherwise></c:choose>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="username">用户名</label>
            <div class="controls">
                <input id="username" name="username" class="required" size="40" minlength="2" value="${user.username}" placeholder="用户名" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">用户组</label>
            <div class="controls">
                <c:forEach var="group" items="${allGroups}">
                    <label class="checkbox inline">
                        <form:radiobutton path="groupList" value="${group.id}" /> ${group.groupName}
                    </label>
                </c:forEach>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <button class="btn btn-primary" id="publish" type="submit"><i class="icon-ok icon-white"></i> 确 定</button>
                <button class="btn" type="reset"><i class="icon-refresh"></i> 重 置</button>
            </div>
        </div>
    </form:form>
    </div>
</div>
<script type="text/javascript" src="${ctx}/min?t=js&f=/js/validation/jquery.validate.js,/js/validation/messages_cn.js" charset="utf-8"></script>
<script>
    $(function () {
        $("#email").focus();
        $("#userInfo").validate({
            rules:{email:{required:true, email:true, maxlength:40, remote:"${ctx}/account/user/checkEmail?oldEmail=" + encodeURIComponent('${user.email}')},
                username:{required:true, maxlength:40},
                groupList:"required"}
        });
    });
</script>
</body>
</html>