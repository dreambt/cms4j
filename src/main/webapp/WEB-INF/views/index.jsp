<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
        });
    </script>
</head>
<body>
<!-- BEGIN SLIDER -->
<div id="slideshow">
    <c:forEach items="${images}" var="image" begin="0" step="1">
    <div class="slide-text">
        <img src="${ctx}/static/uploads/gallery/index-thumb/${image.imageUrl}" alt="" class="slidehalf"/>

        <h1>${image.title}</h1>

        <p>${image.description}</p>
        <a class="read_more" href="#"><%----%>&raquo;</a>
    </div>
    </c:forEach>
    <!-- end of slide1 -->

    <%--<div class="slide-text">
        <img src="${ctx}/static/images/slide2.jpg" alt="" class="slidehalf"/>

        <h1>企业家俱乐部...</h1>

        <p>
            山东省企业家俱乐部作为山东省内最具影响力的商业领袖俱乐部，服务企业家的社会公益活动，帮助山东企业家集聚产、研、政人脉，通过已有的丰富资源、独特优势、全新高效的运作、高品位的活动、周全务实的服务，为山东省商业领袖思想交流、精神互动的非盈利平台。</p>
        <a class="read_more" href="#">了解详情 &raquo;</a>
    </div>
    <!-- end of slide2 -->

    <div class="slide-text">
        <img src="${ctx}/static/images/slide3.jpg" alt="" class="slidehalf"/>

        <h1>环境关怀...</h1>

        <p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum
            deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non
            provident, similique sunt in culpa qui officia deserunt mollitia animi.</p>
        <a class="read_more" href="#">了解详情 &raquo;</a>
    </div>
    <!-- end of slide3 -->

    <div class="slide-text">
        <img src="${ctx}/static/images/slide4.jpg" alt="" class="slidehalf"/>

        <h1>专业的工作...</h1>

        <p>Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod
            maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus,
            temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet.</p>
        <a class="read_more" href="#">了解详情 &raquo;</a>
    </div>
    <!-- end of slide4 -->--%>
</div>
<div id="box-nav-slider">
    <div id="slideshow-navigation">
        <div id="pager"></div>
    </div>
</div>
<!-- END OF SLIDER -->

