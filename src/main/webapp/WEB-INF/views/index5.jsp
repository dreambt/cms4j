<%--
  Created by IntelliJ IDEA.
  User: sdcy
  Date: 12-4-18
  Time: 下午4:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <link href="${ctx}/static/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${ctx}/static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
  <div class="row-fluid show-grid">
      <div class="span3">a1</div>
      <div class="span3">a2</div>
  </div>
</body>
</html>