<%--
   后台用户管理
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-24
  Time: 上午10:39
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>用户管理 - 后台管理</title>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>用户管理</h2>
        <p>您可以在左边选择现有用户进行管理, 添加新用户请点击 <a href="${ctx}/account/user/list"><strong>添加新用户</strong></a>.</p>
        <div id="messageBox" class="error" style="display:none">输入有误，请先更正。</div>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <div class="box clearfix grid_6">
        <h2 class="box_head grad_colour round_top">用户列表</h2>
        <div id="slider_list">
            <div class="slider-content">
                <ul>
                    <li id="a"><a name="a" class="title">A</a>
                        <ul>
                            <c:forEach items="${users}" var="user" begin="0" step="1" varStatus="stat">
                            <li><a class="sliderClick" value="${user.id}">${user.username}</a></li>
                            </c:forEach>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="flat_area grid_10">
        <h2>用户信息</h2>
        <form:form id="userInfo" modelAttribute="user" action="${ctx}/account/user/save/${user.id}" method="post">
            <img id="profile" alt="头像" src="${ctx}/static/uploads/Avatar/default.jpg"/>
            <input type="hidden" id="user_id" name="id" value="${user.id}"/>
            <ul>
                <li><label for="email" class="field">邮  箱: </label><input id="email" name="email" value="${user.email}" class="input_info"> <img id="emailstatus" src="${ctx}/static/images/clear.gif" /></li>
                <li><label for="username" class="field">用户名: </label><input id="username" name="username" value="${user.username}" class="input_info"></li>
                <li><label class="field">用户组: </label><form:checkboxes path="groupList" items="${allGroups}" itemLabel="groupName" itemValue="id" /></li>
                <li><label class="field">用户注册时间: </label><span id="regtime"><fmt:formatDate value="${user.createTime}" type="both"/></span></li>
                <li><label class="field">最后登录时间: </label><span id="lasttime">${user.lastActTime}</span></li>
                <li><label class="field">最后登录 IP : </label><span id="lastip">${user.lastLoginIP}</span></li>
                <li><label class="field">最后修改时间: </label><span id="lastmodefied">${user.modifyTime}</span></li>
                <li>
                    <button type="submit" id="create"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/small/white/User2.png"><span>创建用户</span></button>
                    <button type="submit" id="modify"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/small/white/Listw_Image.png"><span>保存</span></button>
                    <button type="submit" id="audit"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/small/white/Listw_Image.png"><span>审核</span></button>
                    <button type="submit" id="delete"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/small/white/LoadingBar.png"><span>删除用户</span></button>
                    <button type="submit" id="repass"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/small/white/Refresh.png"><span>重置密码</span></button>
                </li>
            </ul>
        </form:form>
    </div>
</div>
<script type="text/javascript">
    function ChangeDateFormat(cellval) {
        var date = new Date(parseInt(cellval + 3600000, 10));
        var month = date.getMonth() + 1;
        var currentDate = date.getDate();
        return date.getFullYear() + "-" + month + "-" + currentDate;
    }

    $(function () {
        $('#create').hide();
        $('#audit').hide();
        $('#delete').hide();
        $('#repass').hide();

        // 创建用户
        $('#create').click(function () {
            $("#userInfo").attr("action", "${ctx}/account/user/list").submit();
        });

        // 选择用户
        $('.sliderClick').click(function () {
            $('#create').show();
            $('#audit').show();
            $('#delete').show();
            $('#repass').show();
            $('#groupList1').attr("checked", true);
            var user_id = $(this).attr('value');
            $.ajax({
                url:"${ctx}/account/user/get?id=" + user_id,
                timeout:3000,
                success:function (data) {
                    $('#profile').attr("src", "${ctx}/static/uploads/Avatar/" + data.photoURL);
                    $('#email').attr("value", data.email);
                    $('#username').attr("value", data.username);
                    $('#regip').text(data.registerIP);
                    $('#regtime').text(ChangeDateFormat(data.createTime));
                    $('#lastip').text(data.lastLoginIP);
                    $('#lasttime').text(ChangeDateFormat(data.lastTime));
                    $('#lastmodefied').text(ChangeDateFormat(data.modifyTime));

                    if(data.emailStatus)
                        $('#emailstatus').attr("src","${ctx}/static/jquery-validation/1.9.0/images/checked.gif");
                    else
                        $('#emailstatus').attr("src", "${ctx}/static/jquery-validation/1.9.0/images/unchecked.gif");

                    if (data.status) {
                        $('#audit').show().text("反审核");
                    }
                    else {
                        $('#audit').show().text("审核");
                    }

                    // 多选框
                    $.each(data.groupList, function (index, content) {
                        $('#groupList' + content.id).attr("checked", true);
                    });

                    $('#create').remove();
                },
                error:function (xmlHttpRequest, error) {
                    console.log(xmlHttpRequest, error);
                }
            });
        });
    });
</script>
</body>
</html>