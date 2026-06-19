<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
  <title><sitemesh:write property="title"/> | SGHCMS</title>
  <link rel="stylesheet" href="${ctx}/coreui/vendors/simplebar/css/simplebar.css">
  <link rel="stylesheet" href="${ctx}/coreui/css/style.css">
  <script src="${ctx}/coreui/js/config.js"></script>
  <sitemesh:write property="head"/>
</head>
<body>
  <%@ include file="header.jsp" %>
  <div class="container-lg px-4 py-4 min-vh-100">
    <sitemesh:write property="body"/>
  </div>
  <%@ include file="footer.jsp" %>
  <script src="${ctx}/coreui/vendors/@coreui/coreui/js/coreui.bundle.min.js"></script>
</body>
</html>
