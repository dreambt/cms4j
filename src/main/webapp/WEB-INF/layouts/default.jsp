<%--
  默认模板
  User: baitao.jibt@gmail.com
  Date: 12-8-24
  Time: 下午15:51
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta http-equiv="Cache-Control" content="max-age=604800"/>
    <meta http-equiv="Last-Modified" content="Fri, 12 May 2012 18:53:33 GMT"/>
    <meta name="robots" content="index, follow"/>
    <meta name="keywords" content=""/>
    <meta name="title" content=""/>
    <meta name="description" content=""/>
    <title><sitemesh:title/> - 山东省金融信息工程技术研究中心</title>
    <link rel="shortcut icon" href="${ctx}/static/favicon.ico" type="image/x-icon" />
    <link href="${ctx}/min?t=css&f=/style/bootstrap.css,/style/bootstrap-responsive.css,/js/slides/responsiveslides.css,/js/msgUI/msgGrowl.css,/totop/ui.totop.css,/style/main.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/min?t=js&f=/js/jquery.js,/js/slides/responsiveslides.js,/js/slider.js,/js/easing.js,/totop/jquery.ui.totop.js,/js/jquery.MyQRCode.js,/js/msgUI/msgGrowl.js,/js/main.js,/js/bootstrap.js,/js/template.js" type="text/javascript"></script>
    <sitemesh:head/>
</head>
<body>
<div class="container">
    <%@ include file="/static/layouts/menu.html" %>
    <sitemesh:body/>
    <%@ include file="/static/layouts/link.html" %>
    <%@ include file="/WEB-INF/layouts/footer.jsp" %>
</div>
<c:if test="${not empty info}">
    <div class="tips alert alert-info fade in">
        <button type="button" class="close" data-dismiss="alert">×</button>
        <h4>提示!</h4>
            ${info}
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="tips alert alert-error fade in">
        <button type="button" class="close" data-dismiss="alert">×</button>
        <h4>出错啦!</h4>
            ${error}
    </div>
</c:if>
</body>
</html>