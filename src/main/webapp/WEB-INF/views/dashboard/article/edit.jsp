<%--
  编辑文章
  User: baitao.jibt@gmail.com
  Date: 12-8-27
  Time: 上午9:21
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>编辑文章</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/jquery-validation/validate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/markitup/style.min.css">
</head>
<body>
<div class="row">
    <div class="span12">
    <form:form id="articleForm" class="form-inline" modelAttribute="article" action="${ctx}/article/save/${article.id}" method="post">
        <input type="hidden" name="article.id" value="${article.id}"/>
        <form:select path="category.id" cssClass="input-medium">
        <c:forEach items="${categories}" begin="0" step="1" var="categorie" varStatus="stat">
            <option value="${categorie.id}" <c:if test="${categorie.id eq article.category.id}">selected="selected"</c:if>>${categorie.categoryName}</option>
        </c:forEach>
        </form:select>
        <input type="text" id="text" name="subject" class="medium required" size="206" original-title="请输入文章标题" value="${article.subject}" placeholder="文章标题" />
        <label class="checkbox">
            <input type="checkbox" name="top" value="${article.top}" <c:if test="${article.top}">checked="checked"</c:if> /> 置顶
        </label>
        <label class="checkbox">
            <input type="checkbox" name="allowComment" value="true" <c:if test="${article.allowComment}">checked="checked"</c:if> /> 允许评论
        </label>
        <textarea id="markdown" name="message" cols="80" rows="20">${article.message}</textarea>
        <div class="control-group">
            <div class="controls">
                <button class="btn btn-primary" id="publish" type="submit"><i class="icon-ok icon-white"></i> 发 布</button>
                <button class="btn" type="reset"><i class="icon-refresh"></i> 草 稿</button>
            </div>
        </div>
    </form:form>
    </div>
</div>
<script type="text/javascript" src="${ctx}/static/js/jquery.loading.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery.json-2.3.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/markitup/jquery.markitup.js"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-validation/jquery.validate.min.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-validation/messages_cn.js" charset="utf-8"></script>
<script type="text/javascript">
    $(function () {
        $('#markdown').markItUp(myMarkdownSettings);

        $("#articleForm").validate({
            event:'submit',
            rules:{subject:{required:true, maxlength:26}}
        });
    });
</script>
</body>
</html>