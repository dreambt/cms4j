<%--
   后台首页
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-24
  Time: 上午10:39
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>后台管理</title>
</head>

<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_10">
        <h2>欢迎您进入<strong>山东省金融信息技术研究中心后台管理首页</strong></h2>

        <p><strong>我们的宗旨是：建设具有解决国内金融领域信息化重大问题的、综合研究能力强的、在国内外有较大影响的金融信息工程产学研机构。</strong>
        <p><strong>我们的目标是：成为金融信息工程理论与方法的创新研究基地、金融信息化高端人才的培养基地、金融信息化产业的中试基地、金融信息工程研究与应用的人才库和知识库。</strong></p>
        <p><strong>我们的口号是：一切为了客户着想，这样我们才能更好地为客户做好事！</strong></p>
        <p><strong>我们的态度是：没有最好，只有更好！</strong></p>
    </div>
    <div class="box grid_6 round_all tabs">
        <ul class="tab_header grad_colour clearfix">
            <li>
                <a href="#tabs-1">日历</a>
            </li>
            <li>
                <a href="#tabs-2" class="round_top">风格随心所欲</a>
            </li>
        </ul>
        <a href="#" class="grabber">&nbsp;</a>
        <a href="#" class="toggle">&nbsp;</a>

        <div class="toggle_container">
            <div id="tabs-1"class="block calender">
                <div class="datepicker" style="margin: 0em;"></div>
            </div>
            <div id="tabs-2" class="block">
                <div class="content">
                    <ul class="full_width">
                        <li>点击下面的小框，选择一款您喜欢的界面风格把！</li>
                        <li class="theme_colour round_all">
                            <a class="black" href="page_black.html"><span>Black</span></a>
                            <a class="blue" href="page_blue.html"><span>Blue</span></a>
                            <a class="navy" href="page_navy.html"><span>Navy</span></a>
                            <a class="red" href="page_red.html"><span>Red</span></a>
                            <a class="green" href="page_green.html"><span>Green</span></a>
                            <a class="magenta" href="page_magenta.html"><span>Magenta</span></a>
                            <a class="brown" href="page_brown.html"><span>Brown</span></a>
                        </li>
                        <li>Or any combination of the above eg. <a href="page_fixed_full.html">Navy Fixed Full</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <div id="feature_container" class="grid_16">
        <h2 class="text_highlight">Adminica Features</h2>

    </div>
</div>
<div class="main_container container_16 clearfix fullsize">
    <div class="box grid_16 round_all">

    </div>
</div>
</body>
</html>
