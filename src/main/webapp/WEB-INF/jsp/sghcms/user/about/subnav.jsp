<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<nav class="user-subnav" aria-label="청년공간 하위 메뉴">
  <div class="container">
    <ul class="subnav-list">
      <li><a href="${ctx}/user/about/intro.do"     class="${currentPageKey == 'intro'    ? 'active' : ''}">공간 소개</a></li>
      <li><a href="${ctx}/user/about/facility.do"  class="${currentPageKey == 'facility' ? 'active' : ''}">시설 안내</a></li>
      <li><a href="${ctx}/user/about/org.do"       class="${currentPageKey == 'org'      ? 'active' : ''}">운영 조직</a></li>
      <li><a href="${ctx}/user/about/location.do"  class="${currentPageKey == 'location' ? 'active' : ''}">오시는 길</a></li>
    </ul>
  </div>
</nav>
