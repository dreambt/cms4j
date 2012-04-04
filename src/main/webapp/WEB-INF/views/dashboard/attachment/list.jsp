<%--
  附件管理
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-24
  Time: 上午10:40
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>附件管理 - 后台管理</title>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>附件列表</h2>
        <p>下面列出了所有文章列表, 您可以对附件进行<strong>修改</strong> <strong>审核</strong> 和 <strong>删除</strong>.</p>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <form id="article">
    <div class="box grid_16 round_all">
            <table class="display table">
                <thead>
                <tr>
                    <th>选中</th>
                    <th>附件名称</th>
                    <th>附件大小</th>
                    <th>上传时间</th>
                    <th>附件类型</th>
                    <th>审核状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <tr class="gradeB">
                    <td class="center"><input type="checkbox" name="check1" id="check1" value="1"></td>
                    <td><a href="dashboard/attachment/1">名称1</a></td>
                    <td>500K</td>
                    <td>2012-03-25</td>
                    <td>可执行程序</td>
                    <td class="center">否</td>
                    <td class="center"><a href="#">【审核】</a><a href="#">【删除】</a></td>
                </tr>
                <tr class="gradeB">
                    <td class="center"><input type="checkbox" name="check1" id="check2" value="1"></td>
                    <td><a href="dashboard/attachment/1">名称1</a></td>
                    <td>500K</td>
                    <td>2012-03-25</td>
                    <td>可执行程序(exe)</td>
                    <td class="center">否</td>
                    <td class="center"><a href="#">【审核】</a><a href="#">【删除】</a></td>
                </tr>
                <tr class="gradeB">
                    <td class="center"><input type="checkbox" name="check1" id="check3" value="1"></td>
                    <td><a href="dashboard/attachment/1">名称1</a></td>
                    <td>500K</td>
                    <td>2012-03-25</td>
                    <td>可执行程序(bat)</td>
                    <td class="center">否</td>
                    <td class="center"><a href="#">【审核】</a><a href="#">【删除】</a></td>
                </tr>
                </tbody>
            </table>
    </div>
    <button class="button_colour" id="check_attachemnt" type="submit"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/BendedArrowRight.png"/>批量审核</button>
    <button class="button_colour" id="del"><img height="24" width="24" alt="Bended Arrow Right" src="${ctx}/static/dashboard/images/icons/BendedArrowRight.png"/>批量删除</button>
    </form>
</div>
</body>
</html>
