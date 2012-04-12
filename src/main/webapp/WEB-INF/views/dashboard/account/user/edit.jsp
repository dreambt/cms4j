<%--
  个人设置
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-26
  Time: 下午8:28
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户设置</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-validation/1.9.0/validate.min.css">
    <script type="text/javascript" src="${ctx}/static/jquery-validation/1.9.0/jquery.validate.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/jquery-validation/1.9.0/messages_cn.js" charset="utf-8"></script>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>用户设置</h2>
        <p>用户注册后，登录密码将发送到 <strong>注册邮箱</strong> , 请及时通知用户修改密码.</p>
    </div>
</div>
<div class="main_container container_16 clearfix">
<form:form id="userInfo" modelAttribute="user" action="${ctx}/account/user/save/${user.id}" method="post">
    <div class="box gird_16">
        <h2 class="box_head grad_colour round_top">用户信息</h2>
        <div class="toggle_container">
            <div class="block">
            <input type="hidden" id="user_id" name="id" value="${user.id}"/>
            <label for="email" class="field">邮  箱: </label><c:choose><c:when test="${user.id > 0}">${user.email}</c:when><c:otherwise><input id="email" name="email" class="required email" size="40" /></c:otherwise></c:choose><br />
            <label for="username" class="field">用户名: </label><input id="username" name="username" class="required" size="40" minlength="2" value="${user.username}" /><br />
            <label class="field">用户组: </label><form:radiobuttons path="groupList" items="${allGroups}" itemLabel="groupName" itemValue="id" />
            </div>
        </div>
    </div>
    <button type="submit" id="create"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/User2.png"><span>保存修改</span></button>
</form:form>
</div>
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