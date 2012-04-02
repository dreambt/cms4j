<%--
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-19
  Time: 下午5:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>相册2</title>
    <!-- Add mousewheel plugin (this is optional) -->
    <script type="text/javascript" src="${ctx}/static/jquery/jquery.mousewheel-3.0.6.pack.js"></script>

    <!-- Add fancyBox -->
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen"/>
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/jquery.fancybox.pack.js?v=2.0.5"></script>

    <!-- Optionally add button and/or thumbnail helpers -->
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.css?v=2.0.5" type="text/css"
          media="screen"/>
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.js?v=2.0.5"></script>

    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.css?v=2.0.5" type="text/css"
          media="screen"/>
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.js?v=2.0.5"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".fancybox-thumb").fancybox({
                prevEffect:'none',
                nextEffect:'none',
                helpers:{
                    title:{
                        type:'outside'
                    },
                    overlay:{
                        opacity:0.8,
                        css:{
                            'background-color':'#000'
                        }
                    },
                    thumbs:{
                        width:50,
                        height:50
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
        Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates
        repudiandae sint et molestiae non recusandae, itaque earum rerum hic tenetur a sapiente delectus.
    </div>
</div>
<!-- END OF PAGE TITLE -->

<!-- BEGIN CONTENT -->
<div id="content-inner-full">
    <div class="main-portfolio">
        <h2>Our best works</h2>

        <p>Architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit
            aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro
            quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius
            modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.</p>

        <div class="pf-gall"><!-- portfolio 1 -->
            <a href="${ctx}/static/images/portfolio-big/pf-alt-big1.jpg" rel="fancybox-thumb" class="fancybox-thumb" title="Portfolio 1"><img
                    src="${ctx}/static/images/portfolio-thumb/pf-alt-thumb1.jpg" alt="" class="pf-img"/></a>
        </div>

        <div class="pf-gall"><!-- portfolio 2 -->
            <a href="${ctx}/static/images/portfolio-big/pf-alt-big2.jpg" rel="fancybox-thumb" class="fancybox-thumb" title="Portfolio 2"><img
                    src="${ctx}/static/images/portfolio-thumb/pf-alt-thumb2.jpg" alt="" class="pf-img"/></a>
        </div>

        <div class="pf-gall"><!-- portfolio 3 -->
            <a href="${ctx}/static/images/portfolio-big/pf-alt-big3.jpg" rel="fancybox-thumb" class="fancybox-thumb" title="Portfolio 3"><img
                    src="${ctx}/static/images/portfolio-thumb/pf-alt-thumb3.jpg" alt="" class="pf-img"/></a>
        </div>

        <div class="pf-gall-nomargin"><!-- portfolio 4 -->
            <a href="${ctx}/static/images/portfolio-big/pf-alt-big4.jpg" rel="fancybox-thumb" class="fancybox-thumb" title="Portfolio 4"><img
                    src="${ctx}/static/images/portfolio-thumb/pf-alt-thumb4.jpg" alt="" class="pf-img"/></a>
        </div>

        <div class="pf-gall"><!-- portfolio 5 -->
            <a href="${ctx}/static/images/portfolio-big/pf-alt-big5.jpg" rel="fancybox-thumb" class="fancybox-thumb" title="Portfolio 5"><img
                    src="${ctx}/static/images/portfolio-thumb/pf-alt-thumb5.jpg" alt="" class="pf-img"/></a>
        </div>

        <div class="pf-gall"><!-- portfolio 6 -->
            <a href="${ctx}/static/images/portfolio-big/pf-alt-big6.jpg" rel="fancybox-thumb" class="fancybox-thumb" title="Portfolio 6"><img
                    src="${ctx}/static/images/portfolio-thumb/pf-alt-thumb6.jpg" alt="" class="pf-img"/></a>
        </div>

        <div class="pf-gall"><!-- portfolio 7 -->
            <a href="${ctx}/static/images/portfolio-big/pf-alt-big7.jpg" rel="fancybox-thumb" class="fancybox-thumb" title="Portfolio 7"><img
                    src="${ctx}/static/images/portfolio-thumb/pf-alt-thumb7.jpg" alt="" class="pf-img"/></a>
        </div>

        <div class="pf-gall-nomargin"><!-- portfolio 8 -->
            <a href="${ctx}/static/images/portfolio-big/pf-alt-big8.jpg" rel="fancybox-thumb" class="fancybox-thumb" title="Portfolio 8"><img
                    src="${ctx}/static/images/portfolio-thumb/pf-alt-thumb8.jpg" alt="" class="pf-img"/></a>
        </div>
        <div class="portfolio-pagination"><!-- navigation -->
            <a href="#" class="portfolio-button-page">Prev</a>
            <a href="#" class="portfolio-button-page">Next</a>
        </div>
    </div>
</div>
<!-- END OF CONTENT -->
</body>
</html>