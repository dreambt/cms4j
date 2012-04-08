<%--
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-4-8
  Time: 下午12:36
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>添加友情链接</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-validation/1.9.0/validate.min.css">
    <script type="text/javascript" src="${ctx}/static/jquery-validation/1.9.0/jquery.validate.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/jquery-validation/1.9.0/messages_cn.js" charset="utf-8"></script>
</head>

<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_10">
        <h2>添加友情链接</h2>
        <p>aaaaaaaaaaaaaaaa</p>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <form:form modelAttribute="link" name="linkForm" action="${ctx}/link/save/${link.id}" id="LnkAdd">
        <div class="box gird_16">
            <h2 class="box_head grad_colour round_top">链接信息</h2>
            <div class="toggle_container">
                <div class="block">
                    <input type="hidden" name="isSelected" value="${link.id}"/>
                    <label for="lnkName" class="field">链接名称: </label><input id="lnkName" name="title" class="required" size="40" value="${link.title}"/><br />
                    <label for="URL" class="field">URL: </label><input id="URL" name="url" class="required" size="40" value="${link.url}" /><br />
                </div>
            </div>
        </div>
        <button type="submit" id="create"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/User2.png"><span>保存</span></button>
    </form:form>
</div>
<script>
    $(function () {
        $("#lnkName").focus();
        $("#LnkAdd").validate({
            rules:{lnkName:{required:true},
                URL:{required:true}
            }
        });
    });
</script>
</body>
</html>