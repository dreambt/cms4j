<%--
  机构列表
  User: baitao.jibt@gmail.com
  Date: 12-8-25
  Time: 下午21:23
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>机构列表</title>
    <link rel="stylesheet" href="${ctx}/static/fancyBox/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen"/>
    <link rel="stylesheet" href="${ctx}/static/fancyBox/helpers/jquery.fancybox-buttons.css?v=2.0.5" type="text/css"  media="screen"/>
    <link rel="stylesheet" href="${ctx}/static/fancyBox/helpers/jquery.fancybox-thumbs.css?v=2.0.5" type="text/css" media="screen"/>
</head>
<body>
<div class="row">
    <div class="span12">
        <form id="imageList" name="imageList" method="post">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>选择</th>
                    <th>banner</th>
                    <th>研究所名</th>
                    <th>描述</th>
                    <th>创建时间</th>
                    <th>最后修改时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${agencies}" var="agency" begin="0" step="1" varStatus="stat">
                <tr>
                <td><input type="checkbox" name="isSelected"  value=""></td>
                <td><a href="${ctx}/static/uploads/agency/${agency.imageUrl}" rel="fancybox-thumb" class="fancy_box"><img src="${ctx}/static/uploads/agency/${agency.imageUrl}" width="80px" height="30px"/></a></td>
                <td><a href="${ctx}/agency/show/${agency.id}" target="_blank">${agency.title}</a></td>
                <td><a href="#" class="opener" value="${agency.introduction}">点击查看</a> </td>
                <td><joda:format value="${agency.createdDate}" pattern="yyyy年MM月dd日"/></td>
                <td><joda:format value="${agency.lastModifiedDate}" pattern="yyyy年MM月dd日 kk:mm:ss"/></td>
                <td><a href="${ctx}/agency/update/${agency.id}" class="edit">【编辑】</a>
                    <a href="${ctx}/agency/delete/${agency.id}"><c:choose><c:when test="${agency.deleted}">【恢复】</c:when><c:otherwise>【删除】</c:otherwise></c:choose></a>
                </td>
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
<script type="text/javascript" src="${ctx}/min?t=js&f=/fancyBox/jquery.mousewheel-3.0.6.pack.js,/fancyBox/jquery.fancybox.pack.js,/fancyBox/helpers/jquery.fancybox-buttons.js,/fancyBox/helpers/jquery.fancybox-thumbs.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $(".fancy_box").fancybox({
            prevEffect:'none',
            nextEffect:'none',
            helpers:{
                title:{
                    type:'float'
                },
                thumbs:{
                    width:80,
                    height:30
                }
            }
        });

        $('.delete').click(function(){
            if(confirm('确定删除？')){
                return true;
            }else{
                return false;
            }
        });

        $(".opener").click(function () {
            $("#dialog div:eq(1)").html($(this).attr("value"));
            $('#dialog').modal('show');
            return false;
        });
    });
</script>
</body>
</html>