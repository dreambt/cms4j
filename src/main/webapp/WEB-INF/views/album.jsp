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
        <h1>相册</h1>
    </div>
    <div class="desc"><!-- description about your page -->
        Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae, itaque earum rerum hic tenetur a sapiente delectus.
    </div>
</div>
<!-- END OF PAGE TITLE -->

<!-- BEGIN CONTENT -->
<div id="content-inner-full">
    <div class="maincontent" id="album_load">

    <c:forEach items="${images}" var="image" begin="0" step="1">
    <div class="portfolio-box"><!-- portfolio 1 -->
        <div class="pf-title">${image.title}</div>
        <div class="pf-content">
            <a href="${ctx}/static/images/portfolio-big/pf-big1.jpg" class="fancy_box" title="Centita - Minimalist Business Template"><img src="${ctx}/static/uploads/gallery/${image.imageUrl}" alt="" /></a>
            <p>${image.description}</p>
            <a href="#">view site &raquo;</a>
        </div>
    </div>
    </c:forEach>

    <%--<div class="spacer-pf">&nbsp;</div>

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
        </div>--%>
    </div>

    <div class="album-pagination"><!-- navigation -->
        <a href="#" class="portfolio-button-page">Prev</a>
        <a href="#" class="portfolio-button-page">Next</a>
    </div>

</div>
<!-- END OF CONTENT -->
<script type="text/javascript">
    $(function () {
        var articles = $("#album_load");
        var pager = $(".album-pagination");
        PageClick = function (pageIndex, total, spanInterval) {
            //索引从1开始
            //将当前页索引转为int类型
            var intPageIndex = parseInt(pageIndex);
            var limit = 10;//每页显示文章数量

            $.ajax({
                url:"${ctx}/article/digest/ajax/${category.id}?offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,
                timeout:3000,
                success:function (data) {
                    articles.html("");

                    //加载文章
                    $.each(data, function (index, content) {
                        if(content.top)
                            articles.append($("<div class='blog-post digest'><img src='${ctx}/static/images/blog-pic1.jpg' class='imgleft'/><h2><img src='${ctx}/static/images/top.gif' /><a href='${ctx}/article/content/" + content.id + "'>"+ content.subject +"</a></h2><div class='blog-posted'>作者: " + content.author + " &nbsp; | &nbsp; 发表时间: "+ChangeDateFormat(content.createTime)+" &nbsp; | &nbsp; 浏览次数: " + content.views + " &nbsp; | &nbsp; 评论数: " + content.count + "</div><p>"+content.digest+"</p></div>"));
                        else
                            articles.append($("<div class='blog-post digest'><img src='${ctx}/static/images/blog-pic1.jpg' class='imgleft'/><h2><a href='${ctx}/article/content/" + content.id + "'>"+ content.subject +"</a></h2><div class='blog-posted'>作者: " + content.author + " &nbsp; | &nbsp; 发表时间: "+ChangeDateFormat(content.createTime)+" &nbsp; | &nbsp; 浏览次数: " + content.views + " &nbsp; | &nbsp; 评论数: " + content.count + "</div><p>"+content.digest+"</p></div>"));
                    });

                    $(".blog-pagination").html("Page&nbsp;:&nbsp;");

                    //将总记录数结果 得到 总页码数
                    var pageS = total;
                    if (pageS % limit == 0) pageS = pageS / limit;
                    else pageS = parseInt(total / limit) + 1;

                    //设置分页的格式  这里可以根据需求完成自己想要的结果
                    var interval = parseInt(spanInterval); //设置间隔
                    var start = Math.max(1, intPageIndex - interval); //设置起始页
                    var end = Math.min(intPageIndex + interval, pageS);//设置末页

                    if (intPageIndex < interval + 1) {
                        end = (2 * interval + 1) > pageS ? pageS : (2 * interval + 1);
                    }

                    if ((intPageIndex + interval) > pageS) {
                        start = (pageS - 2 * interval) < 1 ? 1 : (pageS - 2 * interval);
                    }

                    //生成页码
                    for (var j = start; j < end + 1; j++) {
                        if (j == intPageIndex) {
                            var spanSelectd = $("<span class='blog-button-page-selected pagination'>" + j + "</span>&nbsp;");
                            pager.append(spanSelectd);
                        } else {
                            var a = $("<span class='blog-button-page pagination'>" + j + "</span>&nbsp;").click(function () {
                                PageClick($(this).text(), total, spanInterval);
                            });
                            pager.append(a);
                        } //else
                    } //for
                }
            });
        };
        $(".pagination").click(function () {
            PageClick($(this).text(), ${total}, 5);
        });
    });
</script>
</body>
</html>