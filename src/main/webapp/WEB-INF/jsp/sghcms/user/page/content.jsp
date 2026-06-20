<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title><c:out value="${content.pageTitle}"/> - SGH 청년공간</title>
</head>
<body>
<section class="user-page-section">
  <div class="container">
    <header class="user-page-heading">
      <h1><c:out value="${content.pageTitle}"/></h1>
    </header>
    <div class="page-content-body">
      <%-- 본문 HTML은 저장 시 OWASP 새니타이저로 정제됨 (PageContentServiceImpl) --%>
      ${content.contentHtml}
    </div>
  </div>
</section>
</body>
</html>
