<%--
  services
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-19
  Time: 下午1:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<head>
    <title>services</title>
</head>
<body>
<!-- BEGIN PAGE TITLE -->
<div id="page-title">
    <div class="title"><!-- your title page -->
        <h1>Services</h1>
    </div>
    <div class="desc"><!-- description about your page -->
        Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam nisi ut aliquid ex ea commodi consequatur, Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil.
    </div>
</div>
<!-- END OF PAGE TITLE -->

<!-- BEGIN CONTENT -->
<div id="content-inner">
    <div id="content-left">
        <div class="maincontent">
            <h2>What we offers ?</h2>
            <div class="service-item">
                <div class="services-icon"><img src="${ctx}/static/images/services1.jpg" alt="" /></div>
                <p><strong>Web Design</strong><br />
                    Ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga harum.
                </p>
            </div>
            <div class="spacer">&nbsp;</div>
            <div class="service-item">
                <div class="services-icon"><img src="${ctx}/static/images/services2.jpg" alt="" /></div>
                <p><strong>Branding &amp; Printing</strong><br />
                    Ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga harum.
                </p>
            </div>
            <div class="service-item">
                <div class="services-icon"><img src="${ctx}/static/images/services3.jpg" alt="" /></div>
                <p><strong>Network Security</strong><br />
                    Ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga harum.
                </p>
            </div>
            <div class="spacer">&nbsp;</div>
            <div class="service-item">
                <div class="services-icon"><img src="${ctx}/static/images/services4.jpg" alt="" /></div>
                <p><strong>Internet Marketing</strong><br />
                    Ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga harum.
                </p>
            </div>
            <div class="maincontent">
                <h4>Other Services</h4>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident.
                </p>
            </div>
        </div>
    </div>
    <div id="side-box">
        <div class="maincontent">
            <h2>Latest News</h2>
            <ul class="news-list">
                <li>
                    <strong>19 November 2009</strong><br />
                    Magni dolores eos qui ratione voluptatem sequi nesciunt neque porro quisquam est qui dolorem
                </li>
                <li class="second">
                    <strong>10 November 2009</strong><br />
                    Curabitur a tortor nulla, non luctus nibh in hac habitasse platea dictumst aliquid ex ea commodi
                </li>
                <li class="second">
                    <strong>8 November 2009</strong><br />
                    Similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga repellendus
                </li>
            </ul>
        </div>
        <div class="maincontent">
            <h2>Testimonials</h2>
            <blockquote>
                <p>Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis</p>
            </blockquote>
            <strong>John Doe - Business Analyst</strong>
        </div>
        <div class="maincontent">
            <br /><a href="#"><img src="${ctx}/static/images/brochure.gif" alt=""  /></a>
        </div>
    </div>
</div>
<!-- END OF CONTENT -->
</body>
</html>