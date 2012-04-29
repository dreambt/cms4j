<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta http-equiv="Cache-Control" content="no-store"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <meta name="robots" content="index, follow"/>
    <meta name="keywords" content=""/>
    <meta name="title" content=""/>
    <meta name="description" content=""/>
    <title><sitemesh:title/></title>
    <link rel="shortcut icon" href="${ctx}/static/favicon.ico" type="image/x-icon" />

    <!-- ////////////////////////////////// -->
    <!-- //      Start Stylesheets       // -->
    <!-- ////////////////////////////////// -->
    <link href="${ctx}/static/blueprint/1.0.1/screen.css" type="text/css" rel="stylesheet" media="screen, projection" />
    <link href="${ctx}/static/blueprint/1.0.1/screen-customized.css" type="text/css" rel="stylesheet" media="screen, projection" />
    <link href="${ctx}/static/blueprint/1.0.1/print.css" type="text/css" rel="stylesheet" media="print" />
    <!--[if lt IE 8]><link href="${ctx}/static/blueprint/1.0.1/ie.css" type="text/css" rel="stylesheet" media="screen, projection"><![endif]-->
    <link href="${ctx}/static/css/superfish.min.css" rel="stylesheet" type="text/css"  />
    <link href="${ctx}/static/CMS.css" type="text/css" rel="stylesheet" />

    <!-- ////////////////////////////////// -->
    <!-- //      Javascript Files        // -->
    <!-- ////////////////////////////////// -->
    <script src="${ctx}/static/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/static/js/DD_belatedPNG.js"></script>
    <script type="text/javascript">
        DD_belatedPNG.fix('.page-container-inner');
        DD_belatedPNG.fix('#slideshow-navigation a');
        DD_belatedPNG.fix('#slideshow-navigation .activeSlide');
        DD_belatedPNG.fix('img');
    </script>
    <script type="text/javascript" src="${ctx}/static/js/superfish.js"></script>
    <script type="text/javascript">
        // initialise plugins
        $(function () {
            $('ul.sf-menu').superfish();
        });
    </script>
    <sitemesh:head/>
</head>
<body>
<div id="page-container">
    <div class="page-container-inner">
        <div class="container">
            <%@ include file="/WEB-INF/layouts/header.jsp" %>
            <sitemesh:body/>
            <%@ include file="/WEB-INF/layouts/footer.jsp" %>
        </div>
    </div>
</div>
</body>
</html>