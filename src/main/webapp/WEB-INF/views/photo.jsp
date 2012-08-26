<%--
  相册
  User: baitao.jibt@gmail.com
  Date: 12-8-25
  Time: 下午14:21
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>画廊</title>
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.css?v=2.0.5" type="text/css" media="screen" />
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.css?v=2.0.5" type="text/css" media="screen" />
</head>
<body>
<!-- 导航 -->
<div class="row">
    <div class="span13">
        <ul class="breadcrumb">
            <li><a href="#">首页</a> <span class="divider">/</span></li>
            <li>画廊</li>
        </ul>
    </div>
</div>
<!-- 画廊 -->
<div class="row">
    <!-- 左边 -->
    <div class="span13">
        <!-- 列表 -->
        <div>
            <ul id="album_load" class="thumbnails">
            <c:forEach items="${images}" var="image" begin="0" step="1" varStatus="var">
                <li class="span3">
                    <a href="${ctx}/static/uploads/gallery/gallery-big/${image.imageUrl}" rel="fancybox-thumb" class="thumbnail fancybox-thumb" title="${image.title}">
                        <img src="${ctx}/static/uploads/gallery/thumb-224x136/${image.imageUrl}" alt="">
                    </a>
                </li>
            <%--<c:if test="${var.count%4!=0}">--%>
                <%--<div class="spacer-pf">&nbsp;</div>--%>
            <%--</c:if>--%>
            </c:forEach>
            </ul>
        </div>
        <!-- 分页 -->
        <div class="pagination pagination-right">
            <ul id="pagination">
                <c:forEach begin="1" end="${total/10>11?11:1+total/10}" step="1" varStatus="var">
                    <li><a href="#">${var.index}</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/static/jquery/jquery.mousewheel-3.0.6.pack.js"></script>
<script type="text/javascript" src="${ctx}/static/js/fancyBox/jquery.fancybox.pack.js?v=2.0.5"></script>
<script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.js?v=2.0.5"></script>
<script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.js?v=2.0.5"></script>
<script type="text/javascript">
    $(function () {
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

        // 分页
        var albums = $("#album_load");
        var pager = $("#pagination");
        pager.find("li:first").addClass('active');
        PageClick = function (pageIndex, total, spanInterval) {
            //索引从1开始
            //将当前页索引转为int类型
            var intPageIndex = parseInt(pageIndex);
            var limit = 12;//每页显示文章数量

            $.ajax({
                url:"${ctx}/gallery/photo/ajax?offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,
                timeout:3000,
                success:function (data) {
                    //加载
                    albums.html("");
                    $.each(data, function (index, content) {
                        albums.append($("<li class='span3'><a href='${ctx}/static/uploads/gallery/gallery-big/" + content.imageUrl + "' rel='fancybox-thumb' class='thumbnail fancybox-thumb' title='" + content.title + "'><img src='${ctx}/static/uploads/gallery/thumb-224x136/" + content.imageUrl + "' alt=''></a></li>"));
//                        if (index%2 == 0) {
//                            albums.append($("<div class='spacer-pf'>&nbsp;</div>"));
//                        }
                    });

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
                    pager.html("");
                    for (var j = start; j < end + 1; j++) {
                        if (j == intPageIndex) {
                            pager.append("<li class='active'><a href='#'>" + j + "</a></li>");
                        } else {
                            var a = $("<li><a href='#'>" + j + "</a></li>").click(function () {
                                PageClick($(this).text(), total, spanInterval);
                            });
                            pager.append(a);
                        } //else
                    } //for
                }
            });
        };
        $("#pagination li").click(function () {
            PageClick($(this).text(), ${total}, 5);
        });
    });
</script>
</body>
</html>