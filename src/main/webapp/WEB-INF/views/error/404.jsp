<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%response.setStatus(200);%>

<!doctype html>
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>
    <title>404 - 页面不存在</title>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="copyright" content="">
    <meta name="author" content="">
    <meta name="language" content="English">
    <meta name="robots" content="index, follow">
    <meta property="fb:page_id" content="XXX"> <!-- XXX = Facebook Fan Page ID -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Icons -->
    <link rel="shortcut icon" href="${ctx}/static/favicon.ico">
    <link rel="apple-touch-icon" href="${ctx}/static/apple-touch-icon.png">

    <!-- CSS Styles -->
    <link rel="stylesheet" href="${ctx}/static/404/screen.css">
    <link rel="stylesheet" href="${ctx}/static/404/colors.css">

    <!-- Google WebFonts -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700&v2' rel='stylesheet' type='text/css'>

    <!-- Modernizr adds classes to the <html> element which allow you to target specific browser functionality in your stylesheet -->
    <script src="${ctx}/static/js/modernizr-1.7.min.js"></script>
</head>
<body class="error-page">
<article class="error-wrapper">
    <div class="error-code">
        <h1>404<span>Whoops! Page not found&#8230;</span></h1>
    </div>
    <div class="error-content">
        <p>对不起, ${message}. 如果有什么疑问, 可以 <a href="mailto:dreambt@gmail.com">联系我们</a> 或者 搜索:</p>
        <form>
            <input type="text" name="search" value="">
            <button type="submit">搜索</button></a>
        </form>
    </div>
</article>
</body>
</html>