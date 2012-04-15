<%--
  文章正文无sidebar
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-18
  Time: 上午10:55
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>${category.categoryName}</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/ui.totop.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/Ueditor/themes/default/ueditor.css">
    <link href="${ctx}/static/jquery-validation/1.9.0/validate.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/jquery-jRate/jquery.jRate.min.css" type="text/css" rel="stylesheet"/>
    <script src="${ctx}/static/jquery-validation/1.9.0/jquery.validate.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/jquery-validation/1.9.0/messages_cn.js" type="text/javascript"></script>
    <script src="${ctx}/static/jquery-jRate/jquery.jRate.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/jquery.ui.totop.js" type="text/javascript"></script>
</head>
<body>
<!-- BEGIN PAGE TITLE -->
<div id="page-title">
    <div class="title"><!-- your title page -->
        <h2 class="cufon">${article.category.categoryName}</h2>
    </div>
    <div class="desc">${article.digest}</div>
</div>
<!-- END OF PAGE TITLE -->
<!-- BEGIN CONTENT -->
<div id="content-inner-full">
    <div class="maincontent">
        <div class="blog-post">
            <h2>${article.subject}</h2>
            <div class="blog-posted-inner" style="width:920px;">
                作者: ${article.user.username} &nbsp; | &nbsp; 发表时间: <fmt:formatDate value="${article.createdDate}" pattern="yyyy-MM-dd"/> &nbsp; |
                &nbsp;浏览次数: ${article.views} &nbsp; | &nbsp; 评论数: ${fn:length(article.commentList)}
            </div>
            ${article.message}
        </div>
        <c:if test="${not empty relatedArticles}">
        <div id="recentPostList"><!-- relatedPostList -->
            <div id="related-post-title"><h4>相关文章</h4></div>
            <div class="related-item-wrapper">
                <h4><a href="#">相关文章1</a></h4>
                <img src="${ctx}/static/images/blog-pic2.jpg" alt="" class="imgleft"/>
                <!-- some words -->
            </div>
            <div class="related-item-spacer">&nbsp;</div>
            <div class="related-item-wrapper">
                <h4><a href="#">相关文章2</a></h4>
                <img src="${ctx}/static/images/blog-pic3.jpg" alt="" class="imgleft"/>
                <!-- some words -->
            </div>
        </div>
        </c:if>
        <c:if test="${article.allowComment}">
            <div id="commentList">
                <div id="commentList-title"><h4>相关评论</h4></div>
                <c:choose><c:when test="${fn:length(article.commentList) > 0}">
                    <c:forEach items="${article.commentList}" var="comment" begin="0" step="1" varStatus="stat">
                        <c:if test="${comment.status&&!comment.deleted}">
                            <div class="commentList-item-wrapper">
                                <h4><a href="#">${comment.username}</a> 于 <fmt:formatDate value="${comment.createdDate}" pattern="yyyy-MM-dd"/> 发表评论：</h4>
                                ${comment.message}
                            </div>
                        </c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                <div class="commentList-item-wrapper"><h4>暂时没有, 发表一下您的观点吧</h4></div></c:otherwise>
                </c:choose>
            </div>
            <div id="comment">
                <form:form id="commentForm" modelAttribute="comment" action="${ctx}/comment/create" method="post">
                    <div id="comment-title"><h4>发表评论</h4></div>
                    <div class="comment-item-wrapper">
                        <input type="hidden" name="article.id" value="${article.id}"/>
                        <script type="text/javascript" src="${ctx}/static/Ueditor/editor_config.js"></script>
                        <script type="text/javascript" src="${ctx}/static/Ueditor/editor_all.js"></script>
                        <script type="text/plain" id="myEditor"></script>
                        <script type="text/javascript">
                            var editor = new baidu.editor.ui.Editor({
                                toolbars:[
                                    ['Undo', 'Redo', '|', 'Bold', 'Italic', 'Underline', 'StrikeThrough', 'RemoveFormat', '|', 'ForeColor', 'BackColor', 'InsertUnorderedList', 'InsertOrderedList', '|', 'Emotion', 'Link', 'Unlink', 'Date', 'Time', 'BlockQuote', 'HighlightCode', 'Preview']
                                ],
                                minFrameHeight:200,
                                maximumWords:500,
                                textarea:'message',
                                elementPathEnabled:false
                            });
                            editor.render("myEditor");
                        </script>
                        <label>邮箱: </label><input type="text" id="subject" name="username" class="required email"
                                                  value="<shiro:principal property="loginName"/>"/>
                        <label>验证码: </label><input type="text" id="code" name="code"/>
                        <label>评分: </label>
                        <div id="rating"></div>
                        <input type="submit" class="input-submit" value=" 提 交 "/>
                    </div>
                </form:form>
            </div>
        </c:if>
    </div>
</div>
<!-- END OF CONTENT -->
<script>
    $(function () {
        $("#rating").jRate();
        $("#commentForm").validate();
        $().UItoTop({ easingType:'easeOutQuart' });
    });
</script>
</body>
</html>