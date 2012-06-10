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
    <title>${article.subject} - ${article.category.categoryName}</title>
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
        <h2>${article.category.categoryName}</h2>
    </div>
    <div class="desc">${article.digest}</div>
</div>
<!-- END OF PAGE TITLE -->
<div id="content-inner">
    <div id="content-left">
        <div class="maincontent">
            <div class="blog-post">
                <h2>${article.subject}</h2>
                <div class="blog-posted-inner">
                    作者: ${article.user.username} &nbsp; | &nbsp; 发表时间: <fmt:formatDate value="${article.createdDate}" pattern="yyyy年MM月dd日 hh:mm:ss"/> &nbsp; | &nbsp;
                    浏览次数: ${article.views} <c:if test="${article.allowComment}">&nbsp; | &nbsp; 评论数: ${fn:length(article.commentList)}</c:if>
                </div>
                ${article.message}
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
                <div id="addCommentContainer">
                    <form:form id="commentForm" modelAttribute="comment" action="" method="post">
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
                                <div class="l_text" id="imgid" style="display: block;margin-left: 60px;position: absolute;z-index: 9999;bottom:80px; ">&nbsp;</div>
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
        var subject=$('#subject');
        var myEditor=$('#myEditor');
        var c=$('#captcha');

        //focusEvent(myEditor);
        function focusEvent(domm){
              domm.focus(function(){$(this).css('border','1px solid #CCC');});
        }

        // AJAX 发表评论
        var working = false;
        $('#commentForm').submit(function(e){
            e.preventDefault();
            if(working) return false;

            working = true;
            $('#submit').val('提交中...');
            //$('span.error').remove();

            if(subject.val() ==""||!checkEmail(subject.val())){alert("请您填写您的邮箱！");working = false;$('#submit').val(' 提 交 ');return false;};
            if(myEditor.val()==""||myEditor.val().length<5||myEditor.val().length>200){alert("请您填写评论内容，字数为：5-200");working = false;$('#submit').val(' 提 交 ');return false;};
            if(c.val()==""){alert("请您填写验证码！");working = false;$('#submit').val(' 提 交 ');return false;};

            $.post('${ctx}/comment/create',$(this).serialize(),function(msg){
                working = false;
                $('#submit').val(' 提 交 ');

                if(msg.status==1){
                    /* If the insert was successful, add the comment below the last one on the page with a slideDown effect */
                    $("<div class='commentList-item-wrapper'><h4><a href='#'>"+subject.val()+"</a> 于 今天 发表评论：</h4>"+myEditor.val()+"</div>").hide().insertBefore('#addCommentContainer').slideDown();
                    alert("发表评论成功，请耐心等待审核通过");
                }
                else {
                    /* If there were errors, loop through the msg.errors object and display them on the page */
                    $.each(msg.errors,function(k,v){
                        $('label[for='+k+']').append('<span class="error">'+ v +'</span>');
                    });
                    alert(msg.message);
                }
            },'json');

        });

        //totop
        $().UItoTop({ easingType:'easeOutQuart' });

        //验证码点击时显示
       var img="<img id='checkNum' src='${ctx}/captcha.png' alt='验证码' style='cursor:pointer;vertical-align:text-bottom;position:absolute'>";
        $('#captcha').click(function(){$('#imgid').show().append(img)}).blur(function(){$('#imgid').hide()});

        //设置图片宽度最大为676px
        $('img').each(function(i){
            //alert($(this).width());
            if($(this).width()>676){
                var b=676/($(this).width());
                $(this).width(676);
                $(this).height($(this).height()*b);
            }
        });

        //验证邮箱，正确返回true，错误返回false
        function checkEmail(email){
            var emailRegExp = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
            if (!emailRegExp.test(email)||email.indexOf('.')==-1){
                return false;
            }else{
                return true;
            }
        }
    });
</script>
</body>
</html>