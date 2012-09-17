<%--
  添加和编辑教师
  User: dengxiaolan(824688439@qq.com)
  Date: 12-4-27
  Time: 上午11:49.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>修改教师</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/validation/validate.min.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/markitup/style.min.css">
</head>
<body>
<form:form id="teacherForm" modelAttribute="teacher" action="${ctx}/teacher/${action}" method="post" enctype="multipart/form-data" cssClass="form-horizontal">
<div class="row">
    <div class="span4">
        <div class="control-group">
            <label class="control-label" for="upload">上传头像</label>
            <div class="controls">
                <input type="hidden" name="id" value="${teacher.id}" id="teacherID"/>
                <input type="hidden" name="article.id" value="${teacher.article.id}" id="articleID"/>
                <input type="file" id="upload" name="file" alt="${teacher.imageUrl}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="teacherName">教师姓名</label>
            <div class="controls">
                <input type="text" id="teacherName" name="teacherName" class="required" original-title="请输入老师姓名" placeholder="${teacher.teacherName}" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="top">是否置顶</label>
            <div class="controls">
                <input id="top" type="checkbox" name="top" value="${teacher.top}" <c:if test="${teacher.top}">checked="checked"</c:if> />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">所属研究所</label>
            <div class="controls">
                <form:select path="agency.id">
                    <c:forEach items="${agencies}" begin="0" step="1" var="agency" varStatus="stat">
                        <option value="${agency.id}" <c:if test="${agency.categoryId eq teacher.agency.categoryId}">selected="selected"</c:if>>${agency.title}</option>
                    </c:forEach>
                </form:select>
            </div>
        </div>
    </div>
    <div class="span8">
        <textarea id="markdown" name="message" style="width:750px" rows="8">${article.message}</textarea>
        <div class="control-group">
            <div class="controls">
                <button class="btn btn-primary" id="publish" type="submit"><i class="icon-ok icon-white"></i> 发 布</button>
                <button class="btn" type="reset"><i class="icon-refresh"></i> 草 稿</button>
            </div>
        </div>
    </div>
</div>
</form:form>
<script type="text/javascript" src="${ctx}/min?t=js&f=/js/jquery.loading.js,/js/jquery.json-2.3.js,/js/markitup/jquery.markitup.js,/js/validation/jquery.validate.js,/js/validation/messages_cn.js" charset="utf-8"></script>
<script type="text/javascript">
    $(function () {
        $('#markdown').markItUp(myMarkdownSettings);

        $("#teacherForm").validate({
            event:'submit',
            rules:{subject:{required:true, maxlength:8}}
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
        $('#publish').click(function(){
            var altVal=$('#upload').attr('alt');
            if($('#teacherID').val()==""){  //新增
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
    });
</script>
</body>
</html>