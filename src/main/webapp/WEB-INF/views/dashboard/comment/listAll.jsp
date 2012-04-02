%--
  评论管理
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-24
  Time: 下午9:03
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>后台评论管理</title>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>附件列表</h2>
        <p>下面列出了所有评论列表，您可以对评论进行<strong>审核</strong>&nbsp;<strong>删除</strong>，误审核的评论可以反审核，误删除的评论可以恢复</p>
        <c:if test="${not empty info}">
            <div id="message" class="alert alert_blue">
                <img height="24" width="24" src="${ctx}/static/dashboard/images/icons/small/white/Locked2.png"><strong>${info}</strong>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div id="message" class="alert alert_red">
                <img height="24" width="24" src="${ctx}/static/dashboard/images/icons/small/white/Locked2.png"><strong>${error}</strong>
            </div>
        </c:if>
    </div>
    </div>
<div class="main_container container_16 clearfix">
    <form:form id="commentForm" name="comment" method="post">
    <div class="box grid_16 round_all">
            <table class="display table">
                <thead>
                <tr>
                    <th>选择</th>
                    <th>文章标题</th>
                    <th>评论者</th>
                    <th>评论内容</th>
                    <th>评论者IP</th>
                    <th>评论时间</th>
                    <th>审核</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${comments}" var="comment" begin="0" step="1" varStatus="status">
                <tr class="gradeB">
                    <td class="center"><input type="checkbox" name="isSelected" value="${comment.id}"></td>
                    <td><a href="${ctx}/article/edit/${comment.article.id}">${comment.article.subject}</a></td>
                    <td>${comment.username}</td>
                    <td><a class="opener" href="#" value='${comment.message}'>点击查看</a></td>
                    <td>${comment.postHostIp}</td>
                    <td><fmt:formatDate value="${comment.createTime}" type="both"></fmt:formatDate></td>
                    <td><a href="${ctx}/comment/audit/${comment.id}"><c:choose><c:when test="${comment.status}">【反审核】</c:when><c:otherwise>【审核】</c:otherwise></c:choose></a></td>
                    <td><a href="${ctx}/comment/delete/${comment.id}"><c:choose><c:when test="${comment.deleted}">【恢复】</c:when><c:otherwise>【删除】</c:otherwise></c:choose></a></td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
    </div>
    <button class="button_colour" id="auditAll"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/small/white/BendedArrowRight.png"><span>批量审核</span></button>
    <button class="button_colour" id="deleteAll"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/small/white/BendedArrowRight.png"><span>批量删除</span></button>
    </form:form>
</div>
<div id="dialog" title="留言内容"></div>
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

    $( "#dialog" ).dialog({
        autoOpen: false,
        width:600,
        maxWidth: 800,
        maxHeight:600,
        show: "fade",
        hide: "fade",
        buttons: {
            Ok: function() {
                $( this ).dialog( "close" );
            }
        },
        modal: true
    });

    $( ".opener" ).click(function() {
        $( "#dialog" ).html($(this).attr("value")).dialog( "open" );
        return false;
    });
</script>
</body>
</html>