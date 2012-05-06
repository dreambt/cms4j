<%--
  老师管理列表
  User: dengxiaolan(824688439@qq.com)
  Date: 12-4-27
  Time: 上午11:49.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>相册管理列表</title>
    <script type="text/javascript" src="${ctx}/static/jquery/jquery.mousewheel-3.0.6.pack.js"></script>

    <!-- Add fancyBox -->
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/jquery.fancybox.pack.js?v=2.0.5"></script>

    <!-- Optionally add button and/or thumbnail helpers -->
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.css?v=2.0.5" type="text/css" media="screen" />
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.js?v=2.0.5"></script>

    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.css?v=2.0.5" type="text/css" media="screen" />
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.js?v=2.0.5"></script>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>老师列表</h2>

        <p>老师列表</p>
        <c:if test="${not empty info}">
            <div id="info" class="alert alert_blue">
                <img height="24" width="24"
                     src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>${info}</strong>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div id="error" class="alert alert_red">
                <img height="24" width="24"
                     src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>${error}</strong>
            </div>
        </c:if>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <form:form id="imageList" name="imageList" method="post">
        <div class="box grid_16 round_all">
            <table class="display table">
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
                        <td><a href="${ctx}/agency/show/${teacher.agencyId}" target="_blank">${teacher.agency.title}</a> </td>
                        <td><a href="${ctx}/static/uploads/teacher/${teacher.imageUrl}">${teacher.imageUrl}</a></td>
                        <td><fmt:formatDate value="${teacher.createdDate}" type="both"></fmt:formatDate></td>
                        <td><a href="${ctx}/teacher/showIndex/${teacher.id}"><c:choose><c:when test="${teacher.top eq true}">显示</c:when><c:otherwise>不显示</c:otherwise></c:choose></a></td>
                        <td><a href="${ctx}/teacher/edit/${teacher.id}">【编辑】</a> <c:if test="${teacher.deleted eq true}"> <a href="${ctx}/teacher/delete/${teacher.id}">【恢复】</a></c:if>
                            <c:if test="${teacher.deleted eq false}"> <a href="${ctx}/teacher/delete/${teacher.id}">【删除】</a></c:if></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <button class="button_colour" id="deleteAll"><img height="24" width="24" alt="Bended Arrow Right"
                                                          src="${ctx}/static/dashboard/images/icons/BendedArrowRight.png"/><span>批量删除</span>
        </button>
    </form:form>
</div>
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
        //提示信息
        $(".alert").delay(1500).fadeOut("slow");
    });
</script>
</body>
</html>