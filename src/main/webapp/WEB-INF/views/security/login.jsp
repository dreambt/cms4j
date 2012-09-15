<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>后台登录</title>
</head>
<body>
<div class="row">
    <div class="span6 offset3">
        <div id="login" class="accounts-form">
            <h2>用户登录</h2>
            <hr class="small" />
            <%
                String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
                if(error != null){
                    if(error.contains("DisabledAccountException")){
            %>
            <div id="message" class="alert alert_red">
                用户已被屏蔽,请登录其他用户.
            </div>
            <%
            }else{
            %>
            <div id="message" class="alert alert_red">
                登录失败，请重试.
            </div>
            <%
                    }
                }
            %>
            <form:form id="loginForm" action="${ctx}/login" method="post" cssClass="form-horizontal">
                <input type='hidden' name='csrfmiddlewaretoken' value='c1b1696edcea586856677cc78ad76833' />
                <div class="control-group">
                    <label class="control-label" for="inputEmail">邮箱</label>
                    <div class="controls">
                        <input type="text" id="inputEmail" name="username" maxlength="75" value="${username}" class="required email input-large" placeholder="Email">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputPassword">密码</label>
                    <div class="controls">
                        <input type="password" id="inputPassword" name="password" maxlength="75" class="required input-large" placeholder="Password">
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <label class="checkbox">
                            <input type="checkbox" id="rememberMe" name="rememberMe"> 记住密码
                        </label>
                        <button type="submit" class="btn btn-primary">登录</button>
                        <button type="submit" class="btn">找回密码</button>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>
<script src="${ctx}/static/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script>
    $(function() {
        $(".login-page").addClass("active");
        $("#loginForm").validate();
        $(".alert").delay(1500).fadeOut("slow");
    });
</script>
</body>
</html>