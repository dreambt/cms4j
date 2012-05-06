<%--
  金融风险管理研究所
  User: Wang Kejun (445489171@qq.com)
  Date: 12-5-6
  Time: 下午13:14
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
    <title>金融风险管理研究所</title>
</head>
<body>
<img id="banner" src="${ctx}/static/uploads/agency/1336285832603-xUv61T.jpg" width="948px"/>

<div class="span-19">
    <div class="span-7">
        <div class="container_index span-7-border">
            <p class="title_index title-268">
                <strong>关于我们</strong>
            </p>
           <p class="researchDesc train">	金融风险管理研究所围绕着新资本协议框架，基于流程银行的最佳实践，结合人工智能、数据挖掘技术和各种数据分析方法，研究经济及金融一体化趋势下金融风险的识别、度量和控制理论与应用，特别是金融信用风险评估指标体系、风险分析模型及预警系统、商业银行结构性风险管理系统、证券投资风险预测与管理工具等。研究所依托山东财经大学的学科优势，与相关企业、科研单位在金融机构全面风险管理方面开展产学研合作，促进科技成果的转化与应用。</p>
           <p class="researchDesc train">  专家团队由具有较高理论造诣的高校教师和具有丰富实际工作经验的业界专家组成。其中教授2人，副教授、高级工程师和高级系统分析师6人，团队成员大多具有博士学位或具有海外学习与工作经历。</p>
        </div>
        <div class="container_index span-7-border">
            <p class="title_index title-268"><strong>产学研合作</strong><%--<a href="#" class="more">更多>></a>--%></p>
            <p class="brief">    本研究所与山东省城商联盟、山东省农信社等多家金融机构，山东舜德数据管理软件公司等多家国内外企业建立了长期的紧密合作关系。承担国家自然基金项目1项、省部级科研课题及企业委托研发课题6项。独立研究及与合作伙伴共同研发的成果已取得软件著作权6项，申报国家发明专利2项，“基于流程管理的商业银行资产管理系统”和“基于Basel II的商业银行内部评级系统”等多项成果已成功应用于交通银行、广发银行、恒丰银行、齐鲁银行、德州商行及小额贷款公司等非银行金融机构。</p>
        </div>
    </div>
    <!---left_l end----->
    <div class="span-12 last">
        <div class="container_index span-12-border">
            <p class="title_index title-468"><a href="#"><strong>学术研究</strong></a></p>
            <p class="brief">  围绕着新资本协议框架，基于流程银行的最佳实践，结合人工智能、数据挖掘技术和各种数据分析方法，研究经济及金融一体化趋势下金融信用风险评估指标体系、风险分析模型及预警系统、商业银行风险管理系统、证券投资风险预测模型与管理工具等</p>
            <h6 class="subTitle">商业银行风险度量与管理模型</h6>
            <p class="brief train">
                按照《巴塞尔新资本协议》的要求及框架，研究针对各种风险类型的度量和管理模型，以支持商业银行的风险管理行为。利用最新数据挖掘方法和技术，研究针对已发生业务行为的风险识别模型和未来风险的预测模型。
            </p>
            <h6 class="subTitle"> 商业银行信用风险内部评级体系</h6>
            <p class="brief train">
                研究信用风险识别工具和计量工具，研制风险监控系统，实现风险识别、预警及全过程的风险监控。研究风险管理部门日常的风险管理工具、方法和风险管理流程。研究基于风险量化结果的风险决策和内部评级的价值应用。
            </p>
            <h6 class="subTitle">商业银行操作风险及内控管理体系</h6>
            <p class="brief train">
                研究风险区域的选择、风险点的识别监测、风险诱因、关键风险指标选择监测评估、数据的收集、事件管理和损失数据库。进行操作风险的分析评估、趋势分析、计量模型的开发。
            </p>
            <h6 class="subTitle">客户风险监控模型研究</h6>
            <p class="brief train">
                研究针对客户财务风险的量化分析和预警模型，建立计算客户财务综合风险指数的方法。研究授信客户的现金流未来趋势的预测模型，发现客户的现金流恶化的可能或异常的现金流出。研究客户间关联关系的发现模型及风险预警模型。
            </p>
        </div>
        <div class="container_index span-12-border">
            <p class="title_index title-468"><a href="#"><strong>咨询服务</strong></a></p>
            <ul class="content span-6">
                <li><a href="#">商业银行全面风险管理规划</a></li>
                <li><a href="#">中小金融机构授信管理体系</a></li>
                <li><a href="#">商业银行操作风险及内控管理</a></li>
            </ul>
            <ul class="content span-6 last">
                <li><a href="#">农村金融机构全面风险管理建设</a></li>
                <li><a href="#">中小银行信用风险内部评级体系</a></li>
                <li><a href="#">商业银行流动性风险管理方案</a></li>
            </ul>
        </div>

    </div>
    <!---- left_r end---->
    <div id="left_b">
        <p class="title_index title-748"><strong>专家团队</strong></p>
        <%@ include file="/WEB-INF/layouts/teacher.jsp" %>
    </div>
    <!---教师风采---->
</div>
<div class="span-5 last">

    <div class="container_index span-5-border">
        <p class="title_index title-188"><strong>教育培训</strong></p>
        <h6 class="subTitle">Basel II与银行全面风险管理</h6>
        <p class="brief train">  内容包括全面风险管理的框架以及风险管理的演进、巴塞尔新资本协议的构成，新旧协议的差别；包括对银行信用风险、市场风险、操作风险的风险评估、风险计量和风险控制的各种技术、方法、工具和方案的分析，并配以实际的案例讲解。</p>
        <h6 class="subTitle">金融风险管理师 (FRM)</h6>
        <p class="brief train">  内容包括数量分析、市场风险衡量与管理、信用风险衡量与管理、操作与整体风险管理、法律、会计与伦理等，将FRM(金融风险管理师)核心课程与中国金融风险管理现实需求结合，度身定制中国金融业需要的金融风险管理专业高端人才。</p>
        <h6 class="subTitle">风险管理数量分析</h6>
        <p class="brief train">  内容包括：金融风险管理的基本原理、金融风险度量的VAR方法及应用、信用风险的度量方法、信用风险的管理方法、风险预算管理、流动性风险管理、操作风险管理、事件风险管理、蒙特卡洛方法、数量分析技术在风险管理中的运用。</p>
    </div>
    <div class="container_index span-5-border">
        <p class="title_index title-188"><strong>服务对象</strong><%--<a href="#" class="more">更多>></a>--%></p>
        <ul class="content span-5">
            <li>民生银行等股份制银行</li>
            <li>山东省农信社等省属银行</li>
            <li>齐鲁银行等城市商业银行</li>
            <li>小额贷款公司与村镇银行</li>
            <li>证券公司及保险担保公司</li>
            <li>地方财政及税务管理部门</li>
            <li>地方银监会证监会金融办</li>
        </ul>
    </div>

</div>
<ul id="friLnk" class="span-24">
    <li class="friLnkT"><strong>友情链接</strong></li>
    <c:forEach items="${links}" var="link" begin="0" step="1">
        <li class="fri"><a href="${link.url}">${fn:substring(link.title,0,13)}</a></li>
    </c:forEach>
</ul>
</body>
</html>