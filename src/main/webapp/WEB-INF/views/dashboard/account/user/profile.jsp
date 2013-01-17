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
    <title>个人资料</title>
</head>
<body>
<div class="row">
    <form:form id="userInfo" name="userInfo" modelAttribute="user" action="${ctx}/account/user/profile" method="post" cssClass="form-horizontal">
    <div class="span6">
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
            <label class="control-label" for="groupName">用户组</label>
            <div class="controls">
                <input type="text" id="groupName" name="groupNames" value="${user.groupNames}" disabled="disabled" />
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <button class="btn btn-primary" id="publish" type="submit"><i class="icon-ok icon-white"></i> 确 定</button>
                <button class="btn" type="reset"><i class="icon-refresh"></i> 重 置</button>
            </div>
        </div>
    </div>
    <div class="span6">
        <div class="control-group">
            <label class="control-label" for="oldPassword">原密码</label>
            <div class="controls">
                <input type="text" id="oldPassword" name="oldPassword" class="input-large" placeholder="Old Password" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="newPassword">新密码</label>
            <div class="controls">
                <input type="text" id="newPassword" name="newPassword" class="input-large" placeholder="New Password" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="confirmPassword">确认密码</label>
            <div class="controls">
                <input type="text" id="confirmPassword" name="confirmPassword" class="input-large" placeholder="Confirm Password" equalTo="#newPassword" />
            </div>
        </div>
    </div>
    </form:form>
</div>
<script>
    $(function () {
        $("#user_page").addClass("active");
        $("#email").focus();
        $("#userInfo").validate({
            rules:{email:{required:true, email:true, maxlength:40, remote:"${ctx}/account/user/checkEmail?oldEmail=" + encodeURIComponent('${user.email}')},
                username:{required:true, maxlength:40}
                }
        });
    });
</script>
</body>
</html>