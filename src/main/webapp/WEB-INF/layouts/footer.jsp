<%--
  Footer模块
  User: baitao.jibt@gmail.com
  Date: 12-8-24
  Time: 下午14:08
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<!-- 友情链接 -->
<div class="row">
    <span class="span13">
        <ul id="friLnk" class="unstyled">
            <li class="friLnkT"><strong>友情链接</strong></li>
            <c:forEach items="${links}" var="link" begin="0" step="1">
                <li style="display:inline-block;*display:inline"><a href="${link.url}" target="_blank">${link.title}</a></li>
            </c:forEach>
        </ul>
    </span>
</div>
<!-- 页脚 -->
<footer class="footer">
        <p class="pull-right"><a href="#">回到页首</a></p>
        <p>地址: 山东省济南市市中区舜耕路40号山东财经大学&nbsp;|&nbsp; 电话: 0531-82917318   &nbsp;|&nbsp; 开发维护: <a href="mailto:baitao.jibt@gmail.com">baitao.jibt[at]gmail.com</a></p>
        <p>Copyright © 2012 <a href="http://dreambt.github.com/cms4j" target="_blank">cms4j</a>. All Rights Reserved.</p>
</footer>
<script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-1106337-7']);
    _gaq.push(['_trackPageview']);
    (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();
</script>