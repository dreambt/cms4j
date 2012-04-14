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
    <script type="text/javascript" src="${ctx}/static/jquery-validation/1.9.0/jquery.validate.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/jquery-validation/1.9.0/messages_cn.js" charset="utf-8"></script>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>上传活动图片</h2>

        <p>上传活动图片</p>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <form:form id="image" modelAttribute="image" action="${ctx}/gallery/save/${image.id}" method="post"
               enctype="multipart/form-data">
        <div class="box grid_16">
            <h2 class="box_head grad_colour round_top">上传活动图片</h2>

            <div class="toggle_container">
                <div class="info" style="float:left;margin-left: 15%;margin-top: 15px;">
                    <input type="hidden" name="id" value="${image.id}" />
                    <input type="file" id="upload" name="file"><br> <br>
                    图片标题：<br/><input type="text" class="required" name="title" size="52" value="${image.title}"> <br/> <br/>
                    首页展示：<input type="checkbox" name="showIndex" style="float: none" value="${image.showIndex}" <c:if test="${image.showIndex}">checked="checked"</c:if>>  <br/> <br/>
                    描述：<br/><textarea type="text" class="required" name="description" cols="55" rows="5">${image.description}</textarea>
                    <br/><br/>
                    <!--<img src="#" style="display: block;float: left;">-->
                </div>
            </div>
        </div>
        <button type="submit" style="margin-left: 23%;width: 100px;">提交</button>
    </form:form>
</div>
<script type="text/javascript">
    $(function () {
        $('#upload').live('change', function () {
            var b= $(this).val();
            var c=(b.substr(b.length -5)).substr((b.substr(b.length -5)).indexOf('.')+1).toLowerCase();
            if(c=='gif'||c=='jpg'||c=='png'||c=="bmp"){
               return true;
            }else{
                alert("不能上传非gif、jpg、png、bmp类型的文件！请重新选择要上传的图片文件！");
                return false;
            }
        });
       $('form#image').validate({
            event:'submit'
       });
    });
</script>
</body>
</html>