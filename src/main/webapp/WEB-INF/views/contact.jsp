<%--
  联系我们页面
  User: baitao.jibt@gmail.com
  Date: 12-8-25
  Time: 下午14:32
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>联系我们</title>
</head>
<body>
<!-- 联系我们 -->
<div class="row">
    <div class="span12">
        <ul class="breadcrumb">
            <li><a href="${ctx}/">首页</a> <span class="divider">/</span></li>
            <li>联系我们</li>
        </ul>
    </div>
</div>
<div class="row">
    <!-- 正文 -->
    <div class="span7">
        <h2>我们希望听到您的声音</h2>
        <p>您的回复是对我们最大的支持, 欢迎社会各界与我们合作交流.</p>
        <h3>给我们发送邮件</h3>
        <form action="scripts/contact.php" method="post" id="cForm" class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="posName">姓名</label>
                <div class="controls">
                    <input type="text" id="posName" name="posName" placeholder="Username">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="posEmail">Email</label>
                <div class="controls">
                    <input type="text" id="posEmail" name="posEmail" placeholder="Email">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="posRegard">主题</label>
                <div class="controls">
                    <input type="text" class="input-xlarge" id="posRegard" name="posRegard" placeholder="山东省金融信息工程技术研究中心合作洽谈">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="posEmail">内容</label>
                <div class="controls">
                    <textarea class="input-xlarge" rows="4" id="posText" name="posText"></textarea>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <input type="hidden" id="selfCC" name="selfCC" value="dreambt@126.com">
                    <button type="submit" class="btn btn-primary">发 送</button>
                </div>
            </div>
        </form>
    </div>
    <div class="span6">
        <div class="thumbnail">
            <img src="${ctx}/static/images/big-map.png" alt=""  />
            <div class="caption">
                <h3>地理位置</h3>
                <p>No.40, Shungeng Road, Jinan, Shandong, China<br />
                   Phone: +86 1234 5678<br />
                   Email: jrgczx@gmail.com</p>
            </div>
        </div>
    </div>
</div>
<div id="loadBar" class="alert alert-info" style="display:none;z-index:999;position:fixed;top:300px;left:50%;margin: 0 0 0 -125px;">
    <p><strong>邮件发送中...可能需要花费一些时间</strong><br /><img src="${ctx}/static/images/loading.gif" alt="Loading..." title="Sending Email" /></p>
</div>
<div id="emailSuccess" class="alert alert-info" style="display:none;z-index:999;position:fixed;top:300px;left:50%;margin: 0 0 0 -125px;">
    <p><strong style="color:red;">邮件发送成功!</strong></p>
</div>
<script type="text/javascript" src="${ctx}/min?t=js&f=/js/functionAddEvent.js,/js/contact.js,/js/xmlHttp.js"></script>
</body>
</html>