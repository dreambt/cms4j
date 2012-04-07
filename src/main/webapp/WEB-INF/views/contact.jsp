<%--
  Created by IntelliJ IDEA.
  User: User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-19
  Time: 下午1:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>联系我们</title>
    <style type='text/css' media='screen,projection'>
        <!--
        fieldset { border:0;margin:0;padding:0; }
        label {  padding-right:15px; float:left; width:70px; }
        input.text{ width:290px;font:12px/12px 'courier new',courier,monospace;color:#333;padding:3px;margin:1px 0; }
        -->
    </style>
    <script type="text/javascript" src="${ctx}/static/js/functionAddEvent.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/contact.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/xmlHttp.js"></script>
</head>
<body>
            <!-- BEGIN PAGE TITLE -->
            <div id="page-title">
                <div class="title"><!-- your title page -->
                    <h1 class="cufon">联系我们</h1>
                </div>
                <div class="desc"><!-- description about your page -->
                    您的回复是对我们最大的支持, 欢迎社会各界与我们合作交流.
                </div>
            </div>
            <!-- END OF PAGE TITLE -->

            <!-- BEGIN CONTENT -->
            <div id="content-inner">
                <div id="content-map">
                    <div class="maincontent">
                        <h2 class="cufon">我们希望听到您的声音</h2>
                        <p id="loadBar" style="display:none;">
                            <strong>邮件发送中. 可能需要花费一些时间&#8230;</strong><br />
                            <img src="${ctx}/static/images/loading.gif" alt="Loading..." title="Sending Email" />
                        </p>
                        <p id="emailSuccess" style="display:none;">
                            <strong style="color:red;">邮件发送成功!</strong>
                        </p>
                        <p>
                            Shungeng Road No.40, Jinan , Shandong, China<br />
                            Phone: +86 1234 5678<br />
                            Email: jrgczx@gmail.com
                        </p>
                        <h2 class="cufon">给我们发送邮件</h2>
                        <div id="contactFormArea">
                            <form action="scripts/contact.php" method="post" id="cForm">
                                <fieldset>
                                    <div class="form-row">
                                        <div class="label">姓名</div>
                                        <div class="input-container"><input class="input" type="text" size="25" name="posName" id="posName" /></div>
                                    </div><!--END name //-->

                                    <div class="form-row">
                                        <div class="label">Email</div>
                                        <div class="input-container"><input class="input" type="text" size="25" name="posEmail" id="posEmail" /></div>
                                    </div><!--END email //-->

                                    <div class="form-row">
                                        <div class="label">主题</div>
                                        <div class="input-container-last"><input class="input" type="text" size="25" name="posRegard" id="posRegard" /></div>
                                    </div><!--END subject //-->

                                    <div class="form-row-textarea">
                                        <div class="label">内容</div>
                                        <div class="input-container"><textarea cols="50" rows="4" name="posText" id="posText" class="textarea"></textarea>
                                        </div>
                                        <label for="selfCC">
                                            <!--<input type="checkbox" name="selfCC" id="selfCC" value="send" /> Send CC to self-->
                                            <input type="hidden" name="selfCC" id="selfCC" value="xxx" />
                                        </label>
                                    </div><!--END textarea //-->
                                    <input class="input-submit" type="submit" name="sendContactEmail" id="sendContactEmail" value=" 发 送 " />
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>
                <div id="side-map">
                    <div class="maincontent">
                        <h2 class="cufon">地理位置</h2>
                        <div class="google-map"><p><img src="${ctx}/static/images/big-map.png" alt=""  /></p></div>
                    </div>
                </div>
            </div>
            <!-- END OF CONTENT -->
            <div id="fridendLink">
                <a class="t"><strong>友情链接：</strong></a>
                <marquee>
                <a href="#">友情链接一</a>
                <a href="#">友情链接一</a>
                <a href="#">友情链接一</a>
                <a href="#">友情链接一</a>
                <a href="#">友情链接一</a>
                <a href="#">友情链接一</a>
                <a href="#">友情链接一</a>
                </marquee>
            </div>
</body>
</html>