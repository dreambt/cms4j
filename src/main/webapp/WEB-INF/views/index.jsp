<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sitemesh-page" uri="http://www.opensymphony.com/sitemesh/page" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>山东省金融信息工程培训中心</title>

    <!-- ////////////////////////////////// -->
    <!-- //      Javascript Files        // -->
    <!-- ////////////////////////////////// -->
    <script src="${ctx}/static/js/jquery.cycle.all.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#slideshow').cycle({
                timeout:5000, // milliseconds between slide transitions (0 to disable auto advance)
                fx:'fade', // choose your transition type, ex: fade, scrollUp, shuffle, etc...
                pager:'#pager', // selector for element to use as pager container
                pause:0, // true to enable "pause on hover"
                pauseOnPagerHover:0 // true to pause when hovering over pager link
            });
            $('#featured').cycle({
                timeout:12000, // milliseconds between slide transitions (0 to disable auto advance)
                fx:'scrollUp', // choose your transition type, ex: fade, scrollUp, shuffle, etc...
                pause:0, // true to enable "pause on hover"
                pauseOnPagerHover:0 // true to pause when hovering over pager link
            });
            $('.anno').cycle();
        });
    </script>
</head>
<body>
    <div id="index_left">
        <div id="left_l">
            <div class="container_l">
                <!-- BEGIN SLIDER -->
                <div id="slideshow">
                    <c:forEach items="${images}" var="image" begin="0" step="1">
                        <div class="slide-text">
                            <h7>${image.title}</h7>
                            <img src="${ctx}/static/uploads/gallery/thumb-460x283/${image.imageUrl}" alt="" width="270px"/>
                        </div>
                    </c:forEach>
                </div>
                <div id="box-nav-slider">
                    <div id="slideshow-navigation">
                        <div id="pager"></div>
                    </div>
                </div>
                <!-- END OF SLIDER -->
            </div>
            <div class="container_l">
                <p class="title_l">
                    <strong>新闻资讯</strong><a href="#" class="more">更多>></a>
                </p>
                <ul class="content">
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                </ul>
            </div>
        </div>
        <!---left_l end----->
        <div id="left_r">
            <fieldset class="container_r">
                <legend><a href="#"><strong>中心简介</strong></a></legend>
                <p class="brief">中心依托山东财经大学的金融、财税、会计、管理、数学和信息技术等雄厚的学科资源，联合行业内相关优势企业，为推动我国金融信息化的发展及相关技术的研究而成立的一个开放的专业从事与金融信息化和金融风险管理相关的理论与应用技术研究、教育培训与咨询服务的组织。</p>
                <p class="brief">中心下设计算金融研究所、金融风险管理研究所、金融信息安全研究所等若干个在业务上相对独立的研究所；设金融智能实验室等以理论和技术研究为主的专业实验室与研究室。</p>

            </fieldset>
            <fieldset class="container_r">
                <legend><a href="#"><strong>组织机构</strong></a></legend>
                <a class="institution">组织机构一</a>
                <a class="institution">组织机构一</a>
                <a class="institution">组织机构一</a>
                <a class="institution">组织机构一</a>
                <a class="institution">组织机构一</a>
                <a class="institution">组织机构一</a>
            </fieldset>
            <fieldset class="container_r">
                <legend id="consult"><strong style="display: block;float: left;">咨询服务</strong><a href="#" class="more" style="float: right;">更多>></a></legend>
                <ul>
                <li><a href="#">全面信用风险管理体系建设方案</a></li>
                <li><a href="#">全面信用风险管理体系建设方案</a></li>
                <li><a href="#">全面信用风险管理体系建设方案</a></li>
                <li><a href="#">全面信用风险管理体系建设方案</a></li>
                <li><a href="#">全面信用风险管理体系建设方案</a></li>
                <li><a href="#">全面信用风险管理体系建设方案</a></li>
                <li><a href="#">全面信用风险管理体系建设方案</a></li>
                </ul>
            </fieldset>
        </div>
        <!---- left_r end---->
        <div id="left_b"> <%@ include file="/WEB-INF/layouts/teacher.jsp" %></div>
        <!---教师风采---->
    </div>
    <div id="index_right">
        <div class="container_right">
            <p class="title_rl"><strong>服务对象</strong><a href="#" class="more">更多>></a></p>
            <ul class="r_content">
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
            </ul>
        </div>
        <div class="container_right">
            <p class="title_rl"><strong>合作伙伴</strong><a href="#" class="more">更多>></a></p>
            <ul class="r_content">
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
            </ul>
        </div>
        <div class="container_right">
            <p class="title_rl"><strong>成果展示</strong><a href="#" class="more">更多>></a></p>
            <ul class="r_content">
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
                <li><a href="#">全面信用风险管理</a></li>
            </ul>
        </div>
    </div>
</body>
</html>