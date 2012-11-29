<%--
   添加菜单
  User: baitao.jibt@gmail.com
  Date: 12-8-27
  Time: 下午14:58
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>添加菜单</title>
</head>
<body>
<div class="row">
    <form:form id="categoryForm" modelAttribute="category" action="${ctx}/category/${action}" method="post" cssClass="form-horizontal">
    <div class="span4">
        <div class="control-group">
            <label class="control-label" for="fatherCategoryId">父级菜单</label>
            <div class="controls">
                <input type="hidden" name="id" value="${category.id}">
                <input type="hidden" name="fid" value="${category.fatherCategoryId}">
                <select id="fatherCategoryId" name="fatherCategoryId">
                    <option value="1" <c:if test="${category.fatherCategoryId==1}">selected="selected"</c:if>>无</option>
                    <c:forEach items="${fatherCategories}" var="fatherCategory" begin="0" step="1">
                        <option value="${fatherCategory.id}"
                                <c:if test="${fatherCategory.id==category.fatherCategoryId}">selected="selected"</c:if>>${fatherCategory.categoryName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="categoryName">菜单名</label>
            <div class="controls">
                <input type="text" id="categoryName" name="categoryName" value="${category.categoryName}" placeholder="${category.categoryName}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="url">URL</label>
            <div class="controls">
                <input type="text" id="url" name="url" value="${category.url}" placeholder="${category.url}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="displayOrder">显示顺序</label>
            <div class="controls">
                <input type="text" id="displayOrder" name="displayOrder" value="${category.displayOrder}" placeholder="${category.displayOrder}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">显示类型</label>
            <div class="controls">
                <form:select path="showType" items="${showTypes}" itemLabel="displayName" itemValue="value"></form:select>
            </div>
        </div>
    </div>
    <div class="span8">
        <div class="control-group">
            <label class="control-label" for="allowComment">可选项</label>
            <div class="controls">
                作为导航 <input type="checkbox" id="showNav" name="showNav" <c:if test="${category.showNav==true}">checked="checked"</c:if>>
                允许评论 <input type="checkbox" id="allowComment" name="allowComment" <c:if test="${category.allowComment==true}">checked="checked"</c:if>>
                允许发表 <input type="checkbox" id="allowPublish" name="allowPublish" <c:if test="${category.allowPublish==true}">checked="checked"</c:if>>
                <input type="hidden" name="_showNav"/>
                <input type="hidden" name="_allowComment"/>
                <input type="hidden" name="_allowPublish"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="editor_id">描述信息</label>
            <div class="controls">
                <textarea id="editor_id" name="description" style="width:700px;height:450px;">${category.description}</textarea>
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
<script charset="utf-8" src="${ctx}/static/kindeditor/kindeditor-all-min.js"></script>
<script charset="utf-8" src="${ctx}/static/kindeditor/lang/zh_CN.js"></script>
<script>
    $(function () {
        $("#category_page").addClass("active");
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