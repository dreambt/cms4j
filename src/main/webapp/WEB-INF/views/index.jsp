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
                <p class="brief">山东省金融信息工程技术研究中心依托山东财经大学的金融、财税、会计、管理、数学和信息技术等雄厚的学科资源，联合行业内相关优势企业，为推动我国金融信息化的发展及相关技术的研究而成立的一个开放的专业从事与金融信息化和金融风险管理相关的理论与应用技术研究、教育培训、战略规划与咨询服务的组织。中心于2010年12月经山东省科技厅批准成立，是省内在金融信息工程领域唯一的省级工程技术研究中心。中心目前主持国家级科研课题4项，省部级科研课题5项,取得软件著作权6项，申报国家发明专利3项。独立研究及与合作伙伴共同研发的多项成果已成功应用于交通银行、广发银行、恒丰银行、齐鲁银行及小额贷款公司等非银行金融机构。
                </p>
            </fieldset>
            <fieldset class="content container_r">
                <legend><a href="#"><strong>组织机构</strong></a></legend>
                <a class="institution">金融风险管理研究所</a>
                <a class="institution">金融服务计算研究所</a>
                <a class="institution">计算金融研究所</a>
                <a class="institution">金融信息安全研究所</a>
                <a class="institution">金融数据管理研究所</a>
                <a class="institution">金融服务创新研究所</a>
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
                <li>股份制商业银行</li>
                <li>城市商业银行</li>
                <li>农村信用社</li>
                <li>村镇银行</li>
                <li>小额贷款公司</li>
                <li>证券公司</li>
                <li>保险公司</li>
                <li>财政税务管理部门</li>
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