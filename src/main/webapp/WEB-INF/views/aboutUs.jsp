<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>关于我们</title>
    <link href="${ctx}/static/fancyBox/jquery.fancybox.css" type="text/css" rel="stylesheet"/>
    <script src="${ctx}/static/fancyBox/jquery.fancybox.pack.js" type="text/javascript"></script>
</head>
<body>
<div class="page page-ex">
    <div class="row-fluid team">
        <p class="span6 thumbnail">
            <a class="fancybox-effects" href="${ctx}/static/images/headPic/dreambt-big.jpg"
               title="纪柏涛 个人网站http://www.im47.cn"><img src="${ctx}/static/images/headPic/dreambt.jpg" width="120px"
                                                       height="120px"/></a>
            <strong>纪柏涛 <br/>QQ: 125004628 <br/><a href="mailto:baitao.jibt@gmail.com" class="light" target="_blank">baitao.jibt[at]gmail.com</a><br/><a
                    href="http://www.im47.cn" class="light" target="_blank">http://www.im47.cn</a></strong>
        </p>
    </div>
    <div class="row-fluid team">
        <p class="span6 thumbnail">
            <a class="fancybox-effects" href="${ctx}/static/images/headPic/dongpengfei-big.jpg" title="董鹏飞"><img
                    src="${ctx}/static/images/headPic/dongpengfei.jpg" width="120px" height="120px"/></a>
            <strong>董鹏飞 <br/>QQ: 826323891 <br/><a href="mailto:pengfei.dongpf@gmail.com" class="light" target="_blank">pengfei.dongpf[at]gmail.com</a></strong>
        </p>

        <p class="span6 thumbnail">
            <a class="fancybox-effects" href="${ctx}/static/images/headPic/dengxiaolan-big.jpg" title="邓小兰"><img
                    src="${ctx}/static/images/headPic/dengxiaolan.jpg" width="120px" height="120px"/></a>
            <strong>邓小兰 <br/>QQ: 824688439 <br/><a href="mailto:824688439@qq.com" class="light" target="_blank">824688439[at]qq.com</a></strong>
        </p>
    </div>
    <div class="row-fluid team">
        <p class="span6 thumbnail">
            <a class="fancybox-effects" href="${ctx}/static/images/headPic/hemeng-big.jpg" title="何梦"><img
                    src="${ctx}/static/images/headPic/hemeng.jpg" width="120px" height="120px"/></a>
            <strong>何梦 <br/>QQ: 345931525 <br/><a href="mailto:345931525@qq.com" class="light" target="_blank">345931525[at]qq.com</a></strong>
        </p>

        <p class="span6 thumbnail">
            <a class="fancybox-effects" href="${ctx}/static/images/headPic/songlirong-big.jpg" title="宋丽荣"><img
                    src="${ctx}/static/images/headPic/songlirong.png" width="120px" height="120px"/></a>
            <strong>宋丽荣 <br/>QQ: 1158633726 <br/><a href="mailto:1158633726@qq.com" class="light" target="_blank">1158633726[at]qq.com</a></strong>
        </p>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        // 激活导航栏
        $("#about-page").addClass("active");

        // fancyBox
        $(".fancybox-effects").fancybox({
            openEffect:'elastic',
            openSpeed:150,

            closeEffect:'elastic',
            closeSpeed:150,

            closeClick:true,

            helpers:{
                title:{
                    type:'inside'
                }
            }
        });
    });
</script>
</body>
</html>