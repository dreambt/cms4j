<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sitemesh-page" uri="http://www.opensymphony.com/sitemesh/page" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>首页</title>

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
<div class="span-20">
    <div class="span-7">
        <div class="container_index">
            <!-- BEGIN SLIDER -->
            <div id="slideshow" class="span-7 last">
                <c:forEach items="${images}" var="image" begin="0" step="1" end="5">
                    <div class="slide-text">
                        <div class="PicTitle span-7"><a href="#"title="${image.title}">${fn:substring(image.title,0,20)}<c:if test="${fn:length(image.title)>20}">...</c:if></a></div>
                        <img src="${ctx}/static/uploads/gallery/thumb-272x166/${image.imageUrl}" title="${image.title}" width="270px"
                             height="166px"/>
                    </div>
                </c:forEach>
            </div>
            <div id="box-nav-slider" class="span-7 last">
                <div id="slideshow-navigation">
                    <div id="pager"></div>
                </div>
            </div>
        </div>
        <div class="container_index span-7-border">
            <p class="title_index title-268">
                <strong>新闻动态</strong><span class="more"> <a href="${ctx}/article/list/3" class="more">更多>></a></span>
            </p>
            <ul class="content span-7">
                <c:forEach items="${news1}" var="new1" begin="0" step="1">
                    <li><a href="${ctx}/article/content/${new1.id}">${fn:substring(new1.subject,0,16)}<c:if test="${fn:length(new1.subject)>16}">...</c:if></a><span
                            class="time"><fmt:formatDate value="${new1.createdDate}" pattern="MM-dd"></fmt:formatDate></span></li>
                </c:forEach>
            </ul>
        </div>
        <div class="container_index span-7-border">
            <p class="title_index title-268">
                <strong>通知公告</strong><span class="more"> <a href="${ctx}/article/list/1" class="more">更多>></a></span>
            </p>
            <ul class="content span-7">
                <c:forEach items="${posts}" var="post" begin="0" step="1">
                    <li><a href="${ctx}/article/content/${post.id}">${fn:substring(post.subject,0,16)}<c:if test="${fn:length(post.subject)>16}">...</c:if></a><span
                            class="time"><fmt:formatDate value="${post.createdDate}" pattern="MM-dd"></fmt:formatDate></span></li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <!---left_l end----->
    <div class="span-13 last">
        <div class="container_index span-13-border">
            <p class="title_index title-508"><a href="#"><strong>中心简介</strong></a></p>
            <p class="brief">
                山东省金融信息工程技术研究中心依托山东财经大学的金融、财税、会计、管理、数学和信息技术等雄厚的学科资源，联合行业内相关优势企业，面向我国金融信息化、金融风险管理、金融服务创新与金融服务外包产业发展的实际需要,
                开展金融信息化相关政策、理论与技术研究，以及人才培养、产品研发与咨询服务。重点研究面向中小金融机构的信息技术解决方案、工具和方法，以工程技术研究中心作为科技成果向生产力转化的中间环节,提高现有科技成果的成熟性、配套性和工程化水平,使中心的技术和业务直达金融信息技术服务市场价值链的上游,加速金融服务创新和金融信息化科技成果向现实生产力的转化。目前中心主持国家级科研课题4项，省部级科研课题5项,取得软件著作权6项，申报国家发明专利3项。独立研究及与合作伙伴共同研发的多项成果已成功应用于交通银行、广发银行、恒丰银行、德州商行和多家小额贷款公司。
            </p>
        </div>
        <div class="container_index span-13-border">
            <p class="title_index title-508"><a href="#"><strong>学术研究</strong></a></p>
            <p class="brief train" style="margin-top: 5px;"><a href="${ctx}/research/1"><strong>金融风险管理。</strong></a>研究新资本协议框架下商业银行全面风险管理体系，重点研究金融风险识别、度量、缓释与控制技术，以及金融风险评估指标体系、风险分析模型、风险预警系统及管</p>
            <p class="brief train"><a href="${ctx}/research/2"><strong>金融数据管理。</strong></a>研究金融领域信息化建设中的数据治理、数据整合、数据挖掘与数据应用技术。重点研究金融数据存储、抽取、转换、分析和数据展现技术，数据分析模型及智能分析</p>
            <p class="brief train"><a href="${ctx}/research/3"><strong>金融服务计算。</strong></a>研究面向银行、证券、保险等金融行业应用的新型云计算体系结构、虚拟化开发与测试环境、基于SaaS模式的金融综合服务平台、金融云数据中心和服务计算技术等。</p>
            <p class="brief train"><a href="${ctx}/research/4"><strong>金融信息安全。</strong></a>研究金融行业信息化建设中的网络与信息安全理论与应用技术，重点研究金融网络安全架构、信息科技风险管理、信息系统安全审计、移动支付安全体系和应急处置技</p>
        </div>
        <div class="container_index span-13-border">
            <p class="title-508 title_index"><a href="${ctx}/article/listInfo"><strong>咨询服务</strong></a></p>
            <ul class="content span-6">
                <c:forEach items="${infos}" var="info" begin="0" step="1" end="3">
                    <li class="counseling"><c:if test="${info.message!=''}"><a href="${ctx}/article/content/${info.id}">${fn:substring(info.subject,0,15)}</a></c:if></li>
                </c:forEach>
            </ul>
            <div class="span-1">&nbsp;</div>
            <ul class="content span-6 last">
                <c:forEach items="${infos}" var="info" begin="4" step="1" end="6">
                    <li class="counseling"><c:if test="${info.message!=''}"><a href="${ctx}/article/content/${info.id}"></c:if>${fn:substring(info.subject,0,15)}</a></li>
                </c:forEach>
                <li class="lastM"><span> <a href="${ctx}/article/listInfo" class="more">更多...</a></span></li>
            </ul>
        </div>
    </div>
    <!---教师风采---->
    <div id="left_b_index">
        <p class="title_index title-788"><strong>专家团队</strong></p>
        <%@ include file="/WEB-INF/layouts/teacher.jsp" %>
    </div>
