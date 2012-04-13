<%--
  相册
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-19
  Time: 下午1:10
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <div class="title"><h1>相册</h1></div>
    <div class="desc">一花一世界，一叶一春秋</div>
</div>
<!-- END OF PAGE TITLE -->
<!-- BEGIN CONTENT -->
<div id="content-inner-full">
    <h2><a href="${ctx}/gallery/album">相册模式</a> | <a href="${ctx}/gallery/photo">画廊模式</a></h2>
    <div id="album_load">
    <%--<c:out value="${fn:length(images)}"/>--%>
    <c:forEach items="${images}" var="image" begin="0" step="1" varStatus="var">
    <div class="portfolio-box"><!-- portfolio 1 -->
        <div class="pf-title">${image.title}</div>
        <div class="pf-content">
            <a href="${ctx}/static/uploads/gallery/gallery-big/${image.imageUrl}" class="fancy_box" title="${image.title}">
                <img src="${ctx}/static/uploads/gallery/album-thumb/${image.imageUrl}" alt="" width="218px" height="194px" /></a>
            <p class="albumDesc">${image.description}</p>
        </div>
    </div>
    <c:if test="${var.index%2==0}"><div class="spacer-pf">&nbsp;</div></c:if>
    </c:forEach>
    </div>
    <div class="blog-pagination"><!-- page pagination -->
        分页&nbsp;:&nbsp;
        <c:choose>
            <c:when test="${total <= 44}">
                <c:forEach begin="1" end="${pageCount}" step="1" varStatus="var">
                    <span class="blog-button-page pagination">${var.index}</span>&nbsp;
                </c:forEach>
            </c:when>
            <c:otherwise>
                <c:forEach begin="1" end="11" step="1" varStatus="var">
                    <span class="blog-button-page pagination">${var.index}</span>&nbsp;
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<!-- END OF CONTENT -->
<script type="text/javascript">
    $(function () {
        var albums = $("#album_load");
        var pager = $(".blog-pagination");
        PageClick = function (pageIndex, total, spanInterval) {
            //索引从1开始
            //将当前页索引转为int类型
            var intPageIndex = parseInt(pageIndex);
            var limit = 4;//每页显示文章数量

            $.ajax({
                url:"${ctx}/gallery/album/ajax?offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,
                timeout:3000,
                success:function (data) {
                    albums.html("");

                    //加载文章
                    $.each(data, function (index, content) {
                        albums.append($("<div class='portfolio-box'>" +
                                "<div class='pf-title'>" + content.title + "</div>" +
                                "<div class='pf-content'>" +
                                "<a href='${ctx}/static/uploads/gallery/gallery-big/" + content.imageUrl + "' class='fancy_box' title='" + content.title + "'>" +
                                "<img alt='' width='218px' height='194px' src='${ctx}/static/uploads/gallery/album-thumb/" + content.imageUrl + "' /></a>" +
                                "<p class='albumDesc'>" + content.description + "</p>" +
                                "</div>" +
                                "</div>"));
                        if (index%2 == 0) {
                            albums.append($("<div class='spacer-pf'>&nbsp;</div>"));
                        }
                    });

                    $(".blog-pagination").html("分页&nbsp;:&nbsp;");

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
                            var spanSelectd = $("<span class='blog-button-page-selected pagination'>" + j + "</span>");
                            pager.append(spanSelectd);
                        } else {
                            var a = $("<span class='blog-button-page pagination'>" + j + "</span>").click(function () {
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