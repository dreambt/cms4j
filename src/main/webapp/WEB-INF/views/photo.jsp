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
    <title>画廊</title>
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
        <h1>画廊</h1>
    </div>
    <div class="desc"><!-- description about your page -->
        Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates
        repudiandae sint et molestiae non recusandae, itaque earum rerum hic tenetur a sapiente delectus.
    </div>
</div>
<!-- END OF PAGE TITLE -->

<!-- BEGIN CONTENT -->
<div id="content-inner-full">
    <%--<h2>Our best works</h2>

    <p>Architecto beatae vitae dicta sunt explicabo nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit
        aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro
        quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius
        modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.</p>--%>
    <div id="album_load">


        <c:forEach items="${images}" var="image" begin="0" step="1" varStatus="var">
        <div class="pf-gall"><!-- portfolio 1 -->
            <a href="${ctx}/static/uploads/gallery/${image.imageUrl}" rel="fancybox-thumb" class="fancybox-thumb" title="${image.title}"><img
                    src="${ctx}/static/uploads/gallery/${image.imageUrl}" width="200" height="122" alt="" class="pf-img"/></a>
        </div>
            <%--<c:if test="${var.index%4==3}"><br/></c:if>--%>
        </c:forEach>


    </div>
        <div class="blog-pagination"><!-- page pagination -->
            Page&nbsp;:&nbsp;
            <c:choose>
                <c:when test="${total <= 44}">
                    <c:forEach begin="1" end="${pageCount}" step="1" varStatus="var">
                        <span class="blog-button-page pagination">${var.index}</span>&nbsp;
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <c:forEach begin="1" end="5" step="1" varStatus="var">
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
            var limit = 12;//每页显示文章数量

            $.ajax({
                url:"${ctx}/gallery/photo/ajax?offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,
                timeout:3000,
                success:function (data) {
                    albums.html("");

                    //加载文章
                    $.each(data, function (index, content) {
                        albums.append($("<div class='pf-gall'><!-- portfolio 1 -->" +
                                "<a href='${ctx}/static/uploads/gallery/" + content.imageUrl + "' rel='fancybox-thumb'" +
                                " class='fancybox-thumb' title='" + content.title + "'>" +
                                "<img src='${ctx}/static/uploads/gallery/" + content.imageUrl + "' width='200' height='122'" +
                                "alt='' class='pf-img'/></a></div>"));
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