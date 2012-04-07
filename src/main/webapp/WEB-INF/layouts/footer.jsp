<%--
  Footer模块
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-18
  Time: 下午5:09
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div id="fridendLink">
    <a class="t"><strong>友情链接：</strong></a>
    <marquee id="fri" scrollDelay="150" onmouseover="this.stop()" onmouseout="this.start()" loop='-1'>
        <a href="#">友情链接一</a>
        <a href="#">友情链接一</a>
        <a href="#">友情链接一</a>
        <a href="#">友情链接一</a>
        <a href="#">友情链接一</a>
        <a href="#">友情链接一</a>
        <a href="#">友情链接一</a>
    </marquee>
</div>
<!-- BEGIN FOOTER -->
<div id="footer">
    <div class="footer1">
        <p>地址：山东省 济南市 市中区 山东财经大学<br />
            电话: +62 1234 5678<br />
            邮箱: info@agivee.com<br />
            Copyright © 2012 CMS4j. All Rights Reserved<br />
        </p>
    </div>
    <div class="footer2">
        <ul id="social">
            <li id="fb-icon"><a href="${ctx}/about" ><span></span>关于我们</a></li>
            <li id="twit-icon"><a href="${ctx}/contact"><span></span>联系方式</a></li>
            <li id="flic-icon"><a href="#"><span></span>官方微博</a></li>
            <li id="rss-icon"><a href="#"><span></span>订阅</a></li>
        </ul>
    </div>
    <div class="footer3">
        <img src="${ctx}/static/images/twitter-footer.jpg" alt="" class="twitter" /><h3>服务宗旨</h3>
        <p>建设具有解决国内金融领域信息化重大问题的、综合研究能力强的、在国内外有较大影响的金融信息工程产学研机构。</p>
    </div>
</div>
<!-- END OF FOOTER -->