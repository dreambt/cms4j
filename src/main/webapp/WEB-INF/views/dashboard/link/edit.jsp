<%--
  User: baitao.jibt@gmail.com
  Date: 12-8-27
  Time: 上午11:39
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>友情链接</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/validation/validate.min.css">
</head>
<body>
<div class="row">
    <div class="span12">
    <form:form modelAttribute="link" name="linkForm" action="${ctx}/link/${action}" id="LnkAdd" cssClass="form-horizontal">
        <div class="control-group">
            <label class="control-label" for="lnkName">链接名称</label>
            <div class="controls">
                <input type="hidden" name="id" value="${link.id}"/>
                <input type="text" id="lnkName" name="title" placeholder="${link.title}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="URL">URL</label>
            <div class="controls">
                <input type="text" id="URL" name="url" placeholder="${link.url}">
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
        $("#link_page").addClass("active");
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