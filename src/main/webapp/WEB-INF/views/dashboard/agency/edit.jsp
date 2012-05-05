<%--
  添加研究所.
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-4-23
  Time: 下午3:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>添加机构</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/jquery-validation/1.9.0/validate.min.css">
    <script type="text/javascript" src="${ctx}/static/jquery-validation/1.9.0/jquery.validate.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/jquery-validation/1.9.0/messages_cn.js" charset="utf-8"></script>
</head>

<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_10">
        <h2>添加研究所</h2>
        <p>添加研究所，上传的研究所banner图片的规格为：<strong>920px*196px</strong></p>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <form:form id="agency" modelAttribute="agency" action="${ctx}/agency/save/${agency.id}" method="post" enctype="multipart/form-data">
        <div class="box grid_16">
            <h2 class="box_head grad_colour round_top">添加研究所</h2>
            <div class="toggle_container">
                <div class="info" style="float:left;margin-left: 15%;margin-top: 15px;">
                    <input id="picID" type="hidden" name="id" value="${agency.id}"/>
                    研究所图片：<br/><input type="file" id="upload" name="file" alt="${agency.imageUrl}"><br> <br>
                    研究所名称：<br/><input type="text" class="required" name="title" size="52" value="${agency.title}"> <br/> <br/>
                    研究所描述：<br/><textarea type="text" class="required" name="introduction" cols="55" rows="5">${agency.introduction}</textarea>
                    <br/> <br/>
                    <br/><br/>
                    <!--<img src="#" style="display: block;float: left;">-->
                </div>
            </div>
        </div>
        <button type="submit" style="margin-left: 23%;width: 100px;" id="submit">提交</button>
    </form:form>
</div>
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