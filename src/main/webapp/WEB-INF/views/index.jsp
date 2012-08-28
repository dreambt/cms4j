<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sitemesh-page" uri="http://www.opensymphony.com/sitemesh/page" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>首页</title>
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
            $('.anno').cycle();
        });
    </script>
</head>
<body>
<div class="row">
    <div class="span10" style="width:835px">
        <div class="row">
            <!-- 左左栏 -->
            <div class="span4">
                <!-- 首页相册 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">新闻图片</h3>
                    <div class="popover-content">
                        <div id="slideshow">
                            <c:forEach items="${images}" var="image" begin="0" step="1" end="5">
                                <div class="slide-text">
                                    <div class="PicTitle"><a href="#"title="${image.title}">${fn:substring(image.title,0,20)}<c:if test="${fn:length(image.title)>20}">...</c:if></a></div>
                                    <img src="${ctx}/static/uploads/gallery/thumb-272x166/${image.imageUrl}" title="${image.title}" alt="${image.title}" width="270px"
                                         height="166px"/>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <!-- 新闻动态 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">新闻动态</h3>
                    <div class="popover-content">
                        <ul class="unstyled">
                            <c:forEach items="${news1}" var="new1" begin="0" step="1">
                                <li><a href="${ctx}/article/content/${new1.id}">${fn:substring(new1.subject,0,20)}<c:if test="${fn:length(new1.subject)>16}">...</c:if></a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <!-- 通知公告 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">通知公告</h3>
                    <div class="popover-content">
                        <ul class="unstyled">
                            <c:forEach items="${posts}" var="post" begin="0" step="1">
                                <li><a href="${ctx}/article/content/${post.id}">${fn:substring(post.subject,0,20)}<c:if test="${fn:length(post.subject)>16}">...</c:if></a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <!---左中栏----->
            <div class="span6" style="width:515px">
                <!-- 中心简介 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">中心简介</h3>
                    <div class="popover-content">
                        山东省金融信息工程技术研究中心依托山东财经大学的金融、财税、会计、管理、数学和信息技术等雄厚的学科资源，联合行业内相关优势企业，面向我国金融信息化、金融风险管理、金融服务创新与金融服务外包产业发展的实际需要,
                        开展金融信息化相关政策、理论与技术研究，以及人才培养、产品研发与咨询服务。重点研究面向中小金融机构的信息技术解决方案、工具和方法，以工程技术研究中心作为科技成果向生产力转化的中间环节,提高现有科技成果的成熟性、配套性和工程化水平,使中心的技术和业务直达金融信息技术服务市场价值链的上游,加速金融服务创新和金融信息化科技成果向现实生产力的转化。目前中心主持国家级科研课题4项，省部级科研课题5项,取得软件著作权6项，申报国家发明专利3项。独立研究及与合作伙伴共同研发的多项成果已成功应用于交通银行、广发银行、恒丰银行、德州商行和多家小额贷款公司。
                    </div>
                </div>
                <!-- 学术研究 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">学术研究</h3>
                    <div class="popover-content">
                        <a href="${ctx}/research/1"><strong>金融风险管理研究所</strong></a> 围绕新资本协议框架，基于流程银行的最佳实践，研究经济及金融一体化趋势下金融风险的识别、度量和控制理论与应用。<br />
                        <a href="${ctx}/research/2"><strong>金融数据管理研究所</strong></a> 解决银行、证券、保险、财政、税务等金融领域信息化建设中的数据治理、数据整合、数据仓库建设、数据挖掘技术与数据应用问题。<br />
                        <a href="${ctx}/research/3"><strong>金融服务计算研究所</strong></a> 致力于银行、证券、保险、财税等金融行业特别是中小金融机构信息化领域中的IT基础架构优化设计、信息系统构建、服务支撑体系建设。<br />
                        <a href="${ctx}/research/4"><strong>金融信息安全研究所</strong></a> 致力于金融行业信息化建设中的网络与信息安全理论与应用研究，重点在网络信息安全系统建设、信息系统风险管理、信息系统安全审计等领域。
                    </div>
                </div>
                <!-- 咨询服务 -->
                <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
                    <h3 class="popover-title">咨询服务</h3>
                    <div class="popover-content">
                        <div class="row">
                            <div class="span3">
                                <ul class="unstyled">
                                    <c:forEach items="${infos}" var="info" begin="0" step="1" end="3">
                                        <li class="counseling"><c:if test="${info.message!=''}"><a href="${ctx}/article/content/${info.id}">${fn:substring(info.subject,0,15)}</a></c:if></li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="span3">
                                <ul class="unstyled">
                                    <c:forEach items="${infos}" var="info" begin="4" step="1" end="6">
                                        <li class="counseling"><c:if test="${info.message!=''}"><a href="${ctx}/article/content/${info.id}">${fn:substring(info.subject,0,15)}</a></c:if></li>
                                    </c:forEach>
                                    <li class="lastM"><span> <a href="${ctx}/article/listInfo" class="more">更多...</a></span></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 右边栏 -->
    <div class="span3" style="width:165px">
        <!-- 研究机构 -->
        <div class="popover top" style="display:block;position:relative;width:98%;z-index:999">
            <h3 class="popover-title">研究机构</h3>
            <div class="popover-content">
                <ul class="unstyled">
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
        </div>
        <!-- 服务对象 -->
        <div class="popover top" style="display:block;position:relative;width:98%;z-index:999">
            <h3 class="popover-title">服务对象</h3>
            <div class="popover-content">
                <ul class="unstyled">
                    <li>民生银行等股份制银行</li>
                    <li>山东省农信社等省属银行</li>
                    <li>山东省城市银行合作联盟</li>
                    <li>齐鲁银行等城市商业银行</li>
                    <li>小额贷款公司与村镇银行</li>
                    <li>证券公司及保险担保公司</li>
                    <li>地方财政及税务管理部门</li>
                    <li>地方银监会证监会金融办</li>
                </ul>
            </div>
        </div>
        <!-- 行业资讯 -->
        <div class="popover top" style="display:block;position:relative;width:98%;z-index:999">
            <h3 class="popover-title">行业资讯</h3>
            <div class="popover-content">
                <ul class="unstyled">
                    <c:forEach items="${news2}" var="new2" begin="0" step="1">
                        <li><a href="${ctx}/article/content/${new2.id}">${fn:substring(new2.subject,0,10)}<c:if test="${fn:length(new2.subject)>10}">...</c:if></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- 专家团队 -->
