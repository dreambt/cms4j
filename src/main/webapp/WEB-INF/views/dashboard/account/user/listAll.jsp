<%--
  查看所有用户
  User: baitao.jibt@gmail.com
  Date: 12-8-26
  Time: 下午15:53
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

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
                        <td>${user.email} <c:if test="${user.emailStatus}"><i class='icon-ok'></i></c:if></td>
                        <td><c:forEach items="${user.groupList}" begin="0" step="1" var="group">${group.groupName} </c:forEach></td>
                        <td><joda:format value="${user.createdDate}" pattern="yyyy年MM月dd日"/></td>
                        <td><joda:format value="${user.lastTime}" pattern="yyyy年MM月dd日 kk:mm:ss"/></td>
                        <td>${user.lastLoginIP}</td>
                        <td><c:choose><c:when test="${user.status}"><span id="${user.id}" class="label label-success audit">已审核</span></c:when><c:otherwise><span id="${user.id}" class="label label-important audit">未审核</span></c:otherwise></c:choose></td>
                        <td><a href="${ctx}/account/user/repass/${user.id}"><span class='label label-info'>密码找回</span></a> <a href="${ctx}/account/user/update/${user.id}"><span class='label label-info'>编辑</span></a> <c:choose><c:when test="${user.deleted}"><span id="${user.id}" class="label label-inverse delete">恢复</span></c:when><c:otherwise><span id="${user.id}" class="label label-warning delete">删除</span></c:otherwise></c:choose></td>
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
                <c:forEach begin="1" end="${total/10>11?11:0.9+total/10}" step="1" varStatus="var">
                    <li><a href="#">${var.index}</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<script type="text/javascript">
    function buttonClick(){
        $(".audit").click(function(){
            PostByAjax("${ctx}/account/user/audit/"+$(this).attr("id"));
        });
        $(".delete").click(function(){
            PostByAjax("${ctx}/account/user/delete/"+$(this).attr("id"));
        });
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
                url:"${ctx}/account/user/listAll.json?offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,// TODO sort & direction
                timeout:3000,
                success:function (data) {
                    //加载文章
                    articles.html("");
                    $.each(data, function (index, content) {
                        var htmlStr="<tr><td><input type='checkbox' name='isSelected' value='" + content.id + "'></td><td>" + content.username + "</td><td>" + content.email;
                        if (content.emailStatus)
                            htmlStr+=" <i class='icon-ok'></i>";
                        htmlStr+="</td><td>" + content.groupList[0].groupName + "</td><td>" +ChangeDateFormat(content.createdDate) + "</td><td>" + ChangeDateTimeFormat(content.lastTime) + "</td><td>" + content.lastLoginIP + "</td>";
                        if (content.status)
                            htmlStr+="<td><span id='"+ content.id +"' class='label label-success audit'>已审核</span></td>";
                        else
                            htmlStr+="<td><span id='"+ content.id +"' class='label label-important audit'>未审核</span></td>";
                        htmlStr+="<td><a href='${ctx}/account/user/repass/" + content.id + "'><span class='label label-info'>密码找回</span></a> <a href='${ctx}/account/user/update/" + content.id + "'><span class='label label-info'>编辑</span></a> ";
                        if (content.deleted)
                            htmlStr+="<span id='"+ content.id +"' class='label label-inverse delete'>恢复</span></td></tr>";
                        else
                            htmlStr+="<span id='"+ content.id +"' class='label label-warning delete'>删除</span></td></tr>";
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
                                return false;
                            });
                            pager.append(a);
                        } //else
                    } //for
                    buttonClick();
                }
            });
        };
        $("#pagination li").click(function () {
            PageClick($(this).text(), ${total}, 5);
            return false;
        });
        buttonClick();
        $('#auditAll').click(function () {
            if (confirm("确定批量审核吗？")) {
                $("#articleForm").attr("action", "${ctx}/account/user/batchAudit").submit();
            } else {
                return false;
            }
        });
        $('#deleteAll').click(function () {
            if (confirm("确定批量删除吗？")) {
                $("#articleForm").attr("action", "${ctx}/account/user/batchDelete").submit();
            } else {
                return false;
            }
        });
    });
</script>
</body>
</html>