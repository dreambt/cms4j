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
        <img src="${ctx}/static/uploads/gallery/thumb-460x283/${image.imageUrl}" alt="" class="slidehalf"/>
        <h2>${image.title}</h2>
        <p>${image.description}</p>
        <a class="查看更多" href="#"></a>
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
            <h2 class="cufon">中心简介</h2>
            <p style="text-indent:28px;line-height:180%;text-align:left;">中心依托山东财经大学的金融、财税、会计、管理、数学和信息技术等雄厚的学科资源，联合行业内相关优势企业，为推动我国金融信息化的发展及相关技术的研究而成立的一个开放的专业从事与金融信息化和金融风险管理相关的理论与应用技术研究、教育培训与咨询服务的组织。</p>
            <p style="text-indent:28px;line-height:180%;text-align:left;">中心于2010年12月经山东省科技厅批准成立，是省内在金融信息化行业领域唯一的省级工程技术研究中心。下设计算金融研究所、金融风险管理研究所、金融信息安全研究所等若干个在业务上相对独立的研究所；设金融智能实验室等以理论和技术研究为主的专业实验室与研究室。</p>
            <p style="text-indent:28px;line-height:180%;text-align:left;">目前，中心与山东省城商联盟、齐鲁证券等金融机构，北京用友、山东舜德数据及加拿大Goitsys等国内外企业建立了长期的紧密合作关系。现已形成一支由30余人组成的研发团队，其中“国家千人计划”特聘专家1人，5人来自清华大学、上海交通大学、澳大利亚昆士兰大学、美国Texas州立大学的博士后。</p>
            <a href="${ctx}/article/content/20" style="color:#FF4E00!important;">查看更多>>></a>
        </div>
    </div>
    <div id="content2">
        <div class="maincontent">
            <h2 class="cufon">新闻资讯</h2>
            <div id="featured"><!-- begin of featured slider -->
                <c:forEach items="${news}" var="newOne" begin="0" end="4" step="1">
                <div>
                    <div class="bg-featured"><a href="${ctx}/article/content/${newOne.id}"><img src="${ctx}/static/uploads/article/news-thumb/${newOne.imageName}" alt="" class="slidehalf"/></a>
                    </div>
                    <br/>
                    <strong><a href="${ctx}/article/content/${newOne.id}">${newOne.subject}</a></strong><br/>
                    <%--// TODO 字数限制 图片 --%>
                    <p class="featured-text">${newOne.digest}</p>
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
                <c:forEach items="${posts}" var="post" begin="0" end="4" step="1">
                    <li><a href="${ctx}/article/content/${post.id}" class="announce">${fn:substring(post.subject,0,20)}<c:if test="${fn:length(post.subject)>20}">...</c:if></a>
                </li>
                </c:forEach>
            </ul>
            <a href="${ctx}/article/listPost" style="">查看更多>>></a>
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