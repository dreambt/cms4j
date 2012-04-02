<%--
 后台FAQs
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-28
  Time: 下午10:28
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>FAQs</title>
</head>
<body>
<div id="main_container" class="main_container container_16 clearfix">
    <div class="flat_area grid_10">
        <h2>FAQs</h2>

        <p><strong>我们的宗旨是：建设具有解决国内金融领域信息化重大问题的、综合研究能力强的、在国内外有较大影响的金融信息工程产学研机构。</strong></p>
    </div>
</div>
<div class="main_container container_16 clearfix">
    <div class="box grid_16">
        <h2 class="box_head grad_colour">Accordion with Heading</h2>
        <a href="#" class="grabber">&nbsp;</a>
        <a href="#" class="toggle">&nbsp;</a>

        <div class="toggle_container">
            <ul class="block content_accordion">
                <li>
                    <a href="#" class="handle">&nbsp;</a>

                    <h3 class="bar">First Heading</h3>

                    <div class="content">
                        <h1>Primary Heading</h1>

                        <p>Lorem Ipsum is simply dummy text of the <a href="#" title="This is a tooltip">printing
                            industry</a>. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s,
                            when an unknown printer took a galley of type and scrambled it to make a type specimen book.
                        </p>

                        <h2>Secondary Heading</h2>

                        <p>Lorem Ipsum is simply dummy text of the printing industry. Lorem Ipsum has been the
                            industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley
                            of type and scrambled it to make a type specimen book.</p>
                    </div>
                </li>
                <li>
                    <a href="#" class="handle">&nbsp;</a>

                    <h3 class="bar">Second Heading</h3>

                    <div class="content">
                        <p>Content goes here</p>
                    </div>
                </li>
                <li>
                    <a href="#" class="handle">&nbsp;</a>

                    <h3 class="bar">Third Heading</h3>

                    <div class="content">
                        <p>Content goes here</p>
                    </div>
                </li>
                <li>
                    <a href="#" class="handle">&nbsp;</a>

                    <h3 class="bar">Fourth Heading</h3>

                    <div class="content">
                        <p>Content goes here</p>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>