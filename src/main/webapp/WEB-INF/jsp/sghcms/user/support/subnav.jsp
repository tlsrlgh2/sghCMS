<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<nav class="user-subnav" aria-label="청년지원 하위 메뉴">
  <div class="container">
    <ul class="subnav-list">
      <li><a href="${ctx}/user/support/policy.do"  class="${currentPageKey == 'policy'  ? 'active' : ''}">청년정책</a></li>
      <li><a href="${ctx}/user/support/job.do"     class="${currentPageKey == 'job'     ? 'active' : ''}">일자리 정보</a></li>
      <li><a href="${ctx}/user/support/counsel.do" class="${currentPageKey == 'counsel' ? 'active' : ''}">청년 상담</a></li>
    </ul>
  </div>
</nav>
