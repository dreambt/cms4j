<%--
  添加和编辑老师
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
    <title>添加和修改老师信息</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/Ueditor/themes/default/ueditor.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/js/jquery-validation/validate.min.css">
    <script type="text/javascript" src="${ctx}/static/Ueditor/editor_config.js"></script>
    <script type="text/javascript" src="${ctx}/static/Ueditor/editor_all.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/tipsy/jquery.tipsy.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-validation/jquery.validate.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/static/js/jquery-validation/messages_cn.js" charset="utf-8"></script>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>编辑老师信息</h2>
        <p><strong>是否置顶</strong> <strong>是否允许评论</strong> , 并填写 <strong>文章标题</strong> 和 <strong>文章内容</strong>.</p>
        <P><strong>请您注意：</strong>发表时插入的图片宽度超过612像素，系统会自动以图片长宽比例将其缩小到宽度为612像素！</P>
        <c:if test="${not empty info}">
            <div id="message" class="alert alert_blue">
                <img height="24" width="24" src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>${info}</strong>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div id="message" class="alert alert_red">
                <img height="24" width="24" src="${ctx}/static/dashboard/images/icons/Locked2.png"><strong>${error}</strong>
            </div>
        </c:if>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <form:form id="teacherForm" modelAttribute="teacher" action="${ctx}/teacher/save/${teacher.id}" method="post" enctype="multipart/form-data">
        <div class="box gird_16">
            <h2 class="box_head grad_colour round_top">编辑老师介绍信息</h2>
            <div class="toggle_container">
                <div class="block">
                    <input type="hidden" name="id" value="${teacher.id}" id="teacherID"/>
                    <input type="hidden" name="article.id" value="${teacher.article.id}" id="articleID"/>
                    <label>上传头像：</label>
                    <input type="file" id="upload" name="file" alt="${teacher.imageUrl}"><br/>
                    <label>老师姓名：</label> <input type="text" id="teacherName" name="teacherName" class="required" original-title="请输入老师姓名" value="${teacher.teacherName}" />
                    <input type="hidden" id="allowComment" value="false"/>
                    <label for="top">是否置顶</label> <input id="top" type="checkbox" name="top" value="${teacher.top}" <c:if test="${teacher.top}">checked="checked"</c:if> />
                    <br />
                    <label>所属研究所</label>
                    <form:select path="agency.id">
                        <c:forEach items="${agencies}" begin="0" step="1" var="agency" varStatus="stat">
                            <option value="${agency.id}" <c:if test="${agency.categoryId eq teacher.agency.categoryId}">selected="selected"</c:if>>${agency.title}</option>
                        </c:forEach>
                    </form:select>
                    <script type="text/plain" id="myEditor">${teacher.article.message}</script>
                    <script type="text/javascript">
                        var editor = new baidu.editor.ui.Editor({
                            textarea: 'article.message',
                            elementPathEnabled:false
                        });
                        editor.render("myEditor");
                    </script>
                </div>
            </div>
        </div>
        <button class="button_colour" id="publish" type="submit"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/BendedArrowRight.png"><span>发 布</span></button>
        <button class="button_colour" type="reset"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/BendedArrowRight.png"><span>草 稿</span></button>
    </form:form>
</div>
<script type="text/javascript">
    var URL = "${ctx}/../..";
    $(function () {
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
</html>>