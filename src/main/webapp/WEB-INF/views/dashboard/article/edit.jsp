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
</head>
<body>
<div class="row">
    <div class="span12">
    <form:form id="articleForm" class="form-inline" modelAttribute="article" action="${ctx}/article/${action}" method="post">
        <input type="hidden" name="id" value="${article.id}"/>
        <form:select path="category.id" cssClass="input-medium">
        <c:forEach items="${categories}" begin="0" step="1" var="categorie" varStatus="stat">
            <option value="${categorie.id}" <c:if test="${categorie.id eq article.category.id}">selected="selected"</c:if>>${categorie.categoryName}</option>
        </c:forEach>
        </form:select>
        <input type="text" id="text" name="subject" class="medium required" size="206" original-title="请输入文章标题" value="${article.subject}" placeholder="文章标题" />
        <label class="checkbox">
            <input type="checkbox" name="top" value="${article.top}" <c:if test="${article.top}">checked="checked"</c:if> /> 置顶
            <input type="hidden" name="_top">
        </label>
        <label class="checkbox">
            <input type="checkbox" name="allowComment" value="true" <c:if test="${article.allowComment}">checked="checked"</c:if> /> 允许评论
            <input type="hidden" name="_allowComment">
        </label>
        <textarea id="editor_id" name="message" style="width:960px;height:540px;visibility:hidden;">${article.message}</textarea>
        <div class="control-group">
            <div class="controls">
                <button class="btn btn-primary" id="publish" type="submit"><i class="icon-ok icon-white"></i> 发 布</button>
                <button class="btn" type="reset"><i class="icon-refresh"></i> 草 稿</button>
            </div>
        </div>
    </form:form>
    </div>
</div>
<script charset="utf-8" src="${ctx}/static/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="${ctx}/static/kindeditor/lang/zh_CN.js"></script>
<script>
    $(function () {
        $("#article_page").addClass("active");
    });
    KindEditor.ready(function(K) {
        K.create('#editor_id', {
            uploadJson : '/jsp/upload_json.jsp',
            fileManagerJson : '/jsp/file_manager_json.jsp',
            allowFileManager : true
        });
    });
</script>
</body>
</html>