<%--
  文章正文
  User: baitao.jibt@gmail.com
  Date: 12-8-24
  Time: 下午16:09
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>${article.subject} - ${article.category.categoryName}</title>
</head>
<body>
<!-- 文章导航 -->
<div class="row">
    <div class="span12">
        <ul class="breadcrumb">
            <li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
            <li><a href="${ctx}/article/list/${article.category.id}">${article.category.categoryName}</a> <span class="divider">/</span></li>
            <li class="active">${article.subject}</li>
        </ul>
    </div>
</div>
<div class="row">
    <!-- 正文 -->
    <div class="span9">
        <div class="blog-post">
            <h3>${article.subject}</h3>
            <div class="blog-posted-inner">
                作者: ${article.user.username} &nbsp; | &nbsp; 发表时间: <joda:format value="${article.createdDate}" pattern="yyyy年MM月dd日 kk:mm:ss"/> &nbsp; | &nbsp;
                浏览次数: ${article.views} <c:if test="${article.allowComment}"></c:if>
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
            <!-- Duoshuo Comment BEGIN -->
	<div class="ds-thread" data-thread-key="" 
	data-title="" data-author-key="" data-url=""></div>
	<script type="text/javascript">
	var duoshuoQuery = {short_name:"sdfie"};
	(function() {
		var ds = document.createElement('script');
		ds.type = 'text/javascript';ds.async = true;
		ds.src = 'http://static.duoshuo.com/embed.js';
		ds.charset = 'UTF-8';
		(document.getElementsByTagName('head')[0] 
		|| document.getElementsByTagName('body')[0]).appendChild(ds);
	})();
	</script>
<!-- Duoshuo Comment END -->
        </c:if>
    </div>
    <!-- 边栏 -->
    <%@include file="/WEB-INF/layouts/sidebar.jsp" %>
</div>
<script>
    $(function() {
        //设置图片宽度最大为676px
        $('.blog-post img').each(function(i){
            //alert($(this).width());
            if($(this).width()>676){
                var b=676/($(this).width());
                $(this).width(676);
                $(this).height($(this).height()*b);
            }
        });
    });
</script>
</body>
</html>