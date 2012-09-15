<%--
  金融风险管理研究所
  User: baitao.jibt@gmail.com
  Date: 12-8-24
  Time: 下午19:49
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>金融风险管理研究所</title>
</head>
<body>
<div class="row">
    <div class="span12">
        <img id="banner" src="${ctx}/static/uploads/agency/1336285832603-xUv61T.png"/>
    </div>
</div>
<div class="row">
    <!-- 左栏 -->
    <div class="span10">
        <div class="row">
            <!-- 左左栏 -->
            <div class="span4">
                <!-- 关于我们 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">关于我们</h3>
                    <div class="popover-content">
                        <p>金融风险管理研究所围绕着新资本协议框架，基于流程银行的最佳实践，结合人工智能、数据挖掘技术和各种数据分析方法，研究经济及金融一体化趋势下金融风险的识别、度量和控制理论与应用，特别是金融信用风险评估指标体系、风险分析模型及预警系统、商业银行结构性风险管理系统、证券投资风险预测与管理工具等。研究所依托山东财经大学的学科优势，与相关企业、科研单位在金融机构全面风险管理方面开展产学研合作，促进科技成果的转化与应用。</p>
                        <p>专家团队由具有较高理论造诣的高校教师和具有丰富实际工作经验的业界专家组成。其中教授2人，副教授、高级工程师和高级系统分析师6人，团队成员大多具有博士学位或具有海外学习与工作经历。</p>
                    </div>
                </div>
                <!-- 产学研合作 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">产学研合作</h3>
                    <div class="popover-content">
                        本研究所与山东省城商联盟、山东省农信社等多家金融机构，山东舜德数据管理软件公司等多家国内外企业建立了长期的紧密合作关系。承担国家自然基金项目1项、省部级科研课题及企业委托研发课题6项。独立研究及与合作伙伴共同研发的成果已取得软件著作权6项，申报国家发明专利2项，“基于流程管理的商业银行资产管理系统”和“基于Basel II的商业银行内部评级系统”等多项成果已成功应用于交通银行、广发银行、恒丰银行、齐鲁银行、德州商行及小额贷款公司等非银行金融机构。</p>
                    </div>
                </div>
            </div>
            <!-- 左中栏 -->
            <div class="span6">
                <!-- 学术研究 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">学术研究</h3>
                    <div class="popover-content">
                        <p>围绕着新资本协议框架，基于流程银行的最佳实践，结合人工智能、数据挖掘技术和各种数据分析方法，研究经济及金融一体化趋势下金融信用风险评估指标体系、风险分析模型及预警系统、商业银行风险管理系统、证券投资风险预测模型与管理工具等</p>
                        <h6>商业银行风险度量与管理模型</h6>
                        <p>按照《巴塞尔新资本协议》的要求及框架，研究针对各种风险类型的度量和管理模型，以支持商业银行的风险管理行为。利用最新数据挖掘方法和技术，研究针对已发生业务行为的风险识别模型和未来风险的预测模型。</p>
                        <h6> 商业银行信用风险内部评级体系</h6>
                        <p> 研究信用风险识别工具和计量工具，研制风险监控系统，实现风险识别、预警及全过程的风险监控。研究风险管理部门日常的风险管理工具、方法和风险管理流程。研究基于风险量化结果的风险决策和内部评级的价值应用。</p>
                        <h6>商业银行操作风险及内控管理体系</h6>
                        <p>研究风险区域的选择、风险点的识别监测、风险诱因、关键风险指标选择监测评估、数据的收集、事件管理和损失数据库。进行操作风险的分析评估、趋势分析、计量模型的开发。</p>
                        <h6>客户风险监控模型研究</h6>
                        <p>研究针对客户财务风险的量化分析和预警模型，建立计算客户财务综合风险指数的方法。研究授信客户的现金流未来趋势的预测模型，发现客户的现金流恶化的可能或异常的现金流出。研究客户间关联关系的发现模型及风险预警模型。</p>
                    </div>
                </div>
                <!-- 咨询服务 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">咨询服务</h3>
                    <div class="popover-content">
                        <div class="row">
                            <div class="span3">
                                <ul class="unstyled" style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
                                    <c:forEach items="${infos}" var="info" begin="0" step="1" end="2">
                                        <li class="counseling"><c:if test="${info.message!=''}"><a href="${ctx}/article/content/${info.id}" title="${info.subject}">${info.subject}</a></c:if></li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="span3">
                                <ul class="unstyled" style="overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
                                    <c:forEach items="${infos}" var="info" begin="3" step="1" end="5">
                                        <li class="counseling"><c:if test="${info.message!=''}"><a href="${ctx}/article/content/${info.id}" title="${info.subject}">${info.subject}</a></c:if></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 专家团队 -->
        <div class="row">
            <div class="span10">
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">专家团队</h3>
                    <div class="popover-content">
                        <div class="scrolllist" id="teacher">
                            <a class="abtn aleft" href="#left" title="左移"></a>
                            <div class="imglist_w">
                                <ul class="imglist">
                                    <li>
                                        <a target="_self" href="${ctx}/article/content/70" title="田茂圣"><img width="120" height="166" alt="田茂圣" src="${ctx}/static/uploads/teacher/pic_tianmaosheng.jpg"></a>
                                        <p>田茂圣</p>
                                    </li>
                                    <li>
                                        <a target="_self" href="${ctx}/article/content/72" title="赵志崑"><img width="120" height="166" alt="赵志崑" src="${ctx}/static/uploads/teacher/pic_zhaozhikun.jpg"></a>
                                        <p>赵志崑</p>
                                    </li>
                                    <li>
                                        <a target="_self" href="${ctx}/article/content/71" title="林培光"><img width="120" height="166" alt="林培光" src="${ctx}/static/uploads/teacher/pic_linpeiguang.jpg"></a>
                                        <p>林培光</p>
                                    </li>
                                    <li>
                                        <a target="_self" href="${ctx}/article/content/68" title="刘文金"><img width="120" height="166" alt="刘文金" src="${ctx}/static/uploads/teacher/pic_liuwenjin.jpg"></a>
                                        <p>刘文金</p>
                                    </li>
                                    <li>
                                        <a target="_self" href="${ctx}/article/content/69" title="王帅强"><img width="120" height="166" alt="王帅强" src="${ctx}/static/uploads/teacher/pic_wangshuaiqiang.jpg"></a>
                                        <p>王帅强</p>
                                    </li>
                                </ul>
                            </div>
                            <a class="abtn aright" href="#right" title="右移"></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 右栏 -->
    <div class="span2">
        <!-- 教育培训 -->
        <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
            <h3 class="popover-title">教育培训</h3>
            <div class="popover-content">
                <h6>Basel II与银行风险管理</h6>
                <p>全面风险管理的框架以及风险管理的演进、巴塞尔新资本协议的构成，新旧协议的差别；对银行信用风险、市场风险、操作风险的风险评估、风险计量和风险控制的各种技术、方法、工具和方案的分析，并配以实际的案例讲解。</p>
                <h6>金融风险管理师 (FRM)</h6>
                <p>数量分析、市场风险衡量与管理、信用风险衡量与管理、操作与整体风险管理、法律、会计与伦理等，将FRM(金融风险管理师)核心课程与中国金融风险管理现实需求结合，度身定制中国金融业需要的金融风险管理专业高端人才。</p>
                <h6>风险管理数量分析</h6>
                <p>金融风险管理的基本原理、金融风险度量的VAR方法及应用、信用风险的度量方法、信用风险的管理方法、风险预算管理、流动性风险管理、操作风险管理、事件风险管理、蒙特卡洛方法、数量分析技术在风险管理中的运用。</p>
            </div>
        </div>
        <!-- 服务对象 -->
        <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
            <h3 class="popover-title">服务对象</h3>
            <div class="popover-content">
                <ul class="unstyled">
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
    </div>
</div>
<script type="text/javascript" src="${ctx}/static/js/slider.min.js"></script>
<script type="text/javascript">
    $(function () {
        //默认状态下左右滚动
        $("#teacher").Xslider({
            unitdisplayed:5,
            numtoMove:1,
            unitlen:143,
            loop:"cycle",
            autoscroll:3000
        });
    });
</script>
</body>
</html>