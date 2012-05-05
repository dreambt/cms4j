<%--
  机构管理列表
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-4-23
  Time: 下午3:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="${ctx}/static/jquery/jquery.mousewheel-3.0.6.pack.js"></script>

    <!-- Add fancyBox -->
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen"/>
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/jquery.fancybox.pack.js?v=2.0.5"></script>

    <!-- Optionally add button and/or thumbnail helpers -->
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.css?v=2.0.5" type="text/css"  media="screen"/>
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.js?v=2.0.5"></script>

    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.css?v=2.0.5" type="text/css" media="screen"/>
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.js?v=2.0.5"></script>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>研究所管理列表</h2>

        <p>研究所管理列表</p>
        <c:if test="${not empty info}">
            <div id="message" class="alert alert_blue">
                <img height="24" width="24"
                     src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>${info}</strong>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div id="message" class="alert alert_red">
                <img height="24" width="24"
                     src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>${error}</strong>
            </div>
        </c:if>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <form id="imageList" name="imageList" method="post">
        <div class="box grid_16 round_all">
            <table class="display table">
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
                <td><fmt:formatDate value="${agency.createdDate}" type="both"></fmt:formatDate></td>
                <td><fmt:formatDate value="${agency.createdDate}" type="both"></fmt:formatDate></td>
                <td><a href="${ctx}/agency/edit/${agency.id}"class="edit">【编辑】</a><a href="${ctx}/agency/delete/${agency.id}" class="delete">【删除】</a></td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </form>
    <div id="dialog" title="描述详情"></div>
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
        //提示信息
        $(".alert").delay(1500).fadeOut("slow");
        //查看详细描述
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
    });
</script>
</body>
</html>