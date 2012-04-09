<%--
  Header模块
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-18
  Time: 下午5:09
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!-- BEGIN HEADER -->
<div id="header">
    <div id="top-header">
        <div class="logo"><a href="index.html"><img src="${ctx}/static/images/logo.jpg" alt="" style="vertical-align:middle;margin-right: 10px;margin-bottom: 5px;" class="cufon" /><h1 class="cufon">山东省金融信息技术研究中心</h1></a></div>
    </div>
    <div id="bottom-header">
        <div id="nav-menu">
            <ul class="sf-menu">
                <li><a href="${ctx}/" class="cufon">首页</a></li>
                <li><a href="${ctx}/" class="cufon">新闻资讯</a>
                    <ul>
                        <li><a href="${ctx}/article/list/4">新闻动态</a></li>
                        <li><a href="${ctx}/article/list/4">行业资讯</a></li>
                        <li><a href="${ctx}/article/list/4">学术交流</a></li>
                    </ul>
                </li>
                <li><a href="${ctx}/" class="cufon">中心概况</a>
                    <ul>
                        <li><a href="${ctx}/article/content/17">中心简介</a></li>
                        <li><a href="${ctx}/article/content/18">组织结构</a></li>
                        <li><a href="#">运作机制</a>
                            <ul>
                                <li><a href="${ctx}/content/1">规章制度</a></li>
                            </ul>
                        </li>
                        <li><a href="${ctx}/contact">联系我们</a></li>
                    </ul>
                </li>
                <li><a href="${ctx}/" class="cufon">学术团队</a>
                    <ul>
                        <li><a href="${ctx}/gallery/album">学术带头人</a></li>
                        <li><a href="${ctx}/gallery/album">学术骨干</a></li>
                        <li><a href="${ctx}/gallery/album">专家顾问</a></li>
                    </ul>
                </li>
                <li><a href="${ctx}/" class="cufon">学术研究</a>
                    <ul>
                        <li><a href="${ctx}/article/digest/2">研究方向</a></li>
                        <li><a href="${ctx}/article/digest/2">科研成果</a></li>
                        <li><a href="${ctx}/article/digest/2">科研项目</a></li>
                    </ul>
                </li>
                <li><a href="${ctx}/" class="cufon">资讯服务</a>
                    <ul>
                        <li><a href="${ctx}/article/list/4">财政税务</a></li>
                        <li><a href="${ctx}/article/list/3">中小银行</a></li>
                        <li><a href="${ctx}/article/list/2">证券保险</a></li>
                        <li><a href="${ctx}/article/list/1">政府决策</a></li>
                    </ul>
                </li>
                <li><a href="${ctx}/" class="cufon">教育培训</a></li>
                <li><a href="${ctx}/" class="cufon">产学研合作</a>
                    <ul>
                        <li><a href="${ctx}/gallery/album">成果转化</a></li>
                        <li><a href="${ctx}/gallery/photo">合作伙伴</a></li>
                        <li><a href="${ctx}/gallery/album">对外交流</a></li>
                    </ul>
                </li>
                <li><a href="${ctx}/" class="cufon">网上办公</a>
                    <ul>
                        <li><a href="http://oa.sdufe.edu.cn/">办公系统</a></li>
                        <li><a href="http://filex.sdufe.edu.cn/">文件交换</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <!-- end of nav -->

    </div>
    <!-- end of nav -->
<script type="text/javascript">
    $(function(){
       $("ul.sf-menu li:first").css('border-left','none');
    });
</script>
</div>
<!-- END OF HEADER -->