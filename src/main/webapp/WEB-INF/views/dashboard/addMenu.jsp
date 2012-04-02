<%--
   添加菜单
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-27
  Time: 下午3:07
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>菜单管理 - 添加菜单</title>
</head>

<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_16">
        <h2>添加菜单</h2>
        <p>请您根据要求填写各项内容。</p>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <div class="box grid_16round_all">
        <h2 class="box_head grad_colour round_top">添加菜单</h2>
        <a href="#" class="grabber">&nbsp;</a>
        <a href="#" class="toggle">&nbsp;</a>

        <div class="toggle_container">
            <div class="block">
                <form>
                    <label class="menuLbl">菜单名:</label>
                    <input name="name" type="text">
                    <br><br>
                    <label class="menuLbl">URL:</label>
                    <input name="url" type="text">
                    <br><br>
                    <label class="menuLbl">显示顺序:</label>
                    <input name="showOrder" type="text">
                    <br><br>
                    <strong>父级菜单</strong>
                    <select>
                        <option value="1">顶级菜单</option>
                        <option value="2">首页</option>
                        <option value="3">新闻报道</option>
                    </select><br><br>
                    <strong>显示类型</strong>
                    <select>
                        <option value="0">无</option>
                        <option value="1">列表</option>
                        <option value="2">详细</option>
                        <option value="3">摘要</option>
                    </select> <br><br>
                    <strong>允许评论</strong>
                    <input name="allComment" type="checkbox" class="menuLbl">
                    <strong>允许在导航显示</strong>
                    <input name="asNav" type="checkbox" class="menuLbl">
                    <strong>允许发表</strong>
                    <input name="allowPub" type="checkbox" class="menuLbl"> <br>  <br>
                    <label class="menuLbl">描述信息:</label>
                    <textarea name="atleast" style="height:auto"/></textarea>
                    <button class="button_colour">提交</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>