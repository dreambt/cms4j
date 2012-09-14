<%--
  上传图片到相册
  User: baitao.jibt@gmail.com
  Date: 12-8-27
  Time: 下午16:00
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>上传活动图片</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/jquery-validation/validate.min.css">
</head>
<body>
<div class="row">
    <div class="span12">
    <form:form id="image" modelAttribute="image" action="${ctx}/gallery/${action}" method="post" enctype="multipart/form-data" cssClass="form-horizontal">
        <div class="control-group">
            <label class="control-label" for="upload">图片标题</label>
            <div class="controls">
                <input id="picID" type="hidden" name="id" value="${image.id}" />
                <input type="file" id="upload" name="file" value="" alt="${image.imageUrl}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="title">图片标题</label>
            <div class="controls">
                <input type="text" class="required" id="title" name="title" size="52" value="${image.title}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="showIndex">首页展示</label>
            <div class="controls">
                <input type="checkbox" id="showIndex" name="showIndex" value="${image.showIndex}" <c:if test="${image.showIndex}">checked="checked"</c:if>>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="description">描述信息</label>
            <div class="controls">
                <textarea class="required" id="description" name="description" style="width:750px" rows="8">${image.description}</textarea>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <button class="btn btn-primary" id="publish" type="submit"><i class="icon-ok icon-white"></i> 确 定</button>
                <button class="btn" type="reset"><i class="icon-refresh"></i> 重 置</button>
            </div>
        </div>
    </form:form>
    </div>
</div>
<script type="text/javascript" src="${ctx}/static/js/jquery-validation/jquery.validate.min.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/static/js/jquery-validation/messages_cn.js" charset="utf-8"></script>
<script type="text/javascript">
    $(function () {
        //上传时选择文件校验
        $('#upload').live('change', function () {
            $(this).attr('alt',$(this).val());
            if(!checkType($('#upload').val())){ alert("不能上传非gif、jpg、png、bmp类型的文件！请重新选择要上传的图片文件！"); return false;}
        });

        //检验上传文件是否是图片
        function checkType(uploadDom){
            var c=(uploadDom.substr(uploadDom.length -5)).substr((uploadDom.substr(uploadDom.length -5)).indexOf('.')+1).toLowerCase();
            if(c=='gif'||c=='jpg'||c=='png'||c=="bmp"){
                return true;
            }else{
                return false;
            }
        }

         //如果新上传则必须要选择图片
        $('#submit').click(function(){
            var altVal=$('#upload').attr('alt');
            if($('#picID').val()==""){  //新增
                //alert("add");
                if(!checkType(altVal)){ //是否选取上传文件，及其是否是图片
                    alert("请您选择要上传的图片再提交！");
                    return false;
                }
            }else{//修改
                //alert("modify");
                altVal=$('#upload').attr('alt');
                //alert(altVal);
                if(!checkType(altVal)){
                    alert("请您选择要上传的图片再提交！");
                    return false;
                }
            }
        });

        //表单校验
       $('form#image').validate({
            event:'submit'
       });
    });
</script>
</body>
</html>