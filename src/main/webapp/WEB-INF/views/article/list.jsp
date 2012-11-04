<%--
  文章列表
  User: baitao.jibt@gmail.com
  Date: 12-8-24
  Time: 下午16:49
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title><c:choose><c:when test="${archive eq null}">${category.categoryName}</c:when><c:otherwise>${archive.title}</c:otherwise></c:choose></title>
</head>
<body>
<!-- 文章导航 -->
<div class="row">
    <div class="span12">
        <ul class="breadcrumb">
            <li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
            <li class="active"><c:choose><c:when test="${archive eq null}">${category.categoryName}</c:when><c:otherwise>${archive.title}</c:otherwise></c:choose></li>
        </ul>
    </div>
</div>
<!-- 文章列表 -->
<div class="row">
    <!-- 左边 -->
    <div class="span9">
        <!-- 列表 -->
        <div>
            <ul id="article_load" class="nav nav-tabs nav-stacked">
                <c:forEach items="${articles}" var="article" begin="0" step="1" varStatus="stat">
                <li><a href="${ctx}/article/${article.id}"><c:if test="${article.top}"><img src="${ctx}/static/images/top.gif" /> </c:if>${article.subject} (浏览: ${article.views})</a></li>
                </c:forEach>
            </ul>
        </div>
        <!-- 分页 -->
        <div class="pagination pagination-right">
            <ul id="pagination">
                <c:forEach begin="1" end="${total/12>11?11:0.9+total/12}" step="1" varStatus="var">
                    <li><a href="#">${var.index}</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <!-- 边栏 -->
    <%@include file="/WEB-INF/layouts/sidebar.jsp" %>
</div>
<script type="text/javascript">
    $(function () {
        var loadList = $("#article_load");
        var pager = $("#pagination");
        pager.find("li:first").addClass('active');
        PageClick = function (pageIndex, total, spanInterval) {
            //索引从1开始
            //将当前页索引转为int类型
            var intPageIndex = parseInt(pageIndex);
            var limit = 12;//每页显示文章数量

            $.ajax({
                <c:choose>
                <c:when test="${archive ne null}">url:"${ctx}/archive/list.json?id=${archive.id}&offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,</c:when>
                <c:when test="${url ne null}">url:"${ctx}/article/${url}.json?offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,</c:when>
                <c:otherwise>url:"${ctx}/article/list.json?id=${category.id}&offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,</c:otherwise>
                </c:choose>
                timeout:3000
            }).done(function (data) {
                    //加载文章
                    loadList.html("");
                    $.each(data, function (index, content) {
                        if(content.top)
                            loadList.append($("<li><a href='${ctx}/article/" + content.id + "'><img src='${ctx}/static/images/top.gif' /> " + content.subject + " (浏览: " + content.views + ")</a></li>"));
                        else
                            loadList.append($("<li><a href='${ctx}/article/" + content.id + "'>" + content.subject + " (浏览: " + content.views + ")</a></li>"));
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
                                return false;
                            });
                            pager.append(a);
                        } //else
                    } //for				
            });
        };
        $("#pagination li").click(function () {
            PageClick($(this).text(), ${total}, 5);
            return false;
        });
    });
</script>
</body>
</html>