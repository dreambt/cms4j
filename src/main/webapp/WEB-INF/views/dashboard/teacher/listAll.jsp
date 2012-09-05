<%--
  教师列表
  User: baitao.jibt@gmail.com
  Date: 12-8-25
  Time: 下午21:25
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>教师列表</title>
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.css?v=2.0.5" type="text/css" media="screen" />
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.css?v=2.0.5" type="text/css" media="screen" />
</head>
<body>
<div class="row">
    <div class="span12">
        <form:form id="imageList" name="imageList" method="post">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>选择</th>
                    <th>缩略图</th>
                    <th>姓名</th>
                    <th>所属机构</th>
                    <th>URL</th>
                    <th>添加时间</th>
                    <th>首页显示</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${teachers}"  var="teacher" begin="0" step="1" varStatus="stat">
                    <tr>
                        <td><input type="checkbox" name="isSelected"  value="${teacher.id}"></td>
                        <td><a href="${ctx}/static/uploads/teacher/${teacher.imageUrl}" rel="fancybox-thumb" class="fancy_box"><img src="${ctx}/static/uploads/teacher/${teacher.imageUrl}" width="50px"/></a></td>
                        <td><a href="${ctx}/article/content/${teacher.article.id}" target="_blank">${teacher.teacherName}</a></td>
                        <td><a href="${ctx}/agency/show/${teacher.agency.id}" target="_blank">${teacher.agency.title}</a> </td>
                        <td><a href="${ctx}/static/uploads/teacher/${teacher.imageUrl}">${teacher.imageUrl}</a></td>
                        <td><joda:format value="${teacher.createdDate}" pattern="yyyy年MM月dd日 hh:mm:ss"/></td>
                        <td><a href="${ctx}/teacher/showIndex/${teacher.id}"><c:choose><c:when test="${teacher.top eq true}">显示</c:when><c:otherwise>不显示</c:otherwise></c:choose></a></td>
                        <td><a href="${ctx}/teacher/edit/${teacher.id}">【编辑】</a> <c:if test="${teacher.deleted eq true}"> <a href="${ctx}/teacher/delete/${teacher.id}">【恢复】</a></c:if>
                            <c:if test="${teacher.deleted eq false}"> <a href="${ctx}/teacher/delete/${teacher.id}">【删除】</a></c:if></td>
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
<script type="text/javascript" src="${ctx}/static/js/fancyBox/jquery.mousewheel-3.0.6.pack.js"></script>
<script type="text/javascript" src="${ctx}/static/js/fancyBox/jquery.fancybox.pack.js?v=2.0.5"></script>
<script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.js?v=2.0.5"></script>
<script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.js?v=2.0.5"></script>
<script type="text/javascript">
    $(document).ready(function() {
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

        $('#deleteAll').click(function () {
            if (confirm("确定批量删除吗？")) {
                $("#imageList").attr("action", "${ctx}/teacher/batchDelete").submit();
            } else {
                return false;
            }
        });

        $('.delete').click(function(){
            if(confirm('确定删除？')){
                return true;
            }else{
                return false;
            }
        });
    });
</script>
</body>
</html>