<%--
  编辑文章
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-24
  Time: 上午10:40
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>编辑文章</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/Ueditor/themes/default/ueditor.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-validation/1.9.0/validate.min.css">
    <script type="text/javascript" src="${ctx}/static/Ueditor/editor_config.js"></script>
    <script type="text/javascript" src="${ctx}/static/Ueditor/editor_all.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/tipsy/jquery.tipsy.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/jquery-validation/1.9.0/jquery.validate.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/jquery-validation/1.9.0/messages_cn.js" charset="utf-8"></script>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>编辑文章</h2>
        <p>请选择 <strong>文章分类</strong> <strong>是否置顶</strong> <strong>是否允许评论</strong> , 并填写 <strong>文章标题</strong> 和 <strong>文章内容</strong>.</p>
        <P><strong>请您注意：</strong>发表文章时插入的图片宽度超过612像素，系统会自动以图片长宽比例将其缩小到宽度为612像素！</P>
        <c:if test="${not empty info}">
            <div id="message" class="alert alert_blue">
                <img height="24" width="24" src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>${info}</strong>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div id="message" class="alert alert_red">
                <img height="24" width="24" src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>${error}</strong>
            </div>
        </c:if>
    </div>
</div>
<div class="main_container container_16 clearfix">
<form:form id="articleForm" modelAttribute="article" action="${ctx}/article/save/${article.id}" method="post">
<div class="box gird_16">
    <h2 class="box_head grad_colour round_top">编辑文章</h2>
    <div class="toggle_container">
        <div class="block">
        <input type="hidden" name="article.id" value="${article.id}"/>
        <label>文章分类</label> <form:select path="category.id">
        <c:forEach items="${categories}" begin="0" step="1" var="categorie" varStatus="stat">
            <option value="${categorie.id}" <c:if test="${categorie.id eq article.category.id}">selected="selected"</c:if>>${categorie.categoryName}</option>
        </c:forEach></form:select>
        <label>是否置顶</label> <input type="checkbox" name="top" value="${article.top}" <c:if test="${article.top}">checked="checked"</c:if> />
        <label>允许评论</label> <input type="checkbox" name="allowComment" value="${article.allowComment}" <c:if test="${article.allowComment}">checked="checked"</c:if> /><br />
        <label>文章标题</label> <input type="text" id="text" name="subject" class="medium required" size="206" original-title="请输入文章标题" value="${article.subject}" />
        <script type="text/plain" id="myEditor">${article.message}</script>
            <script type="text/javascript">
                var editor = new baidu.editor.ui.Editor({
                    textarea: 'message',
                    elementPathEnabled:false
                });
                editor.render("myEditor");
            </script>
        </div>
    </div>
</div>
<button class="button_colour" id="publish" type="submit"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/BendedArrowRight.png"><span>发 布</span></button>
<button class="button_colour" type="reset"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/BendedArrowRight.png"><span>草 稿</span></button>
</form:form>
</div>
<script type="text/javascript">
    var URL = "${ctx}/../..";
    $(function () {
        $("#articleForm").validate({
            event:'submit',
            rules:{subject:{required:true, maxlength:26}}
        });
    });
</script>
</body>
</html>