<div class="row">
    <div class="span13">
        <div class="popover top" style="display:block;position:relative;width:100%;z-index:999">
            <h3 class="popover-title">专家团队</h3>
            <div class="popover-content">
                <div class="scrolllist_index" id="teacher">
                    <a class="abtn aleft" href="#left" title="左移"></a>
                    <div class="imglist_w">
                        <ul class="imglist">
                            <li>
                                <a target="_self" href="${ctx}/article/content/74" title="聂培尧"><img width="120" height="166" alt="聂培尧" src="${ctx}/static/uploads/teacher/pic_niepeiyao.jpg"></a>
                                <p>聂培尧</p>
                            </li>
                            <li>
                                <a target="_self" href="${ctx}/article/content/73" title="中心主任徐如志"><img width="120" height="166" alt="徐如志" src="${ctx}/static/uploads/teacher/pic_xuruzhi.jpg"></a>
                                <p>徐如志</p>
                            </li>
                            <li>
                                <a target="_self" href="${ctx}/article/content/75" title="中心副主任郭建峰"><img width="120" height="166" alt="郭建峰" src="${ctx}/static/uploads/teacher/pic_guojianfeng.jpg"></a>
                                <p>郭建峰</p>
                            </li>
                            <li>
                                <a target="_self" href="${ctx}/article/content/70" title="山东舜德数据管理软件工程有限公司总经理"><img width="120" height="166" alt="田茂圣" src="${ctx}/static/uploads/teacher/pic_tianmaosheng.jpg"></a>
                                <p>田茂圣</p>
                            </li>
                            <li>
                                <a target="_self" href="${ctx}/article/content/72" title="赵志崑副教授，工学博士，硕士生导师"><img width="120" height="166" alt="赵志崑" src="${ctx}/static/uploads/teacher/pic_zhaozhikun.jpg"></a>
                                <p>赵志崑</p>
                            </li>
                            <li>
                                <a target="_self" href="" title="张抗抗副教授，工学博士，硕士生导师"><img width="120" height="166" alt="张抗抗" src="${ctx}/static/uploads/teacher/pic_zhangkangkang.jpg"></a>
                                <p>张抗抗</p>
                            </li>
                            <li>
                                <a target="_self" href="${ctx}/article/content/66" title="盛秋戬"><img width="120" height="166" alt="盛秋戬" src="${ctx}/static/uploads/teacher/pic_shengqiujian.jpg"></a>
                                <p>盛秋戬</p>
                            </li>
                            <li>
                                <a target="_self" href="${ctx}/article/content/71" title="林培光副教授"><img width="120" height="166" alt="林培光" src="${ctx}/static/uploads/teacher/pic_linpeiguang.jpg"></a>
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
                            <li>
                                <a target="_blank" href="${ctx}/article/content/67" title="万海山"><img width="120" height="166" alt="万海山" src="${ctx}/static/uploads/teacher/pic_wanhaishan.jpg"></a>
                                <p>万海山</p>
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
                                <a target="_blank" href="${ctx}/article/content/62" title="赵华伟"><img width="120" height="166" alt="赵华伟" src="${ctx}/static/uploads/teacher/pic_zhaohuawei.jpg"></a>
                                <p>赵华伟</p>
                            </li>
                            <li>
                                <a target="_blank" href="${ctx}/article/content/64" title="聂秀山博士， 副教授"><img width="120" height="166" alt="聂秀山" src="${ctx}/static/uploads/teacher/pic_niexiushan.jpg"></a>
                                <p>聂秀山</p>
                            </li>
                            <li>
                                <a target="_blank" href="${ctx}/article/content/65" title="王倩"><img width="120" height="166" alt="王倩" src="${ctx}/static/uploads/teacher/pic_wangqian.jpg"></a>
                                <p>王倩</p>
                            </li>
                            <!--
                <li>
                    <a target="_blank" href="${ctx}/article/content4" title="谭璐"><img width="120" height="166" alt="谭璐" src="${ctx}/static/uploads/teacher/pic_tanlu.jpg"></a>
                    <p>谭璐</p>
                </li>   -->
                        </ul>
                    </div>
                    <a class="abtn aright" href="#right" title="右移"></a>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/static/js/slider.js"></script>
<script type="text/javascript">
    $(function(){
        //默认状态下左右滚动
        $("#teacher").Xslider({
            unitdisplayed:5,
            numtoMove:1,
            unitlen:126,
            loop:"cycle",
            autoscroll:3000
        });
    });
</script>
</body>
</html>