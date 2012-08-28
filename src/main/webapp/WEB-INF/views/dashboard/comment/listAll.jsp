%--
评论管理
  User: baitao.jibt@gmail.com
  Date: 12-8-25
  Time: 下午21:25
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>评论列表</title>
</head>
<body>
<div class="row">
    <div class="span12">
        <form:form id="commentForm" name="comment" method="post">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>选择</th>
                    <th>文章标题</th>
                    <th>评论者</th>
                    <th>评论内容</th>
                    <th>评论者IP</th>
                    <th>评论时间</th>
                    <th>审核状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${comments}" var="comment" begin="0" step="1" varStatus="status">
                    <tr class="gradeB">
                        <td class="center"><input type="checkbox" name="isSelected" value="${comment.id}"></td>
                        <td><a href="${ctx}/article/content/${comment.article.id}" target="_blank">${comment.article.subject}</a></td>
                        <td>${comment.username}</td>
                        <td><a class="opener" href="#" value='${comment.message}'>点击查看</a></td>
                        <td>${comment.postHostIP}</td>
                        <td><joda:format value="${comment.createdDate}" pattern="yyyy年MM月dd日 hh:mm:ss"/></td>
                        <td><a href="${ctx}/comment/audit/${comment.id}"><c:choose><c:when test="${comment.status}"><span class="green_text">已审核</span></c:when><c:otherwise><span class="red_text">未审核</span></c:otherwise></c:choose></a></td>
                        <td><a href="${ctx}/comment/delete/${comment.id}"><c:choose><c:when test="${comment.deleted}">【恢复】</c:when><c:otherwise>【删除】</c:otherwise></c:choose></a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="control-group">
                <div class="controls">
                    <button class="btn btn-primary" id="auditAll"><i class="icon-flag icon-white"></i> 批量审核</button>
                    <button class="btn btn-primary" id="deleteAll"><i class="icon-remove icon-white"></i> 批量删除</button>
                </div>
            </div>
        </form:form>
    </div>
</div>
<div class="modal hide fade" id="dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">留言内容</h3>
    </div>
    <div class="modal-body">
        <p>One fine body…</p>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    </div>
</div>
<script type="text/javascript">
    $(".alert").delay(1500).fadeOut("slow");

    $('#auditAll').click(function () {
        if (confirm("确定批量审核吗？")) {
            $("#commentForm").attr("action", "${ctx}/comment/batchAudit").submit();
        } else {
            return false;
        }
    });
    $('#deleteAll').click(function () {
        if (confirm("确定批量删除吗？")) {
            $("#commentForm").attr("action", "${ctx}/comment/batchDelete").submit();
        } else {
            return false;
        }
    });

    $(".opener").click(function () {
        $("#dialog div:eq(1)").html($(this).attr("value"));
        $('#dialog').modal('show');
        return false;
    });
</script>
</body>
</html>