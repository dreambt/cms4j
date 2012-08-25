<%--
 相册管理
  User: baitao.jibt@gmail
  Date: 12-8-25
  Time: 下午19:36
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>相册列表</title>
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen" />
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.css?v=2.0.5" type="text/css" media="screen" />
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.css?v=2.0.5" type="text/css" media="screen" />
    <script type="text/javascript" src="${ctx}/static/js/jquery/jquery.mousewheel-3.0.6.pack.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/jquery.fancybox.pack.js?v=2.0.5"></script>
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.js?v=2.0.5"></script>
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.js?v=2.0.5"></script>
</head>
<body>
<div class="row">
    <div class="span12">
        <form id="imageList" name="imageList" method="post">
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
                <tbody>
                <c:forEach items="${images}" var="image" begin="0" step="1">
                <tr>
                    <td><input type="checkbox" name="isSelected"  value="${image.id}"></td>
                    <td><a href="${ctx}/static/uploads/gallery/gallery-big/${image.imageUrl}" rel="fancybox-thumb" class="fancy_box"><img src="${ctx}/static/uploads/gallery/thumb-50x57/${image.imageUrl}" width="50px"/></a></td>
                    <td><a href="#">${image.title}</a></td>
                    <td><a href="${ctx}/static/uploads/gallery/thumb-50x57/${image.imageUrl}" class="opener" value="${image.description}">点击查看</a> </td>
                    <td><a href="${ctx}/static/uploads/gallery/gallery-big/${image.imageUrl}">${image.imageUrl}</a></td>
                    <td><fmt:formatDate value="${image.createdDate}" type="both"></fmt:formatDate></td>
                    <td><c:choose><c:when test="${image.showIndex}"><a href="${ctx}/gallery/showIndex/${image.id}">显示</a></c:when><c:otherwise><a href="${ctx}/gallery/showIndex/${image.id}">不显示</a></c:otherwise></c:choose></td>
                    <td><a href="${ctx}/gallery/edit/${image.id}">【编辑】</a><a href="${ctx}/gallery/delete/${image.id}" class="delete">【删除】</a></td>
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
        </form>
    </div>
</div>
<div class="modal hide fade" id="dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">描述信息</h3>
    </div>
    <div class="modal-body">
        <p>One fine body…</p>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
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
                $("#imageList").attr("action", "${ctx}/gallery/batchDelete").submit();
            } else {
                return false;
            }
        });

        $('.delete').click(function () {
            if (confirm('确定删除？')) {
                return true;
            } else {
                return false;
            }
        });

        //提示信息
        $(".alert").delay(1500).fadeOut("slow");

        $(".opener").click(function () {
            $("#dialog div:eq(1)").html($(this).attr("value"));
            $('#dialog').modal('show');
            return false;
        });
    });
</script>
</body>
</html>