<!-- BEGIN CONTENT -->
<div id="content">
    <div id="content1">
        <div class="maincontent">
            <h2 class="cufon"><span class="orange">中心简介</span></h2>

            <p>
                中心设有证书培训、政府培训、企业高管培训、专业培训、学历培训共五个系列的涉及金融、财税、银行、投资、工商管理等学科的高端培训。我们为金融、财经、投资界的青年和精英们提供金融风险管理师、理财规划师等专业培训，以满足我国对高端金融人才的需求。我们为各级政府的金融、财税部门提供政策和理论培训，并组织第一线的实地调研活动，为各级领导及公职人员提供理论参考和实际经验。同时，我们还为国内外知名银行、保险、基金、证券等金融投资机构提供各种有针对性的企业内训课程和职业发展课程，并建立起长期战略合作关系。 </p>

            <p>我们帮助财经金融界的有志青年提升自身价值，明确职业发展方向；我们为政府机构服务，提供理论研究和调研平台，为关系到国计民生的政策制定和调整提供有力保障；我们与企业为伴，促进国内外企业的技术交流和产业合作，打造一个高效的信息流通平台。</p>
            <p>我们的目标是成为金融信息工程理论与方法的创新研究基地、金融信息化高端人才的培养基地、金融信息化产业的中试基地、金融信息工程研究与应用的人才库和知识库。</p>

        </div>
    </div>
    <div id="content2">
        <div class="maincontent">
            <h2 class="cufon">新闻简报</h2>

            <div id="featured"><!-- begin of featured slider -->
                <div>
                    <div class="bg-featured"><img src="${ctx}/static/images/featured1.jpg" alt="" class="slidehalf"/>
                    </div>
                    <br/>
                    <strong>企业海外并购高级研修班</strong><br/>

                    <p class="featured-text">山东财经大学企业海外并购高级研修班将带你一起解析时下最热门的经济话题：中国企业走出国门，进行海外并购。 2000年我国加人WTO至今，中国企业对外投资开始了第二高峰。对外投资总额从2000年的20多亿美元激增到2001年的70多亿美元，此时的中国企业意识到只有走出国门，融人到世界经济体系当中，才能有更强的生存能力。
                        为何中国企业的并购对象集中在发达国家？中国企业如何大规模借助外部融资，达到自己拓展海外的目的？中国企业要如何破解在海外并购中遇到的法律困境？</p>
                </div>
                <!-- end of featured1 -->
                <div>

                    <div class="bg-featured"><img src="${ctx}/static/images/featured2.jpg" alt="" class="slidehalf"/>
                    </div>
                    <br/>
                    <strong>首次理事会议</strong><br/>

                    <p class="featured-text">理事长致辞，并宣布山东省金融论坛理事会成立理事长致辞，并宣布山东省金融论坛理事会成立理事长致辞，并宣布山东省金融论坛理事会成立理事长致辞，并宣布山东省金融论坛理事会成立理事长致辞，并宣布山东省金融论坛理事会成立理事长致辞，并宣布山东省金融论坛理事会成立理事长致辞，并宣布山东省金融论坛理事会成立理事长致辞，并宣布山东省金融论坛理事会成立理事长致辞，并宣布山东省金融论坛理事会成立理事长致辞，并宣布山东省金融论坛理事会成立...</p>
                </div>
                <!-- end of featured2 -->
                <div>

                    <div class="bg-featured"><img src="${ctx}/static/images/featured3.jpg" alt="" class="slidehalf"/>
                    </div>
                    <br/>
                    <strong>论坛策划</strong><br/>

                    <p class="featured-text">山东省中小企业融资与私募股权基金发展论坛改革开放来，我国中小企业迅速发展，调整了我国的产业结构，缓解了就业压力，同时促进了科技创新以及经济增长，成为了我国有活力、有生机的经济增长点。当前，卷席而来的金融危机，深刻地影响全球的经济社会发展以及实体经济，给我国中小企业带来了空前的困难。目前，温州企业困境反映出我国当前中小企业之困，中小企业发展中最大的瓶颈是资金缺乏，中小企业如何谋得融资，政策、环境、金融等如何发力，已经成为政府、企业和学术界共同关注和亟待解决的问题。</p>
                </div>
                <!-- end of featured3 -->
            </div>
            <!-- begin of featured slider -->
        </div>
    </div>
    <div id="content3">
        <div class="maincontent">
            <h2 class="cufon">公告</h2>
            <ul class="content-list">
                <c:forEach items="${posts}" var="post" begin="0" end="1" step="1">
                <li><a href="${ctx}/article/content/${post.id}">${post.subject}</a></li>
                </c:forEach>
            </ul>
        </div>
        <div class="maincontent">
            <h2 class="cufon">我们的优势</h2>

           <!-- <p>
                山东省金融信息工程技术培训中心是经山东省科技厅批准，依托山东财经大学金融、财税、会计、管理、数学和信息技术等雄厚的学科资源，联合行业内相关优势企业成立的一个开放的专业从事与金融信息化和金融风险管理相关的理论与应用技术研究、教育培训与咨询服务的组织。</p>
             -->
            <p><img src="${ctx}/static/images/advantage-icon1.jpg" alt="" class="imgleft"/>
                <strong>关于学术</strong><br/>
              金融信息化高端人才的培养基地、金融信息化产业的中试基地、金融信息工程研究与应用的人才库和知识库。</p>

            <p><img src="${ctx}/static/images/advantage-icon2.jpg" alt="" class="imgleft"/>
                <strong>关于师资</strong><br/>
                山东金融信息技术研究中心高薪聘请了全国各地的MBA、在职研究生、在职博士等专业领域强人。</p>

            <p><img src="${ctx}/static/images/advantage-icon3.jpg" alt="" class="imgleft"/>
                <strong>关于职业规划和人脉资源</strong><br/>
                依赖多年的行业经验，为学员提供职业规划服务，并利用人脉资源，为学员和金融单位之间牵线搭桥。</p>
        </div>
    </div>

    <!-- BEGIN BOTTOM BOX -->
    <div id="bottom-box">
        <div id="bottom-box-inner">
            <div class="box1">
                <img src="${ctx}/static/images/feature-bottom1.png" alt="" class="imgleft-bottom"/>
                <h4>参与活动..!!</h4>
                【首次理事会议】<br>
                1、日期：2011年12月3日 （下午 15:00—17:30）<br>
                2、理事长致辞，并宣布山东省金融论坛理事会成立 <br>
            </div>
            <div class="box2">
                <img src="${ctx}/static/images/feature-bottom2.png" alt="" class="imgleft-bottom"/>
                <a href=""><h4> 培训课程&nbsp;>></h4></a>
                <a href="">客户经理基本技能培训班</a><br/>
                <a href="">客户经理基本技能培训班</a><br/>
                <a href="">客户经理基本技能培训班</a><br/>
                <a href="">客户经理基本技能培训班</a><br/>
            </div>
        </div>
    </div>
    <!-- END OF BOTTOM BOX -->

</div>
<!-- END OF CONTENT -->
</body>
</html>