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
                            <div class="PicTitle">${image.title}</div>
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
            <div class="container container_l">
                <p class="title_index title_l">
                    <strong>新闻动态</strong><a href="#" class="more">更多>></a>
                </p>
                <ul class="content l_content">
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                    <li><a href="#">北京用友政务领导和专家来本...</a><span class="time">04-16</span></li>
                </ul>
            </div>
            <div class="container container_l">
                <p class="title_index title_l">
                    <strong>行业资讯</strong><a href="#" class="more">更多>></a>
                </p>
                <ul class="content l_content">
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
                <p class="brief">中心设有证书培训、政府培训、企业高管培训、专业培训、学历培训共五个系列的涉及金融、财税、银行、投资、工商管理等学科的高端培训。我们为金融、财经、投资界的青年和精英们提供金融风险管理师、理财规划师等专业培训，以满足我国对高端金融人才的需求。我们为各级政府的金融、财税部门提供政策和理论培训，并组织第一线的实地调研活动，为各级领导及公职人员提供理论参考和实际经验。同时，我们还为国内外知名银行、保险、基金、证券等金融投资机构提供各种有针对性的企业内训课程和职业发展课程，并建立起长期战略合作关系。</p>
                 <p class="brief">中心旨在建设具有解决国内金融领域信息化重大问题的、综合研究能力强的、在国内外有较大影响的金融信息工程产学研机构。</p>
            </fieldset>
            <fieldset class="content container_r">
                <legend><a href="#"><strong>组织机构</strong></a></legend>
                <a class="institution">组织机构一</a>
                <a class="institution">组织机构一</a>
                <a class="institution">组织机构一</a>
                <a class="institution">组织机构一</a>
                <a class="institution">组织机构一</a>
                <a class="institution">组织机构一</a>
            </fieldset>
            <fieldset class="content container_r">
                <legend><a href="#"><strong>咨询服务</strong></a></legend>
                <ul class="content left_r">
                    <li><a href="#">全面信用风险管理体系建设方案</a></li>
                    <li><a href="#">全面信用风险管理体系建设方案</a></li>
                    <li><a href="#">全面信用风险管理体系建设方案</a></li>
                    <li><a href="#">全面信用风险管理体系建设方案</a></li>
                    <li><a href="#">全面信用风险管理体系建设方案</a></li>
                    <li><a href="#">全面信用风险管理体系建设方案</a></li>
                    <li><a href="#">全面信用风险管理体系建设方案</a></li>
                    <li><a href="#" class="more" style="float: right;background-image: none;">更多>></a></li>
                </ul>
            </fieldset>
        </div>
        <!---- left_r end---->
        <div id="left_b"> <%@ include file="/WEB-INF/layouts/teacher.jsp" %></div>
        <!---教师风采---->
    </div>
    <div id="index_right">
        <div class="container container_right">
            <p class="title_index title_rl"><strong>服务对象</strong><a href="#" class="more">更多>></a></p>
            <ul class="content r_content">
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
        <div class="container container_right">
            <p class="title_index title_rl"><strong>合作伙伴</strong><a href="#" class="more">更多>></a></p>
            <ul class="content r_content">
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
        <div class="container container_right">
            <p class="title_index title_rl"><strong>成果展示</strong><a href="#" class="more">更多>></a></p>
            <ul class="content r_content">
                <li><a href="#">全面信用风险管理</a></li>
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