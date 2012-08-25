<%--
 金融服务计算研究所
  User: baitao.jibt@gmail.com
  Date: 12-8-24
  Time: 下午20:39
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
    <title>金融服务计算研究所</title>
</head>
<body>
<div class="row">
    <div class="span13">
<img id="banner" src="${ctx}/static/uploads/agency/1336285889720-RoZ0EU.jpg" width="948px"/>
    </div>
</div>
<div class="row">
    <!-- 左栏 -->
    <div class="span10" style="width:835px">
        <div class="row">
            <!-- 左左栏 -->
            <div class="span4">
                <!-- 关于我们 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">关于我们</h3>
                    <div class="popover-content">
           		<p>金融服务计算研究所主要致力于银行、证券、保险、财税等金融行业特别是中小金融机构信息化领域中的IT基础架构优化设计、信息系统构建、服务支撑体系建设和服务计算技术的应用研究、咨询和服务，为金融业务流程优化和服务创新提供技术支撑。研究所依托山东财经大学的学科优势，与相关合作企业、科研机构及目标用户开展密切的产学研合作，促进科研成果转化，推动金融业特别是金融服务产业的发展。</p>
           		<p>研究团队由具有较高理论造诣的高校教师和具有丰富实际工作经验的业界专家组成。其中教授2人，副教授、高级工程师、系统分析师和架构师6人，大多具有博士学位或具有海外学习与工作经历。</p>
                    </div>
                </div>
                <!-- 产学研合作 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">产学研合作</h3>
                    <div class="popover-content">
            		本研究所与山东省城商联盟、山东省农信社等多家金融机构，银泉科技、山东舜德和CA Technologies等多家国内外企业建立了长期的紧密合作关系。承担国家自然基金项目2项、省自然基金和科技攻关计划项目4项。独立研究及与合作伙伴共同研发的成果已取得软件著作权2项，申报国家发明专利1项，“基于SaaS面向中小企业的金融综合服务平台”“虚拟化金融服务开发与测试环境”等多项成果有望近期应用于全省的小额贷款企业、村镇银行和城市商业银行等。
                    </div>
                </div>
            </div>
            <!-- 左中栏 -->
            <div class="span6" style="width:515px">
                <!-- 学术研究 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">学术研究</h3>
                    <div class="popover-content">
                        <p>依托省部共建的金融信息工程实验室和校企共建的云计算与虚拟化技术实验室，研究面向银行、证券、保险等金融行业应用的新型云计算体系结构、基于SaaS模式的金融信息云服务平台、面向服务的金融业务流程管理与再造、虚拟化的金融服务开发与测试环境和金融云数据中心建设等。主要研究内容：</p>
                        <h6>金融云计算体系结构</h6>
                        <p>云计算是IT技术和服务方式的重大变革。云计算在业务灵活性管理及运营成本方面的具有极大的优势。然而，金融系统毕竟是非常特殊的，他们对数据安全性特别敏感，对客户的隐私性特别关注。基于金融系统的特殊性，研究金融云计算体系结构，建立从基础架构、平台到软件与应用服务的完善体系。</p>
                        <h6>面向中小金融机构基于SaaS的金融综合服务平台</h6>
                        <p>基于SaaS模式按照面向服务的系统架构及软件设计方法，以中小银行业务处理系统中最基础的核心业务系统的研究和搭建工作为起点，研究“服务”的构建方法，建立中小金融机构“服务”的定义、分析设计及开发规范，并按照“单实例、多租户”的模式通过“服务”的方式给各个中小金融机构提供金融业务服务。</p>
                        <h6>虚拟化金融服务开发与测试环境研究</h6>
                        <p>研究通过云环境和虚拟化技术，快速地按照需求构建和部署开发和测试环境。研究建立标准虚拟化模板，支持开发和测试需求的采集，并根据需求进行虚拟化资源配置，并可根据测试结果构建新产品和新服务的部署运行资源配置。</p>
                        <h6>金融云数据中心研究</h6>
                        <p>随着数据量呈指数增长，多数金融机构遇到了存储成本增加和效率下降的问题。研究建立基于云的逻辑上集中统一的金融数据中心，获得动态可扩展性的存储基础架构，通过云存储支持全新的数据分析与挖掘，为实现金融智的提供支撑。</p>
                    </div>
                </div>
                <!-- 咨询服务 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">咨询服务</h3>
                    <div class="popover-content">
                        <div class="row">
                            <div class="span3">
                                <ul class="unstyled">
                                    <c:forEach items="${infos}" var="info" begin="0" step="1" end="2">
                                        <li class="counseling"><c:if test="${info.message!=''}"><a href="${ctx}/article/content/${info.id}">${fn:substring(info.subject,0,15)}</a></c:if></li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="span3">
                                <ul class="unstyled">
                                    <c:forEach items="${infos}" var="info" begin="3" step="1" end="5">
                                        <li class="counseling"><c:if test="${info.message!=''}"><a href="${ctx}/article/content/${info.id}">${fn:substring(info.subject,0,15)}</a></c:if></li>
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
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999;width:835px">
                    <h3 class="popover-title">专家团队</h3>
                    <div class="popover-content">
                        <div class="scrolllist" id="teacher">
                            <a class="abtn aleft" href="#left" title="左移"></a>
                            <div class="imglist_w">
                                <ul class="imglist">
                                    <li>
                                        <a target="_self" href="" title="张抗抗"><img width="120" height="166" alt="张抗抗" src="${ctx}/static/uploads/teacher/pic_zhangkangkang.jpg"></a>
                                        <p>张抗抗</p>
                                    </li>
                                    <li>
                                        <a target="_self" href="" title="徐如志"><img width="120" height="166" alt="徐如志" src="${ctx}/static/uploads/teacher/pic_xuruzhi.jpg"></a>
                                        <p>徐如志</p>
                                    </li>
                                    <li>
                                        <a target="_self" href="" title="杨峰"><img width="120" height="166" alt="杨峰" src="${ctx}/static/uploads/teacher/pic_yangfeng.jpg"></a>
                                        <p>杨峰</p>
                                    </li>
                                    <li>
                                        <a target="_self" href="" title="张燕"><img width="120" height="166" alt="张燕" src="${ctx}/static/uploads/teacher/pic_zhangyan.jpg"></a>
                                        <p>张燕</p>
                                    </li>
                                    <li>
                                        <a target="_self" href="${ctx}/article/content/72" title="赵志崑"><img width="120" height="166" alt="赵志崑" src="${ctx}/static/uploads/teacher/pic_zhaozhikun.jpg"></a>
                                        <p>赵志崑</p>
                                    </li>
                                    <li>
                                        <a target="_self" href="${ctx}/article/content/68" title="刘文金"><img width="120" height="166" alt="刘文金" src="${ctx}/static/uploads/teacher/pic_liuwenjin.jpg"></a>
                                        <p>刘文金</p>
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
    <div class="span3" style="width:165px">
        <!-- 教育培训 -->
        <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
            <h3 class="popover-title">教育培训</h3>
            <div class="popover-content">
                <h6>云计算的基础知识</h6>
                <p>云计算技术概述、Google云计算技术、Amazon云计算技术、 微软云计算技术、开源云计算系统、云计算发展趋势</p>
                <h6>金融云计算的技术架构</h6>
                <p>金融云计算的开发与应用、金融云数据的管理、金融私有云的构建、金融云计算的安全体系</p>
                <h6>金融云计算的企业实践</h6>
                <p>金融云计算的规划与部署、金融云计算平台的企业应用、金融云计算的行业应用</p>
                <h6>金融云计算战略</h6>
                <p>金融企业云计算发展战略、云计算与金融服务创新、云计算前景与投资分析等</p>
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
<script type="text/javascript" src="${ctx}/static/js/slider.js"></script>
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