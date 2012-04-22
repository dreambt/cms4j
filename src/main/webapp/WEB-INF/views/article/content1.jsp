<%--
  文章正文
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-18
  Time: 上午10:55
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>万海山 - 学术骨干</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/ui.totop.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/static/Ueditor/themes/default/ueditor.css">
    <link href="${ctx}/static/jquery-validation/1.9.0/validate.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/jquery/comment.css" type="text/css" rel="stylesheet"/>
    <script src="${ctx}/static/jquery-validation/1.9.0/jquery.validate.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/jquery-validation/1.9.0/messages_cn.js" type="text/javascript"></script>
    <script src="${ctx}/static/jquery/comment.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/jquery.ui.totop.js" type="text/javascript"></script>
</head>
<body>
<!-- BEGIN PAGE TITLE -->
<div id="page-title">
    <div class="title"><!-- your title page -->
        <h2 class="cufon">学术骨干</h2>
    </div>
    <div class="desc">${article.digest}</div>
</div>
<!-- END OF PAGE TITLE -->
<div id="content-inner">
    <div id="content-left">
        <div class="maincontent">
            <div class="blog-post">
                <h2>万海山</h2>
                <div class="blog-posted-inner">
                    作者: ${article.user.username} &nbsp; | &nbsp; 发表时间: <fmt:formatDate value="${article.createdDate}" pattern="yyyy年MM月dd日 hh:mm:ss"/> &nbsp; | &nbsp;
                    浏览次数: ${article.views} <c:if test="${article.allowComment}">&nbsp; | &nbsp; 评论数: ${fn:length(article.commentList)}</c:if>
                </div>
                <div align="center"><img src="${ctx}/static/uploads/agency/1.jpg" /></div><br/><br/>
                金融信息安全研究所所长，山东中孚信息产业股份有限公司副总经理。1994年以来，一直从事信息安全产品的研究与开发，尤其是在商用密码领域，积累了丰富的实践经验和深刻的行业理解。
                作为主要技术负责人，参与开发的“公钥密码快速实现技术”项目获国家科技进步三等奖。以此成果为基础，作为主要技术负责人，研发了国内第一款商用密码卡和密码机，已广泛应用于国内的电子商务和电子政务领域。作为主要技术负责人，参与开发的“商业电子信息安全认证数字证书管理系统”是国内最早的自主研发的大型商业化数字证书系统，并获外经贸部科技进步一等奖。同时作为项目负责人，参与了“PKI安全体系结构的研究”、“PKI/PMI高速密码设备研发“等5个国家“863”重大科技攻关项目，为国内PKI技术的发展起到重要作用。
                获奖情况：
                	国家科技进步三等奖          1999年
                	外贸部科技进步一等奖        1999年
                	山东省中小企业科技进步奖    2010年
                	济南市科技进步一等奖        2011年

            </div>
            <c:if test="${not empty relatedArticles}">
            <div id="recentPostList"><!-- relatedPostList -->
                <div id="related-post-title"><h4>相关文章</h4></div>
                <div class="related-item-wrapper">
                    <h4><a href="#">相关文章1</a></h4>
                    <img src="${ctx}/static/images/blog-pic2.jpg" alt="" class="imgleft"/>
                    <!-- some words -->
                </div>
                <div class="related-item-spacer">&nbsp;</div>
                <div class="related-item-wrapper">
                    <h4><a href="#">相关文章2</a></h4>
                    <img src="${ctx}/static/images/blog-pic3.jpg" alt="" class="imgleft"/>
                    <!-- some words -->
                </div>
            </div>
            </c:if>
            <c:if test="${article.allowComment}">
                <div id="commentList">
                    <div id="commentList-title"><h4>相关评论</h4></div>
                    <c:choose><c:when test="${fn:length(article.commentList) > 0}">
                        <c:forEach items="${article.commentList}" var="comment" begin="0" step="1" varStatus="stat">
                            <c:if test="${comment.status&&!comment.deleted}">
                                <div class="commentList-item-wrapper">
                                    <h4><a href="#">${comment.username}</a> 于 <fmt:formatDate value="${comment.createdDate}" pattern="yyyy-MM-dd"/> 发表评论：</h4>
                                        ${comment.message}
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:when><c:otherwise>
                        <div class="commentList-item-wrapper"><h4>暂时没有, 发表一下您的观点吧</h4></div>
                    </c:otherwise></c:choose>
                </div>
                <div id="comment">
                    <form:form id="commentForm" modelAttribute="comment" action="${ctx}/comment/create" method="post">
                            <div class="quiz">
                                <h3>我要评论</h3>
                                <div class="quiz_content">
                                    <input type="hidden" name="article.id" value="${article.id}"/>
                                    <div class="l_text"><label class="m_flo">邮  箱：</label>
                                        <input type="text" id="subject" name="username" class="email" value="<shiro:principal property="loginName"/>"/>
                                    </div>
                                    <div class="goods-comm">
                                        <div class="goods-comm-stars"><span class="star_l">满意度：</span>
                                            <div class="rate-comm" id="rate-comm-1">&nbsp;</div>
                                        </div>
                                    </div>
                                    <div class="l_text"><label class="m_flo">内  容：</label><textarea class="text" id="myEditor" name="message"></textarea><span class="tr">字数限制为5-200个</span></div>
                                    <div class="l_text" id="imgid" style="display: block;margin-left: 60px;position: absolute;z-index: 9999;bottom:70px; ">&nbsp;</div>
                                    <div class="l_text"><label class="m_flo">验证码：</label><input type="text" id="captcha" name="captcha" /> </div>
                                </div>
                            <input type="submit" class="input-submit" value=" 提 交 " id="submit"/>
                        </div>
                    </form:form>
                </div>
            </c:if>
        </div>
    </div>
    <!--sidebox-->
    <%@include file="/WEB-INF/layouts/sidebar.jsp" %>
