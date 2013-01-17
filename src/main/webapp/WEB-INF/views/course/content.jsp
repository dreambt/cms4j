<%--
  文章正文
  User: baitao.jibt@gmail.com
  Date: 12-8-24
  Time: 下午16:09
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="joda" uri="http://www.joda.org/joda/time/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>课程介绍</title>
</head>
<body>
<!-- 左边栏 -->
<%@include file="/WEB-INF/layouts/sidebar.jsp" %>
<div class="index_right">
    <div class="blog-header">${course.courseName}</div>
    <div class="blog-post">
        ${course.description1}
        <div class="product_sideright_tap">
            <div class="product_siderght_tab1">选择涛峰</div>
        </div>
        <div class="erji4 f14"><p><span style="color: #ff0000">　　1.中国移动互联网研发培训第一品牌，专注Android、iPhone、WP移动互联开发培训机构。<br>
　　2.权威资深IT培训师资阵容，业内最具责任心、最懂教学、最强技术、有大型项目经验实战派讲师授课，来自清华、外企等世界500强IT企业。<br>
　　3.零学费入学，工作后分期还清学费，不就业不收一分钱学费，培训就业协议明确写出薪水保障，最低薪水专科4000起，本科5000起，硕士6000起，绝非推荐就业。<br>
　　4.拥有自主知识产权的手机开发培训课程体系，课程内容紧贴当前技术热点，前沿流行技术和企业实际需求。<br>
　　5.企业级项目实战训练，针对企业需求研发了近10个企业级真实项目进行练习，让学员接触企业级开发。<br>
　　6.最严格、最科学、最负责的教学就业管理制度，并有专业的职业素养课和就业指导课，保证教学就业质量。<br>
　　7.一周免费试听，培训过程中如有内容理解不透或消化不好，可免费在下期班中重听或者申请补课。<br>
　　8.为学员终身提供免费技术支持，免费参与千锋举办的各类技术沙龙和活动。</span></p></div>
    <div class="product_sideright_tap">
        <div class="product_siderght_tab1">涛峰优势</div>
    </div>
    <div class="erji4 f14">${course.description2}</div>
    <div class="product_sideright_tap">
        <div class="product_siderght_tab1">招生对象</div>
    </div>
    <div class="erji4 f14">${course.description3}</div>
    <div class="product_sideright_tap">
        <div class="product_siderght_tab1">费用优惠</div>
    </div>
    <div class="erji4 f14">${course.description4}</div>
    <div class="product_sideright_tap">
        <div class="product_siderght_tab1">课程教材</div>
    </div>
    <div class="erji4 f14">${course.description5}</div>
    <div class="product_sideright_tap">
        <div class="product_siderght_tab1">实验设备</div>
    </div>
    <div class="erji4 f14">${course.description6}</div>
    <div class="product_sideright_tap">
        <div class="product_siderght_tab1">任职岗位</div>
    </div>
    <div class="erji4 f14">${course.description7}</div>
    <div class="product_sideright_tap">
        <div class="product_siderght_tab1">课程大纲</div>
    </div>
    <div class="erji4 f14">${course.description8}</div>
    <div class="product_sideright_tap">
        <div class="product_siderght_tab1">实训项目</div>
    </div>
    <div class="erji4 f14">${course.description9}</div>
    </div>
    <c:if test="${article.allowComment}">
    <!-- Duoshuo Comment BEGIN -->
	<div class="ds-thread" data-thread-key="" 
	data-title="" data-author-key="" data-url=""></div>
	<script type="text/javascript">
	var duoshuoQuery = {short_name:"sdfie"};
	(function() {
		var ds = document.createElement('script');
		ds.type = 'text/javascript';ds.async = true;
		ds.src = 'http://static.duoshuo.com/embed.js';
		ds.charset = 'UTF-8';
		(document.getElementsByTagName('head')[0] 
		|| document.getElementsByTagName('body')[0]).appendChild(ds);
	})();
	</script>
    <!-- Duoshuo Comment END -->
        </c:if>
</div>
<script>
    $(function() {
        //设置图片宽度最大为676px
        $('.blog-post img').each(function(i){
            //alert($(this).width());
            if($(this).width()>676){
                var b=676/($(this).width());
                $(this).width(676);
                $(this).height($(this).height()*b);
            }
        });
    });
</script>
</body>
</html>