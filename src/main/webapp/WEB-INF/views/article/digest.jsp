<%--
  文章摘要模式
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-18
  Time: 上午9:30
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>${category.categoryName}</title>
</head>
<body>
<!-- BEGIN PAGE TITLE -->
<div id="page-title">
    <div class="title"><!-- your title page -->
        <h2 class="cufon">${category.categoryName}</h2>
    </div>
    <div class="desc">${category.description}</div>
</div>
<!-- END OF PAGE TITLE -->
<div id="content-inner">
<div id="content-left">
    <div id="article_load">
        <c:forEach items="${articles}" var="article" begin="0" step="1" varStatus="stat">
        <div class="blog-post digest">
            <img src="${ctx}/static/images/blog-pic1.jpg" alt="" class="imgleft"/>
            <h2 style="font-size:18px;overflow:hidden"><a href="${ctx}/article/content/${article.id}"><c:if test="${article.top}"><img src="${ctx}/static/images/top.gif" /></c:if>${article.subject}</a></h2>
            <div class="blog-posted">
                作者: ${article.user.username} &nbsp; | &nbsp; 发表时间: <fmt:formatDate value="${article.createdDate}" pattern="yyyy-MM-dd"/> &nbsp; | &nbsp; 浏览次数: ${article.views} &nbsp; | &nbsp; 评论数: ${fn:length(article.commentList)}
            </div>
            <p>${article.digest}</p>
        </div>
        </c:forEach>
    </div>
    <div class="blog-pagination"><!-- page pagination -->
        页码 &nbsp;:&nbsp;
        <c:choose>
            <c:when test="${total <= 66}">
                <c:forEach begin="1" end="${pageCount>1?pageCount:1}" step="1" varStatus="var">
                    <span class="blog-button-page pagination">${var.index}</span>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <c:forEach begin="1" end="11" step="1" varStatus="var">
                    <span class="blog-button-page pagination">${var.index}</span>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!--sidebox-->
<%@include file="/WEB-INF/layouts/sidebar.jsp" %>
</div>
<script type="text/javascript">
    function ChangeDateFormat(cellval) {
        var date = new Date(parseInt(cellval + 3600000, 10));
        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
        var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
        return date.getFullYear() + "-" + month + "-" + currentDate;
    }

    $(function () {
        var articles = $("#article_load");
        var pager = $(".blog-pagination");
        pager.find("span:first").css('background-color','#e4e4e4').css('color','#ff4e00').css('cursor','default');
        PageClick = function (pageIndex, total, spanInterval) {
            //索引从1开始
            //将当前页索引转为int类型
            var intPageIndex = parseInt(pageIndex);
            var limit = 6;//每页显示文章数量

            $.ajax({
                url:"${ctx}/article/digest/ajax/${category.id}?offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,
                timeout:3000,
                success:function (data) {
                    articles.html("");

                    //加载文章
                    $.each(data, function (index, content) {
                        if (content.top)
                            articles.append($("<div class='blog-post digest'><img src='${ctx}/static/images/blog-pic1.jpg' class='imgleft'/><h2><img src='${ctx}/static/images/top.gif' /><a href='${ctx}/article/content/" + content.id + "'>" + content.subject + "</a></h2><div class='blog-posted'>作者: " + content.user.username + " &nbsp; | &nbsp; 发表时间: " + ChangeDateFormat(content.createdDate) + " &nbsp; | &nbsp; 浏览次数: " + content.views + " &nbsp; | &nbsp; 评论数: " + content.commentList.length + "</div><p>" + content.digest + "</p></div>"));
                        else
                            articles.append($("<div class='blog-post digest'><img src='${ctx}/static/images/blog-pic1.jpg' class='imgleft'/><h2><a href='${ctx}/article/content/" + content.id + "'>" + content.subject + "</a></h2><div class='blog-posted'>作者: " + content.user.username + " &nbsp; | &nbsp; 发表时间: " + ChangeDateFormat(content.createdDate) + " &nbsp; | &nbsp; 浏览次数: " + content.views + " &nbsp; | &nbsp; 评论数: " + content.commentList.length + "</div><p>" + content.digest + "</p></div>"));
                    });

                    $(".blog-pagination").html("页码&nbsp;:&nbsp;");

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
                            var spanSelectd = $("<span class='blog-button-page-selected pagination'>" + j + "</span>&nbsp;&nbsp;");
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