</div>
<!---- left_r end---->
<div class="span-4 last">
    <div class="container_index span-4-border">
        <p class="title_index title-148"><strong>研究机构</strong><%--<a href="#" class="more">更多>></a>--%></p>
        <ul class="content span-4">
            <li><a href="${ctx}/research/1">金融风险管理研究所</a></li>
            <li><a href="${ctx}/research/2">金融数据管理研究所</a></li>
            <li><a href="${ctx}/research/3">金融服务计算研究所</a></li>
            <li><a href="${ctx}/research/4">金融信息安全研究所</a></li>
            <li>计算金融研究所</li>
            <li>金融创新研究所</li>
            <%--<c:forEach items="${agencies}" var="agency" begin="0" step="1">--%>
                <%--<li><a href="${ctx}/agency/show/${agency.id}">${agency.title}</a></li>--%>
            <%--</c:forEach>--%>
        </ul>
    </div>
    <div class="container_index span-4-border">
        <p class="title_index title-148"><strong>服务对象</strong><%--<a href="#" class="more">更多>></a>--%></p>
        <ul class="content span-4">
            <li class="serviceObj">民生银行等股份制银行</li>
            <li class="serviceObj">山东省农信社等省属银行</li>
            <li class="serviceObj">山东省城市商业银行合作联盟</li>
            <li class="serviceObj">齐鲁银行等城市商业银行</li>
            <li class="serviceObj">小额贷款公司与村镇银行</li>
            <li class="serviceObj">证券公司及保险担保公司</li>
            <li class="serviceObj">地方财政及税务管理部门</li>
            <li class="serviceObj">地方银监会证监会金融办</li>
        </ul>
    </div>
    <div class="container_index  span-4-border">
        <p class="title_index title-148"><strong>行业资讯</strong><span class="more"> <a href="${ctx}/article/list/4" class="more">更多>></a></span></p>
        <ul class="content title-148">
            <c:forEach items="${news2}" var="new2" begin="0" step="1">
                <li><a href="${ctx}/article/content/${new2.id}">${fn:substring(new2.subject,0,10)}<c:if test="${fn:length(new2.subject)>10}">...</c:if></a></li>
            </c:forEach>
        </ul>
    </div>
</div>
<ul id="friLnk" class="span-24">
    <li class="friLnkT"><strong>友情链接</strong></li>
    <c:forEach items="${links}" var="link" begin="0" step="1">
        <li class="fri"><a href="${link.url}" target="_blank">${link.title}</a></li>
    </c:forEach>
</ul>
</body>
</html>