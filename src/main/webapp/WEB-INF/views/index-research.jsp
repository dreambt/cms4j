<%--
  研究所.
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-4-21
  Time: 下午9:19
  To change this template use File | Settings | File Templates.
--%>
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
    <title>${agency.title}</title>
</head>
<body>
<img id="banner" src="${ctx}/static/images/${agency.imageUrl}" class="span-24"/>

<div class="span-19">
    <div class="span-7">
        <div class="container_index span-7-border">
            <p class="title_index title-268">
                <strong>关于我们</strong>
            </p>

           <p class="researchDesc">${fn:substring(agency.introduction,0,215)}</p>
        </div>
    </div>
    <!---left_l end----->
    <div class="span-12 last">
        <div class="container_index span-12-border">
            <p class="title_index title-468"><a href="#"><strong>学术研究</strong></a></p>
            <p class="brief">围绕着新资本协议框架，基于流程银行的最佳实践，结合人工智能、数据挖掘技术和各种数据分析方法，研究经济及金融一体化趋势下金融信用风险评估指标体系、风险分析模型及预警系统、商业银行风险管理系统、证券投资风险预测模型与管理工具等。研究内容主要包括：</p>
            <h6 class="subTitle">1. 商业银行风险度量与管理模型</h6>
            <p class="brief">
            按照《巴塞尔新资本协议》的要求及框架，研究针对各种风险类型的度量和管理模型，以支持商业银行的风险管理行为。利用最新数据挖掘方法和技术，研究针对已发生业务行为的风险识别模型和未来风险的预测模型。
            </p>
            <h6 class="subTitle">2. 商业银行信用风险内部评级体系</h6>
            <p class="brief">
                研究信用风险识别工具和计量工具，研制风险监控系统，实现风险识别、预警及全过程的风险监控。研究风险管理部门日常的风险管理工具、方法和风险管理流程。研究基于风险量化结果的风险决策和内部评级的价值应用。
            </p>
            <h6 class="subTitle">3. 商业银行操作风险及内控管理体系</h6>
            <p class="brief">
                以风险点识别及监测、关键风险指标体系、事件管理及事件数据库、损失数据库的建立为核心基础，进行操作风险的分析评估、趋势分析、计量模型的开发建立。研究风险区域的选择、风险点的识别、监测、风险诱因、关键风险指标选择、数据的收集和关键风险指标监测评估。
            </p>
            <h6 class="subTitle">4. 客户风险监控模型研究</h6>
            <p class="brief">
                研究针对客户财务风险的量化分析和预警模型，建立计算客户财务综合风险指数的方法。研究授信客户的现金流未来趋势的预测模型，发现客户的现金流恶化的可能或异常的现金流出。研究客户间关联关系的发现模型及风险预警模型。
            </p>

        </div>
        <div class="container_index span-12-border">
            <p class="title_index title-468"><a href="#"><strong>解决方案</strong></a></p>
            <ul class="content span-12">
                <li><a href="#">农村金融机构全面风险管理方案</a></li>
                <li><a href="#">中小银行信用风险内部评级解决方案</a></li>
                <li><a href="#">战略规划落地实施解决方案</a></li>
            </ul>
        </div>
    </div>
    <!---- left_r end---->
    <div id="left_b" class="span-19 last">
        <%@ include file="/WEB-INF/layouts/teacher.jsp" %>
    </div>
    <!---教师风采---->
</div>
<div class="span-5 last">
    <div class="container_index span-5-border">
        <p class="title_index title-188"><strong>教育培训</strong><%--<a href="#" class="more">更多>></a>--%></p>
            <span class="span-2"><a href="#" class="institution">证书培训</a></span>
            <span class="span-2"><a href="#" class="institution">高管培训</a></span>
            <span class="span-2"><a href="#" class="institution">学历培训</a></span>
            <span class="span-2"><a href="#" class="institution">学历培训</a></span>
    </div>
    <div class="container_index span-5-border">
        <p class="title_index title-188"><strong>IT支持系统</strong><span class="more"> <a href="${ctx}/article/list/" class="more">更多>></a></span></p>
        <ul class="content span-5">
            <li><a href="#">风险及内控管理系统</a></li>
            <li><a href="#">流动性风险管理系统</a></li>

        </ul>
    </div>
    <div class="container_index span-5-border">
        <p class="title_index title-188"><strong>合作伙伴</strong><%--<a href="#" class="more">更多>></a>--%></p>
        <ul class="content span-5">
            <c:forEach items="${companies}" var="company" begin="0" step="1">
                <li><a href="${ctx}/article/content/${company.id}">${fn:substring(company.title,0,14)}</a></li>
            </c:forEach>
        </ul>
    </div>

</div>
<ul id="friLnk" class="span-24">
    <li class="friLnkT cufon"><strong>友情链接</strong></li>
    <c:forEach items="${links}" var="link" begin="0" step="1">
        <li class="fri"><a href="${link.url}">${fn:substring(link.title,0,13)}</a></li>
    </c:forEach>
</ul>
</body>
</html>