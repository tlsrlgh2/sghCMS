<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
  <title><sitemesh:write property="title"/></title>
  <link href="${ctx}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="${ctx}/bootstrap/icons/bootstrap-icons.min.css" rel="stylesheet">
  <link href="${ctx}/css/user/user.css" rel="stylesheet">
  <sitemesh:write property="head"/>
</head>
<body>
  <%@ include file="header.jsp" %>
  <main id="main-content">
    <sitemesh:write property="body"/>
  </main>
  <%@ include file="footer.jsp" %>
  <script src="${ctx}/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${ctx}/js/user/user.js"></script>
</body>
</html>
