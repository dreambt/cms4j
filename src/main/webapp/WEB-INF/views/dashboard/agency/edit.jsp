<%--
  添加研究所.
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-4-23
  Time: 下午3:49
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>添加机构</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/jquery-validation/validate.min.css">
</head>
<body>
<div class="row">
    <div class="span12">
    <form:form id="agency" modelAttribute="agency" action="${ctx}/agency/${action}" method="post" enctype="multipart/form-data" cssClass="form-horizontal">
        <div class="control-group">
            <label class="control-label" for="upload">研究所图片</label>
            <div class="controls">
                <input id="picID" type="hidden" name="id" value="${agency.id}"/>
                <input type="file" id="upload" name="file" alt="${agency.imageUrl}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="title">研究所名称</label>
            <div class="controls">
                <input type="text" class="required" id="title" name="title" size="52" value="${agency.title}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="introduction">研究所描述</label>
            <div class="controls">
                <textarea type="text" class="required" id="introduction" name="introduction" style="width:750px" rows="8">${agency.introduction}</textarea>
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
<script type="text/javascript ">
    $(function(){
        $('form#agency').validate({
            event:'submit'
        });
        //上传时选择文件校验
        $('#upload').live('change', function () {
            $(this).attr('alt',$(this).val());
            if(!checkType($('#upload').val())){ alert("不能上传非gif、jpg、png、bmp类型的文件！请重新选择要上传的图片文件！");}else{
            }
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
    })
</script>
</body>
</html>