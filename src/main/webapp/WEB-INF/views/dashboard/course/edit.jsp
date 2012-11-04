<%--
   添加课程
  User: baitao.jibt@gmail.com
  Date: 12-10-30
  Time: 下午14:58
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>课程管理 - 添加课程</title>
</head>
<body>
<div class="row">
    <form:form id="courseForm" modelAttribute="course" action="${ctx}/course/${action}" method="post" cssClass="form-horizontal">
        <div class="control-group">
            <label class="control-label" for="courseName">课程名称</label>
            <div class="controls">
                <input type="hidden" name="id" value="${course.id}">
                <input type="text" id="courseName" name="courseName" value="${course.courseName}" placeholder="${course.courseName}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="courseType">课程类型</label>
            <div class="controls">
                <select id="courseType" name="courseType">
                    <option value="${course.courseType}" selected="selected">${course.courseType}</option>
                    <option value="脱产班">脱产班</option>
                    <option value="周末班">周末班</option>
                </select>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="courseDate">开课日期</label>
            <div class="controls date">
                <input type="text" id="courseDate" name="courseDate" value="${course.courseDate}" placeholder="${course.courseDate}" readonly>
            </div>
        </div>
        <%--<div class="control-group">--%>
            <%--<label class="control-label" for="courseTime">开课时间</label>--%>
            <%--<div class="controls">--%>
                <%--<input type="text" id="courseTime" name="courseTime" value="${course.courseTime}" placeholder="${course.courseTime}">--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="control-group">
            <label class="control-label" for="courseDays">课时</label>
            <div class="controls">
                <input type="text" id="courseDays" name="courseDays" value="${course.courseDays}" placeholder="${course.courseDays}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="coursePrice">价格</label>
            <div class="controls">
                <input type="text" id="coursePrice" name="coursePrice" value="${course.coursePrice}" placeholder="${course.coursePrice}">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="allowApply">允许申请</label>
            <div class="controls">
                <input type="checkbox" id="allowApply" name="allowApply" <c:if test="${course.allowApply==true}">checked="checked"</c:if>> 允许申请
                <input type="hidden" name="_allowApply"/>
                <input type="checkbox" id="opened" name="opened" <c:if test="${course.opened==true}">checked="checked"</c:if>> 已开课
                <input type="hidden" name="_opened"/>
                <input type="checkbox" id="top" name="top" <c:if test="${course.top==true}">checked="checked"</c:if>> 置顶
                <input type="hidden" name="_top"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="editor_1">课程描述</label>
            <div class="controls">
                <textarea id="editor_1" class="editor" name="description1" style="width:670px;height:250px;">${course.description1}</textarea>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="editor_2">涛峰优势</label>
            <div class="controls">
                <textarea id="editor_2" class="editor" name="description2" style="width:670px;height:250px;">${course.description2}</textarea>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="editor_3">招生对象</label>
            <div class="controls">
                <textarea id="editor_3" class="editor" name="description3" style="width:670px;height:250px;">${course.description3}</textarea>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="editor_4">费用优惠</label>
            <div class="controls">
                <textarea id="editor_4" class="editor" name="description4" style="width:670px;height:250px;">${course.description4}</textarea>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="editor_5">课程教材</label>
            <div class="controls">
                <textarea id="editor_5" class="editor" name="description5" style="width:670px;height:250px;">${course.description5}</textarea>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="editor_6">实验设备</label>
            <div class="controls">
                <textarea id="editor_6" class="editor" name="description6" style="width:670px;height:250px;">${course.description6}</textarea>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="editor_7">任职岗位</label>
            <div class="controls">
                <textarea id="editor_7" class="editor" name="description7" style="width:670px;height:250px;">${course.description7}</textarea>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="editor_8">课程大纲</label>
            <div class="controls">
                <textarea id="editor_8" class="editor" name="description8" style="width:670px;height:250px;">${course.description8}</textarea>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="editor_9">实训项目</label>
            <div class="controls">
                <textarea id="editor_9" class="editor" name="description9" style="width:670px;height:250px;">${course.description9}</textarea>
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
<script charset="utf-8" src="${ctx}/static/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="${ctx}/static/kindeditor/lang/zh_CN.js"></script>
<script type="text/javascript">
$(function () {
    // 时间选择
    $("#courseDate").datepicker({
        format:'yyyy-mm-dd',
        autoclose:true
    });
});
KindEditor.ready(function(K) {
    K.create('.editor', {
        uploadJson : '/jsp/upload_json.jsp',
        fileManagerJson : '/jsp/file_manager_json.jsp',
        allowFileManager : true
    });
});
</script>
</body>
</html>