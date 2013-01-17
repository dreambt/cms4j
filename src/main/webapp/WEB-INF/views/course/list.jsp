<%--
  课程列表
  User: baitao.jibt@gmail.com
  Date: 12-10-30
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
    <title>${courseName}</title>
</head>
<body>
<!-- 左边栏 -->
<%@include file="/WEB-INF/layouts/sidebar.jsp" %>
<div class="index_right">
    <div class="blog-header">
        ${courseName}
    </div>
    <div class="blog-list">
        <ul id="course_load" class="nav nav-tabs nav-stacked">
            <c:forEach items="${courses}" var="course" begin="0" step="1" varStatus="stat">
                <li><a href="${ctx}/course/${course.id}"><c:if test="${course.top}"><img src="${ctx}/static/images/top.gif" /> </c:if>${course.courseName} (${course.courseType})</a></li>
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
<script type="text/javascript">
    $(function () {
        var courses = $("#course_load");
        var pager = $("#pagination");
        pager.find("li:first").addClass('active');
        PageClick = function (pageIndex, total, spanInterval) {
            //索引从1开始
            //将当前页索引转为int类型
            var intPageIndex = parseInt(pageIndex);
            var limit = 12;//每页显示课程数量

            $.ajax({
                url:"${ctx}/course/list.json?offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,
                timeout:3000,
                success:function (data) {
                    //加载课程
                    courses.html("");
                    $.each(data, function (index, content) {
                        if(content.top)
                            courses.append($("<li><a href='${ctx}/course/" + content.id + "'><img src='${ctx}/static/images/top.gif' /> " + content.courseName + " (" + content.courseType + ")</a></li>"));
                        else
                            courses.append($("<li><a href='${ctx}/course/" + content.id + "'>" + content.courseName + " (" + content.courseType + ")</a></li>"));
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
                }
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