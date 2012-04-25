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
    <link href="${ctx}/static/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/css/inner.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/static/css/superfish.min.css" rel="stylesheet" type="text/css"  />
    <link href="${ctx}/static/CMS.css" type="text/css" rel="stylesheet" />
    <!--[if IE 6]><link href="${ctx}/static/css/ie6.min.css" rel="stylesheet" type="text/css" /><![endif]-->

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
    <script type="text/javascript" src="${ctx}/static/js/cufon-yui.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/Microsoft_YaHei_400.font.js"></script>
    <script type="text/javascript">
        Cufon.replace('.cufon')('.phone')('.textslide p');
        Cufon.replace('.cufon a',{hover: true});
        Cufon.now();
    </script>
    <sitemesh:head/>
</head>
<body>
<div id="page-container">
    <div class="page-container-inner">
        <div class="frame">
            <%@ include file="/WEB-INF/layouts/header.jsp" %>
            <sitemesh:body/>
            <%@ include file="/WEB-INF/layouts/footer.jsp" %>
        </div>
    </div>
</div>
</body>
</html>