</div>
<script>
    $(function () {
        /*
        $("#commentForm").validate({
            rules:{message:{required:true,maxlength:600,minlength:5}}
        });
        */
        var subject=$('#subject');
        var myEditor=$('#myEditor');
        var c=$('#captcha');

        //focusEvent(myEditor);
        function focusEvent(domm){
              domm.focus(function(){$(this).css('border','1px solid #CCC');});
        }
       // subject.live('change',function(){if(subject.val().length>5||subject.val().length<200||subject.val()!=""){subject.css('border','1px solid #CCC');}});
        //表单校验
      /* $('#submit').click(function(){
           //alert(c.val().length);
           if(subject.val() ==""){subject.css('border','1px solid #f00');return false;};
           if(myEditor.val()==""||myEditor.val().length<5||myEditor.val().length>200){myEditor.css('border','1px solid #f00');return false;};
           if(c.val()==""){c.css('border','1px solid #f00');return false;};
       });   */
        $('#submit').click(function(){
            //alert(c.val().length);
            if(subject.val() ==""){alert("请您填写您的邮箱！");return false;};
            if(myEditor.val()==""||myEditor.val().length<5||myEditor.val().length>200){alert("请您填写评论内容，字数为：5-200");return false;};
            if(c.val()==""){alert("请您填写验证码！");return false;};
        });
        //totop
        $().UItoTop({ easingType:'easeOutQuart' });

        //验证码点击时显示
       var img="<img id='checkNum' src='${ctx}/captcha.png' alt='验证码'style='cursor:pointer;vertical-align:text-bottom;position:absolute'>";
        $('#captcha').click(function(){$('#imgid').show().append(img)});
        $('#captcha').blur(function(){$('#imgid').hide()});
       // $('#captcha').focus(function(){$('#imgid').show().append(img)});
        //设置图片宽度最大为621px
        $('img').each(function(i){
            //alert($(this).width());
            if($(this).width()>621){
                var b=621/($(this).width());
                $(this).width(621);
                $(this).height($(this).height()*b);
            }
        });
    });
</script>
</body>
</html>