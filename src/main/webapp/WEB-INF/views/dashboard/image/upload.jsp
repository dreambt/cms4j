<%--
 上传图片到相册
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-4-2
  Time: 下午8:24
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>上传活动图片</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/Ueditor/themes/default/ueditor.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-validation/1.9.0/validate.min.css">
    <script type="text/javascript" src="${ctx}/static/Ueditor/editor_config.js"></script>
    <script type="text/javascript" src="${ctx}/static/Ueditor/editor_all.js"></script>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>上传活动图片</h2>

        <p>上传活动图片</p>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <form method="get" action="#">
        <div class="box grid_16 round_all">
            <script type="text/plain" id="myEditor" name="myEditor"style="width:1000px">
                <p>这里我可以写一些输入提示<img src="#" alt=""></p>
            </script>
        </div>
    </form>
</div>
<script type="text/javascript">
    var editor_a = new baidu.editor.ui.Editor();
    editor_a.render( 'myEditor' );
</script>
    </body>
</html>