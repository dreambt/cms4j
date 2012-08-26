<%--
  查看所有用户
  User: baitao.jibt@gmail.com
  Date: 12-8-26
  Time: 下午15:53
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>用户列表</title>
</head>
<body>
<div class="row">
    <div class="span12">
        <form:form modelAttribute="article" id="articleForm" method="post">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>选择</th>
                    <th>用户名</th>
                    <th>邮箱</th>
                    <th>用户组</th>
                    <th>创建时间</th>
                    <th>最后登录时间</th>
                    <th>最后登录IP</th>
                    <th>审核状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="article_load">
                <c:forEach items="${users}" var="user" begin="0" step="1" varStatus="stat">
                    <tr>
                        <td><input type="checkbox" name="isSelected" value="${user.id}"></td>
                        <td>${user.username}</td>
                        <td>${user.email} <c:choose><c:when test="${user.emailStatus}"><i class='icon-ok'></i></c:when><c:otherwise><i class='icon-remove'></i></c:otherwise></c:choose>
                        </td>
                        <td><c:forEach items="${user.groupList}" begin="0" step="1" var="group">${group.groupName} </c:forEach></td>
                        <td><fmt:formatDate value="${user.createdDate}" type="both"/></td>
                        <td><fmt:formatDate value="${user.lastTime}" type="both"/></td>
                        <td>${user.lastLoginIP}</td>
                        <td><a href="${ctx}/account/user/audit/${user.id}"><c:choose><c:when test="${user.status}"><span class="label label-success">已审核</span></c:when><c:otherwise><span class="label label-important">未审核</span></c:otherwise></c:choose></a></td>
                        <td><a href="${ctx}/account/user/repass/${user.id}">【密码找回】</a> <a href="${ctx}/account/user/edit/${user.id}">【编辑】</a> <a href="${ctx}/account/user/delete/${user.id}"><c:choose><c:when test="${user.deleted}">【恢复】</c:when><c:otherwise>【删除】</c:otherwise></c:choose></a></td>
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
                <c:forEach begin="1" end="${total/10>11?11:1+total/10}" step="1" varStatus="var">
                    <li><a href="#">${var.index}</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
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
        var articles = $("#article_load");
        var pager = $("#pagination");
        pager.find("li:first").addClass('active');
        PageClick = function (pageIndex, total, spanInterval) {
            //索引从1开始
            //将当前页索引转为int类型
            var intPageIndex = parseInt(pageIndex);
            var limit = 10;//每页显示文章数量

            $.ajax({
                url:"${ctx}/account/user/listAll/ajax?offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,// TODO sort & direction
                timeout:3000,
                success:function (data) {
                    //加载文章
                    articles.html("");
                    $.each(data, function (index, content) {
                        var htmlStr="<tr><td><input type='checkbox' name='isSelected' value='" + content.id + "'></td><td>" + content.username + "</td><td>" + content.email;
                        if (content.emailStatus)
                            htmlStr+=" <i class='icon-ok'></i>";
                        else
                            htmlStr+=" <i class='icon-remove'></i>";
                        htmlStr+="</td><td>" + content.groupList + "</td><td>" + ChangeDateFormat(content.createdDate) + "</td><td>" + ChangeDateFormat(content.lastTime) + "</td><td>" + content.lastLoginIP + "</td>";
                        if (content.status)
                            htmlStr+="<td><a href='${ctx}/account/user/audit/" + content.id + "'><span class='label label-success'>已审核</span></a></td>";
                        else
                            htmlStr+="<td><a href='${ctx}/account/user/audit/" + content.id + "'><span class='label label-important'>未审核</span></a></td>";
                        htmlStr+="<td><a href='${ctx}/account/user/repass/" + content.id + "'>【密码找回】</a> <a href='${ctx}/account/user/edit/" + content.id + "'>【编辑】</a> ";
                        if (content.deleted)
                            htmlStr+="<a href='${ctx}/account/user/delete/" + content.id + "'>【恢复】</a></td></tr>";
                        else
                            htmlStr+="<a href='${ctx}/account/user/delete/" + content.id + "'>【删除】</a></td></tr>"
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
                $("#articleForm").attr("action", "${ctx}/account/user/batchAudit").submit();
                alert("操作成功，请等待缓存失效！");
            } else {
                return false;
            }
        });

        $('#deleteAll').click(function () {
            if (confirm("确定批量删除吗？")) {
                $("#articleForm").attr("action", "${ctx}/account/user/batchDelete").submit();
                alert("操作成功，请等待缓存失效！");
            } else {
                return false;
            }
        });
    });
</script>
</body>
</html>