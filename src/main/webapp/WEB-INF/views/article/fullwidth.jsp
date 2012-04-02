<%--
  文章正文
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-18
  Time: 上午10:55
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>文章正文</title>

    <!-- ////////////////////////////////// -->
    <!-- //      Javascript Files        // -->
    <!-- ////////////////////////////////// -->
    <script type="text/javascript" src="${ctx}/static/js/superfish.js"></script>
    <script type="text/javascript">
        // initialise plugins
        jQuery(function(){
            jQuery('ul.sf-menu').superfish();
        });
    </script>

    <script type="${ctx}/static/text/javascript" src="js/cufon-yui.js"></script>
    <script type="${ctx}/static/text/javascript" src="js/MankSans-Medium_500.font.js"></script>
    <script type="text/javascript">
        Cufon.replace('h1') ('h2') ('h3') ('.phone') ('.pf-title');
    </script>
</head>
<body>
<!-- BEGIN PAGE TITLE -->
<div id="page-title">
    <div class="title"><!-- your title page -->
        <h1>content</h1>
    </div>
    <div class="desc"><!-- description about your page -->
        Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates
        repudiandae sint et molestiae non recusandae, itaque earum rerum hic tenetur a sapiente delectus.
    </div>
</div>
<!-- END OF PAGE TITLE -->

<!-- BEGIN CONTENT -->
<div id="content-inner-full">
    <div class="maincontent">
        <h2>Get the success now..!!</h2>

        <p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti
            atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique
            sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum
            facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil
            impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor
            repellendus.</p>
        <h4>Sample right image</h4>

        <p><img src="${ctx}/static/images/blog-pic2.jpg" alt="" class="imgright"/>At vero eos et accusamus et iusto odio
            dignissimos
            ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias
            excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia
            animi, id est laborum et dolorum fuga. <a href="#">Sample link on content</a> est et expedita distinctio.
            Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime
            placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Nam libero tempore, cum
            soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis
            voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut
            rerum necessitatibus <a href="#">saepe eveniet ut et voluptates</a> repudiandae sint et molestiae non
            recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias
            consequatur aut perferendis doloribus asperiores repellat.</p>
        <blockquote>
            <p>Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et
                voluptates repudiandae sint et molestiae non recusandae.Itaque earum rerum hic tenetur a sapiente
                delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus. Ut enim ad
                minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea
                commodi consequatur. Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil
                molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur
            </p>
        </blockquote>
        <br/>
        <ul class="content-list">
            <li>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam
                rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt
                explicabo.
            </li>
            <li>Voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui
                ratione voluptatem sequi nesciunt.
            </li>
            <li>Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur,
                vel illum qui dolorem eum fugiat quo voluptas nulla pariatur
            </li>
            <li>Temporibus autem quibusdam et aut officiis debitis aut rerum necess.</li>
        </ul>
        <h4>Sample left image</h4>

        <p><img src="${ctx}/static/images/blog-pic1.jpg" alt="" class="imgleft"/>At vero eos et accusamus et iusto odio
            dignissimos
            ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias
            excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia
            animi, id est laborum et dolorum fuga. <a href="#">Sample link on content</a> est et expedita distinctio.
            Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime
            placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Nam libero tempore, cum
            soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis
            voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut
            rerum necessitatibus <a href="#">saepe eveniet ut et voluptates</a> repudiandae sint et molestiae non
            recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias
            consequatur aut perferendis doloribus asperiores repellat.</p>
    </div>
</div>
<!-- END OF CONTENT -->
</body>
</html>