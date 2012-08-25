<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<%response.setStatus(200);%>
<%
	Throwable ex = null;
	if (exception != null)
		ex = exception;
	if (request.getAttribute("javax.servlet.error.exception") != null)
		ex = (Throwable) request.getAttribute("javax.servlet.error.exception");

	//记录日志
	Logger logger = LoggerFactory.getLogger("500.jsp");
	logger.error(ex.getMessage(), ex);
%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%response.setStatus(200);%>

<!doctype html>
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<head>
    <title>500 - 系统内部错误</title>
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
    <link rel="stylesheet" href="${ctx}/static/404/screen.min.css">
    <link rel="stylesheet" href="${ctx}/static/404/colors.min.css">

    <!-- Google WebFonts -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700&v2' rel='stylesheet' type='text/css'>

    <!-- Modernizr adds classes to the <html> element which allow you to target specific browser functionality in your stylesheet -->
    <script src="${ctx}/static/js/modernizr-1.7.min.js"></script>
</head>
<body class="error-page">
<article class="error-wrapper">
    <div class="error-code">
        <h1>500<span>Whoops! Server error&#8230;</span></h1>
    </div>
    <div class="error-content">
        <p>Sorry, it appears the page you were looking for doesn't exist anymore or might have been moved. If the problem persists, please contact our support at <a href="#">dreambt@gmail.com</a> or try searching:</p>
        <form>
            <input type="text" name="search" value="">
            <button type="submit">Search</button></a>
        </form>
    </div>
</article>
</body>
</html>