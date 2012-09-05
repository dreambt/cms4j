<%--
 相册管理
  User: baitao.jibt@gmail
  Date: 12-8-25
  Time: 下午19:36
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>相册列表</title>
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.css?v=2.0.5" type="text/css" media="screen" />
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.css?v=2.0.5" type="text/css" media="screen" />
</head>
<body>
<div class="row">
    <div class="span12">
        <form:form modelAttribute="image" id="imageForm" method="post">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>选择</th>
                    <th>缩略图</th>
                    <th>标题</th>
                    <th>描述</th>
                    <th>URL</th>
                    <th>上传时间</th>
                    <th>首页显示</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="image_load">
                <c:forEach items="${images}" var="image" begin="0" step="1">
                <tr>
                    <td><input type="checkbox" name="isSelected"  value="${image.id}"></td>
                    <td><a href="${ctx}/static/uploads/gallery/gallery-big/${image.imageUrl}" rel="fancybox-thumb" class="fancy_box"><img src="${ctx}/static/uploads/gallery/thumb-50x57/${image.imageUrl}" width="50px"/></a></td>
                    <td><a href="#">${image.title}</a></td>
                    <td><a href="${ctx}/static/uploads/gallery/thumb-50x57/${image.imageUrl}" class="opener" value="${image.description}">点击查看</a> </td>
                    <td><a href="${ctx}/static/uploads/gallery/gallery-big/${image.imageUrl}">${image.imageUrl}</a></td>
                    <td><joda:format value="${image.createdDate}" pattern="yyyy年MM月dd日 hh:mm:ss"/></td>
                    <td><c:choose><c:when test="${image.showIndex}"><a href="${ctx}/gallery/showIndex/${image.id}"><span class="label label-success">显示</span></a></c:when><c:otherwise><a href="${ctx}/gallery/showIndex/${image.id}"><span class="label label-important">不显示</span></a></c:otherwise></c:choose></td>
                    <td><a href="${ctx}/gallery/edit/${image.id}">【编辑】</a><a href="${ctx}/gallery/delete/${image.id}" class="delete">【删除】</a></td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
        </form:form>
        <div class="control-group" style="float:left">
            <div class="controls">
                <button class="btn btn-primary" id="auditAll"><i class="icon-flag icon-white"></i> 批量审核</button>
                <button class="btn btn-primary" id="deleteAll"><i class="icon-remove icon-white"></i> 批量删除</button>
            </div>
        </div>
        <!-- 分页 -->
        <div class="pagination pagination-right">
            <ul id="pagination">
                <c:forEach begin="1" end="${total/6>11?11:1+total/6}" step="1" varStatus="var">
                    <li><a href="#">${var.index}</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/static/js/fancyBox/jquery.mousewheel-3.0.6.pack.js"></script>
<script type="text/javascript" src="${ctx}/static/js/fancyBox/jquery.fancybox.pack.js?v=2.0.5"></script>
<script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.js?v=2.0.5"></script>
<script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.js?v=2.0.5"></script>
<script type="text/javascript">
    function ChangeDateFormat(cellval) {
        var date = new Date(parseInt(cellval + 3600000, 10));
        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
        var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
        //var hour = date.getHours();
        //var min = date.getMinutes();
        //var sec = date.getSeconds();
        return date.getFullYear() + "年" + month + "月" + currentDate + "日";// + hour + ":" + min + ":" + sec;
    }

    $(function () {
        var articles = $("#image_load");
        var pager = $("#pagination");
        pager.find("li:first").addClass('active');
        PageClick = function (pageIndex, total, spanInterval) {
            //索引从1开始
            //将当前页索引转为int类型
            var intPageIndex = parseInt(pageIndex);
            var limit = 6;//每页显示文章数量

            $.ajax({
                url:"${ctx}/gallery/listAll/ajax?offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,// TODO sort & direction
                timeout:3000,
                success:function (data) {
                    //加载文章
                    articles.html("");
                    $.each(data, function (index, content) {
                        var htmlStr="<tr><td><input type='checkbox' name='isSelected' value='" + content.id + "'></td><td><a href='${ctx}/static/uploads/gallery/gallery-big/" + content.imageUrl + "' rel='fancybox-thumb' class='fancy_box'><img src='${ctx}/static/uploads/gallery/thumb-50x57/" + content.imageUrl + "' width='50px'/></a></td><td><a href='#'>" + content.title + "</a></td><td><a href='${ctx}/static/uploads/gallery/thumb-50x57/" + content.imageUrl + "' class='opener' value='" + content.description + "'>点击查看</a> </td><td><a href='${ctx}/static/uploads/gallery/gallery-big/" + content.imageUrl + "'>" + content.imageUrl + "</a></td><td>" + ChangeDateFormat(content.createdDate) + "</td>";
                        if (content.showIndex)
                            htmlStr+="<td><a href='${ctx}/gallery/showIndex/" + content.id + "'><span class='label label-success'>显示</span></a></td>";
                        else
                            htmlStr+="<td><a href='${ctx}/gallery/showIndex/" + content.id + "'><span class='label label-important'>不显示</span></a></td>";
                        htmlStr+="<td><a href='${ctx}/gallery/edit/" + content.id + "'>【编辑】</a><a href='${ctx}/gallery/delete/${image.id}' class='delete'>【删除】</a></td></tr>";
                        articles.append($(htmlStr));
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

        $('#auditAll').click(function () {
            if (confirm("确定批量审核吗？")) {
                $("#articleForm").attr("action", "${ctx}/article/batchAudit").submit();
                alert("操作成功，请等待缓存失效！");
            } else {
                return false;
            }
        });
	
        $('#deleteAll').click(function () {
            if (confirm("确定批量删除吗？")) {
                $("#articleForm").attr("action", "${ctx}/article/batchDelete").submit();
                alert("操作成功，请等待缓存失效！");
            } else {
                return false;
            }
        });
	
        $(".fancy_box").fancybox({
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
</body>
</html>