<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head><title>대관 안내 - SGH 청년공간</title></head>
<body>
<nav class="user-subnav" aria-label="공간대관 하위 메뉴">
  <div class="container">
    <ul class="subnav-list">
      <li><a href="${ctx}/user/space/guide.do" class="active">대관 안내</a></li>
    </ul>
  </div>
</nav>
<section class="user-page-section">
  <div class="container">
    <div class="page-content-body">
      ${content.contentHtml}
    </div>
  </div>
</section>
</body>
</html>
