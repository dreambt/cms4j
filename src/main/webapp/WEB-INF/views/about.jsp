<%--
  关于我们
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-18
  Time: 上午10:55
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>关于我们</title>
</head>
<body>
<!-- BEGIN PAGE TITLE -->
<div id="page-title">
    <div class="title"><!-- your title page -->
        <h1>About Us</h1>
    </div>
    <div class="desc"><!-- description about your page -->
        Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem
        aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.
    </div>
</div>
<!-- END OF PAGE TITLE -->

<!-- BEGIN CONTENT -->
<div id="content-inner">
    <div id="content-left">
        <div class="maincontent">
            <h2>What we do ?</h2>

            <p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti
                atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident,
                similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum
                quidem rerum facilis est et expedita distinctio.</p>

            <h4>Our Mission</h4>

            <p><img src="${ctx}/static/images/content-pic1.jpg" alt="" class="imgleft"/>Soluta nobis est eligendi optio cumque nihil
                impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor
                repellendus. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit
                anim id est laborum. Adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore
                magnam aliquam quaerat voluptatem. Quod maxime placeat facere possimus, omnis voluptas assumenda est,
                omnis dolor repellendus.</p>
            <ul class="content-list">
                <li>Neque porro quisquam est, qui dolorem ipsum quia dolor sit ametcon.</li>
                <li>Exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid exea.</li>
                <li>Voluptate velit esse quam nihil molestiae consequatur velillum qui.</li>
                <li>Temporibus autem quibusdam et aut officiis debitis aut rerum necess.</li>
            </ul>
            <br/>
            <blockquote>
                <p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et
                    voluptates repudiandae sint et molestiae non recusandae.Itaque earum rerum hic tenetur a sapiente
                    delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus.</p>
            </blockquote>
            <br/>
            <h4>The Owner</h4>

            <p><img src="${ctx}/static/images/content-pic2.jpg" alt="" class="imgleft"/>
                <strong>Mr. Vero Amus</strong><br/>
                Dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas
                molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia
                deserunt mollitia animi, id est laborum et dolorum fuga.
            </p>
        </div>
    </div>
    <div id="side-box">
        <div class="maincontent">
            <h2>More about us</h2>

            <p>Quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodiquis autem
                vel eum iure reprehenderit consequatur.</p>
            <ul class="content-list">
                <li><a href="#">Vision &amp; Mission</a></li>
                <li><a href="#">What we do</a></li>
                <li><a href="#">Philosopy</a></li>
                <li><a href="#">Partnership</a></li>
            </ul>
        </div>
        <div class="maincontent">
            <h2>Latest News</h2>
            <ul class="news-list">
                <li>
                    <strong>19 November 2009</strong><br/>
                    Magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem
                </li>
                <li>
                    <strong>10 November 2009</strong><br/>
                    Curabitur a tortor nulla, non luctus nibh in hac habitasse platea dictumst aliquid ex ea commodi
                </li>
                <li>
                    <strong>8 November 2009</strong><br/>
                    Similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga
                    repellendus
                </li>
            </ul>
        </div>
    </div>
</div>
<!-- END OF CONTENT -->
</body>
</html>