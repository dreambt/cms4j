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
    <title>个人设置</title>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>个人设置</h2>

        <p>Try it out and you'll see how <strong>powerful yet easy to use</strong> it is.</p>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <form action="#" id="userInfo">
    <div class="flat_area grid_10">
        <h2>个人信息列表</h2>
            <ul>
                <li><img alt="头像" src="${ctx}/static/dashboard/images/profile.jpg"/></li>
                <li> 用户名：<input name="name" value="Adam" class="input_info"></li>
                <li>用户邮箱：<input name="name" value="admin" class="input_info"></li>
                <li>用户组：<select>
                    <option value="前台管理员">前台管理员</option>
                    <option value="编辑">编辑</option>
                    <option value="后台管理员">后台管理员</option>
                </select></li>
                <li> 已验证：<input type="checkbox" readonly="yes"></li>
                <li> 用户名：<input name="name" value="admin" class="input_info"></li>
                <li>注册时间：<input name="name" value="admin" class="input_info" readonly="yes"></li>
                <li>最后登录时间：<input name="name" value="admin" class="input_info" readonly="yes"></li>
                <li>最后修改信息时间：<input name="name" value="admin" class="input_info" readonly="yes"></li>
                <li>最后登录IP：<input name="name" value="admin" class="input_info" readonly="yes"></li>
            </ul>
    </div>
    <button type="submit" value="修改">修改资料</button>
    </form>
</div>
</body>
</html>