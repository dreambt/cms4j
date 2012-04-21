<%--
  研究所.
  User: sdcy
  Date: 12-4-21
  Time: 下午9:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sitemesh-page" uri="http://www.opensymphony.com/sitemesh/page" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>金融信息安全研究所</title>
</head>
<body>
<div id="banner"></div>
<div id="index_left">
    <div id="left_l">
        <div class="container container_l">
            <p class="title_index title_l">
                <strong>发展定位</strong>
            </p>
            <p class="brief">山东省金融信息工程技术研究中心依托山东财经大学的金融、财税、会计、管理、数学和信息技术等雄厚的学科资源，联合行业内相关优势企业，为推动我国金融信息化的发展及相关技术的研究而成立的一个开放的专业从事与金融信息化和金融风险管理相关的理论与应用技术研究、教育培训、战略规划与咨询服务的组织。中心于2010年12月经山东省科技厅批准成立，是省内在金融信息工程领域唯一的省级工程技术研究中心。中心目前主持国家级科研课题4项，省部级科研课题5项,取得软件著作权6项，申报国家发明专利3项。独立研究及与合作伙伴共同研发的多项成果已成功应用于交通银行、广发银行、恒丰银行、齐鲁银行及小额贷款公司等非银行金融机构。</p>
        </div>
    </div>
    <!---left_l end----->
    <div id="left_r">
        <fieldset class="content container_r">
            <legend><a href="#"><strong>咨询服务</strong></a></legend>
            <a class="institution" href="#">金融风险管理研究所</a>
            <a class="institution" href="#">金融服务计算研究所</a>
            <a class="institution" href="#">计算金融研究所</a>
            <a class="institution" href="#">金融信息安全研究所</a>
            <a class="institution" href="#">金融数据管理研究所</a>
            <a class="institution" href="#">金融服务创新研究所</a>
        </fieldset>
        <fieldset class="content container_r">
            <legend><a href="#"><strong>解决方案</strong></a></legend>
            <ul class="content twoRow">
                    <li><a href="#">金融风险管理研究所</a></li>
            </ul>
            <ul class="content twoRow">
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
        <p class="title_index title_rl"><strong>服务对象</strong><%--<a href="#" class="more">更多>></a>--%></p>
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
        <p class="title_index title_rl"><strong>合作伙伴</strong><%--<a href="#" class="more">更多>></a>--%></p>
        <ul class="content r_content">
            <c:forEach items="${companies}" var="company" begin="0" step="1">
                <li><a href="${ctx}/article/content/${company.id}">${fn:substring(company.title,0,8)}</a></li>
            </c:forEach>
        </ul>
    </div>
    <div class="container container_right">
        <p class="title_index title_rl"><strong>行业资讯</strong><a href="${ctx}/article/list/" class="more">更多>></a></p>
        <ul class="content r_content">
            <c:forEach items="${news2}" var="new2" begin="0" step="1">
                <li><a href="${ctx}/article/content/${new2.id}">${fn:substring(new2.subject,0,13)}...</a></li>
            </c:forEach>
        </ul>
    </div>
</div>
<ul id="friLnk">
    <li class="friLnkT cufon"><strong>友情链接</strong></li>
    <li><a href="#">山东省数字媒体技术重点实验室</a></li>
    <li><a href="#">山东省数字媒体技术重点实验室</a></li>
    <li><a href="#">山东省数字媒体技术重点实验室</a></li>
    <li><a href="#">山东省数字媒体技术重点实验室</a></li>
    <li><a href="#">山东省数字媒体技术重点实验室</a></li>
    <li><a href="#">山东省数字媒体技术重点实验室</a></li>
    <li><a href="#">山东省数字媒体技术重点实验室</a></li>
    <li><a href="#">山东省数字媒体技术重点实验室</a></li>
</ul>
</body>
</html>