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

    <div id="scroll_div">
        <c:forEach items="${links}" var="link" begin="0" step="1">
        <div id="scroll_begin" style="display: inline;">

                <a href="${link.url}">${link.title}</a>

        </div>
        <div id="scroll_end" style="display: inline;"></div>
        </c:forEach>
    </div>
</div>
<!-- BEGIN FOOTER -->
<div id="footer">
    <div class="footer1">
        <p>地址：山东省 济南市 市中区 山东财经大学<br/>
            电话: +62 1234 5678<br/>
            邮箱: info@agivee.com<br/>
            Copyright © 2012 CMS4j. All Rights Reserved<br/>
        </p>
    </div>
    <div class="footer2">
        <ul id="social">
            <li id="fb-icon"><a href="${ctx}/about"><span></span>关于我们</a></li>
            <li id="twit-icon"><a href="${ctx}/contact"><span></span>联系方式</a></li>
            <li id="flic-icon"><a href="#"><span></span>官方微博</a></li>
            <li id="rss-icon"><a href="#"><span></span>订阅</a></li>
        </ul>
    </div>
    <div class="footer3">
        <img src="${ctx}/static/images/twitter-footer.jpg" alt="" class="twitter"/>

        <h3>服务宗旨</h3>

        <p>建设具有解决国内金融领域信息化重大问题的、综合研究能力强的、在国内外有较大影响的金融信息工程产学研机构。</p>
    </div>
</div>
<!-- END OF FOOTER -->
<script>
    var speed=40;
    var scroll_end =document.getElementById("scroll_end");
    var scroll_div = document.getElementById("scroll_div");
    scroll_end.innerHTML=scroll_begin.innerHTML;
    function Marquee(){
        if(scroll_end.offsetWidth-scroll_div.scrollLeft<=0)
            scroll_div.scrollLeft-=scroll_begin.offsetWidth;
        else{
            scroll_div.scrollLeft++;
        }
    }
    var MyMar=setInterval(Marquee,speed);
    scroll_div.onmouseover=function() {clearInterval(MyMar);}
    scroll_div.onmouseout=function() {MyMar=setInterval(Marquee,speed);}
</script>