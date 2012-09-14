<%--
  文章摘要模式
  User: baitao.jibt@gmail.com
  Date: 12-8-24
  Time: 下午20:52
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>${category.categoryName}</title>
</head>
<body>
<!-- 文章导航 -->
<div class="row">
    <div class="span13">
        <ul class="breadcrumb">
            <li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
            <li class="active"><c:choose><c:when test="${archive eq null}">${category.categoryName}</c:when><c:otherwise>${archive.title}</c:otherwise></c:choose></li>
        </ul>
    </div>
</div>
<div class="row">
    <!-- 左边 -->
    <div class="span9">
        <!-- 列表 -->
        <div>
            <ul id="article_load" class="nav">
                <c:forEach items="${articles}" var="article" begin="0" step="1" varStatus="stat">
                <div class="thumbnail" style="margin-bottom:5px">
                    <img src="${ctx}/static/uploads/article/digest-thumb/${article.imageName}" alt="" class="imgleft" width="134px" height="134px"/>
                    <div class="caption">
                        <h5 style="margin:0"><a href="${ctx}/article/content/${article.id}" title="${article.subject}"><c:if test="${article.top}"><img src="${ctx}/static/images/top.gif" /></c:if>${fn:substring(article.subject,0,23)}<c:if test="${fn:length(article.subject)>23}">...</c:if></a></h5>
                        <div>作者: ${article.user.username}&nbsp;|&nbsp;发表时间:<joda:format value="${article.createdDate}" pattern="yyyy年MM月dd日"/>&nbsp;|&nbsp;浏览次数: ${article.views}</div>
                        <p>${article.digest}</p>
                    </div>
                </div>
                </c:forEach>
            </ul>
        </div>
        <!-- 分页 -->
        <div class="pagination pagination-right">
            <ul id="pagination">
                <c:forEach begin="1" end="${total/6>11?11:0.9+total/6}" step="1" varStatus="var">
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
        var articles = $("#article_load");
        var pager = $("#pagination");
        pager.find("li:first").addClass('active');
        PageClick = function (pageIndex, total, spanInterval) {
            //索引从1开始
            //将当前页索引转为int类型
            var intPageIndex = parseInt(pageIndex);
            var limit = 6;//每页显示文章数量

            $.ajax({
                url:"${ctx}/article/digest/ajax/${category.id}?offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,
                timeout:3000
                }).done(function (data) {
                    //加载文章
                    articles.html("");
                    $.each(data, function (index, content) {
                        if (content.top)
                            articles.append($("<div class='thumbnail' style='margin-bottom:5px'><img src='${ctx}/static/uploads/article/digest-thumb/"+content.imageName+"' alt='' class='imgleft' width='134px' height='134px'/><div class='caption'><h5 style='margin:0'><a href='${ctx}/article/content/" + content.id + "' title='" + content.subject + "'><img src='${ctx}/static/images/top.gif' />" + content.subject.substr(0,23) + "</a></h5><div>作者: " + content.user.username + " &nbsp; | &nbsp; 发表时间: " + ChangeDateTimeFormat(content.createdDate) + " &nbsp; | &nbsp; 浏览次数: " + content.views + "</div><p>" + content.digest + "</p></div></div>"));
                        else
                            articles.append($("<div class='thumbnail' style='margin-bottom:5px'><img src='${ctx}/static/uploads/article/digest-thumb/"+content.imageName+"' alt='' class='imgleft' width='134px' height='134px'/><div class='caption'><h5 style='margin:0'><a href='${ctx}/article/content/" + content.id + "' title='" + content.subject + "'>" + content.subject.substr(0,23) + "</a></h5><div>作者: " + content.user.username + " &nbsp; | &nbsp; 发表时间: " + ChangeDateTimeFormat(content.createdDate) + " &nbsp; | &nbsp; 浏览次数: " + content.views + "</div><p>" + content.digest + "</p></div></div>"));
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
            });
        };
        $("#pagination li").click(function () {
            PageClick($(this).text(), ${total}, 5);
        });
    });
</script>
</body>
</html>