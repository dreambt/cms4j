<%--
  后台模版的sidebar装饰器
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-21
  Time: 下午4:30
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!--begin sidebar-->
<div id="sidebar">
    <a href="${ctx}/index" class="logo"><span>CMS4j</span></a>
    <div class="user_box round_all clearfix">
        <img src="${ctx}/static/dashboard/images/profile.jpg" width="55" alt="ProfilePic"/>
        <h2><shiro:principal property="groupName"/></h2>
        <h3><a class="text_shadow" href="${ctx}/account/user/edit/<shiro:principal property="id"/>"><shiro:principal property="name"/></a></h3>
        <ul>
            <li><a href="${ctx}/dashboard/personSetting">个人设置</a><span class="divider">|</span><a href="${ctx}/logout">退出</a></li>
        </ul>
    </div>
    <!-- #user_box -->
    <ul id="accordion">
        <li><a href="${ctx}/dashboard/index"><img src="${ctx}/static/dashboard/images/icons/Home.png"/>后台首页</a>
        </li>
        <shiro:hasPermission name="article:list">
        <li><a href="" class="top_level"><img src="${ctx}/static/dashboard/images/icons/WordDocuments.png"/>文章管理</a>
            <ul class="drawer">
                <li><a href="${ctx}/article/create">发表文章</a></li>
                <li><a href="${ctx}/article/listAll">查看所有文章</a></li>
                <li><a href="${ctx}/attachment/list">附件管理</a></li>
            </ul>
        </li>
        </shiro:hasPermission>
        <shiro:hasPermission name="category:list">
        <li><a href="" class="top_level"><img src="${ctx}/static/dashboard/images/icons/Tags2.png"/>菜单管理</a>
            <ul class="drawer">
                <li><a href="${ctx}/category/create">添加菜单</a></li>
                <li><a href="${ctx}/category/listAll">查看所有菜单</a></li>
            </ul>
        </li>
        </shiro:hasPermission>
        <shiro:hasPermission name="comment:list">
        <li><a href="${ctx}/comment/listAll"><img src="${ctx}/static/dashboard/images/icons/SpeechBubbles2.png"/>评论管理</a></li>
        </shiro:hasPermission>
        <shiro:hasPermission name="gallery:list">
        <li><a href="#" class="top_level"><img src="${ctx}/static/dashboard/images/icons/Image2.png"/>相册管理</a>
           <ul class="drawer">
               <li><a href="${ctx}/gallery/create">上传活动图片</a></li>
               <li><a href="${ctx}/gallery/listAll">活动图片列表</a></li>
           </ul>
        </li>
        </shiro:hasPermission>
        <shiro:hasPermission name="user:list">
            <li><a href="" class="top_level"><img src="${ctx}/static/dashboard/images/icons/Users.png"/>用户管理</a>
                <ul class="drawer">
                    <li><a href="${ctx}/account/user/create">添加用户</a></li>
                    <li><a href="${ctx}/account/user/list">查看所有用户</a></li>
                </ul>
            </li>
        </shiro:hasPermission>
        <shiro:hasPermission name="link:list">
        <li><a href="${ctx}/dashboard/fridendLink" class="top_level"><img src="${ctx}/static/dashboard/images/icons/AddressBook.png"/>友情链接管理</a>
            <ul class="drawer">
                <li><a href="${ctx}/link/create">添加友情链接</a></li>
                <li><a href="${ctx}/link/listAll">友情链接列表</a></li>
            </ul>
        </li>
        </shiro:hasPermission>
        <li><a href="${ctx}/dashboard/FAQs"><img src="${ctx}/static/dashboard/images/icons/InfoAbout.png"/>文档 F&Q</a></li>
    </ul>
    <form id="search_side"><input class="round_all" type="text" value="Search..." onClick="value=''"></form>
    <ul id="side_links" class="text_shadow">
        <li><a href="#"><img src="${ctx}/static/dashboard/images/icons/Books.png"/>搜索用户</a></li>
        <li><a href="#"><img src="${ctx}/static/dashboard/images/icons/Books.png"/>搜索文章</a></li>
        <li><a href="${ctx}/index"><img src="${ctx}/static/dashboard/images/icons/Refresh4.png"/>返回首页</a>
        </li>
    </ul>
    <%@include file="footer.jsp" %>
</div>
<!-- #sidebar -->