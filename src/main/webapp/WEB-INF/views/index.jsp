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
            $('.anno').cycle();
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
        <a class="read_more" href="#"></a>
    </div>
    </c:forEach>
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
            <h2 class="cufon">新闻资讯</h2>

            <div id="featured"><!-- begin of featured slider -->
                <c:forEach items="${news}" var="newOne" begin="0" step="1">
                <div>
                    <div class="bg-featured"><img src="${ctx}/static/images/featured1.jpg" alt="" class="slidehalf"/>
                    </div>
                    <br/>
                    <strong>${newOne.subject}</strong><br/>
                    <%--// TODO 字数限制 图片 --%>
                    <p class="featured-text">${newOne.message}</p>
                </div>
                </c:forEach>
            </div>
            <!-- begin of featured slider -->
        </div>
    </div>
    <div id="content3">
        <div class="maincontent">
            <h2 class="cufon">公告</h2>
            <ul class="content-list anno">

                <c:forEach items="${posts}" var="post" begin="0" end="2" step="1">
                    <li><a href="${ctx}/article/content/${post.id}" class="announce">${post.subject}</a>
                </li>
                </c:forEach>
            </ul>
            <h5><a href="#">更多公告...</a></h5>
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