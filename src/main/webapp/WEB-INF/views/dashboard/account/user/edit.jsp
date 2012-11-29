<%--
  User: baitao.jibt@gmail.com
  Date: 12-8-27
  Time: 上午11:39
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springside.org.cn/tags/form" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户设置</title>
</head>
<body>
<div class="row">
    <div class="span12">
    <form:form id="userInfo" name="userInfo" modelAttribute="user" action="${ctx}/account/user/${action}" method="post" cssClass="form-horizontal">
        <div class="control-group">
            <label class="control-label" for="email">邮  箱</label>
            <div class="controls">
                <input type="hidden" id="user_id" name="id" value="${user.id}"/>
                <input type="text" id="email" name="email" value="${user.email}" placeholder="Email" class="input-large required" <c:if test="${action eq 'update'}"> disabled="disabled"</c:if>/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="username">用户名</label>
            <div class="controls">
                <input type="text" id="username" name="username" value="${user.username}" class="input-large required" placeholder="用户名" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="groupList">用户组</label>
            <div class="controls">
                <form:bsradiobuttons path="groupList" items="${allGroups}" itemLabel="groupName" itemValue="id" />
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
<script>
    $(function () {
        $("#user_page").addClass("active");
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