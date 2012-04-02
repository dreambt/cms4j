<%--
  相册
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-19
  Time: 下午1:10
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>相册</title>
    <!-- Add mousewheel plugin (this is optional) -->
    <script type="text/javascript" src="${ctx}/static/jquery/jquery.mousewheel-3.0.6.pack.js"></script>

    <!-- Add fancyBox -->
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/jquery.fancybox.pack.js?v=2.0.5"></script>

    <!-- Optionally add button and/or thumbnail helpers -->
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.css?v=2.0.5" type="text/css" media="screen" />
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.js?v=2.0.5"></script>

    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.css?v=2.0.5" type="text/css" media="screen" />
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.js?v=2.0.5"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $(".fancy_box").fancybox({
                helpers: {
                    title : {
                        type : 'float'
                    }
                }
                });
            });
    </script>
</head>
<body>
<!-- BEGIN PAGE TITLE -->
<div id="page-title">
    <div class="title"><!-- your title page -->
        <h1>Gallery</h1>
    </div>
    <div class="desc"><!-- description about your page -->
        Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae, itaque earum rerum hic tenetur a sapiente delectus.
    </div>
</div>
<!-- END OF PAGE TITLE -->

<!-- BEGIN CONTENT -->
<div id="content-inner-full">
    <div class="portfolio-box"><!-- portfolio 1 -->
        <div class="pf-title">Centita - Minimalist Business Template</div>
        <div class="pf-content">
            <a href="${ctx}/static/images/portfolio-big/pf-big1.jpg" class="fancy_box" title="Centita - Minimalist Business Template"><img src="${ctx}/static/images/portfolio-thumb/pf-thumb1.jpg" alt="" /></a>
            <p>Adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Nemo enim ipsam volup tatemquia voluptas sit aspernatur aut odit aut fugit, sed quia conse quuntur magni dolores eos quiratio voluptatem sequi nesciunt velitese.</p>
            <a href="#">view site &raquo;</a>
        </div>
    </div>

    <div class="spacer-pf">&nbsp;</div>

    <div class="portfolio-box"><!-- portfolio 2 -->
        <div class="pf-title">Devster - Simple Business Template</div>
        <div class="pf-content">
            <a href="${ctx}/static/images/portfolio-big/pf-big2.jpg" class="fancy_box" title="Devster - Simple Business Template"><img src="${ctx}/static/images/portfolio-thumb/pf-thumb2.jpg" alt="" /></a>
            <p>Adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Nemo enim ipsam volup tatemquia voluptas sit aspernatur aut odit aut fugit, sed quia conse quuntur magni dolores eos quiratio voluptatem sequi nesciunt velitese.</p>
            <a href="#">view site &raquo;</a>
        </div>
    </div>

    <div class="portfolio-box-bottom"><!-- portfolio 3 -->
        <div class="pf-title">Avalium - Clean Business Template</div>
        <div class="pf-content">
            <a href="${ctx}/static/images/portfolio-big/pf-big3.jpg" class="fancy_box" title="Avalium - Clean Business Template"><img src="${ctx}/static/images/portfolio-thumb/pf-thumb3.jpg" alt="" /></a>
            <p>Adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Nemo enim ipsam volup tatemquia voluptas sit aspernatur aut odit aut fugit, sed quia conse quuntur magni dolores eos quiratio voluptatem sequi nesciunt velitese.</p>
            <a href="#">view site &raquo;</a>
        </div>
    </div>

    <div class="spacer-pf">&nbsp;</div>

    <div class="portfolio-box-bottom"><!-- portfolio 4 -->
        <div class="pf-title">Agivee - Corporate Business Template</div>
        <div class="pf-content">
            <a href="${ctx}/static/images/portfolio-big/pf-big4.jpg" class="fancy_box" title="Agivee - Corporate Business Template"><img src="${ctx}/static/images/portfolio-thumb/pf-thumb4.jpg" alt="" /></a>
            <p>Adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Nemo enim ipsam volup tatemquia voluptas sit aspernatur aut odit aut fugit, sed quia conse quuntur magni dolores eos quiratio voluptatem sequi nesciunt velitese.</p>
            <a href="#">view site &raquo;</a>
        </div>
    </div>

    <div class="portfolio-pagination"><!-- navigation -->
        <a href="#" class="portfolio-button-page">Prev</a>
        <a href="#" class="portfolio-button-page">Next</a>
    </div>

</div>
<!-- END OF CONTENT -->
</body>
</html>