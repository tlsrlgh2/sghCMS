<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<ul class="sidebar-nav" data-coreui="navigation" data-simplebar>
  <li class="nav-title">메인</li>
  <li class="nav-item">
    <a class="nav-link" href="${ctx}/admin/dashboard.do">
      <svg class="nav-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
        <path fill="var(--ci-primary-color, currentcolor)" d="M425.706 142.294A240 240 0 0 0 16 312v88h144v-32H48v-56c0-114.691 93.309-208 208-208s208 93.309 208 208v56H352v32h144v-88a238.43 238.43 0 0 0-70.294-169.706" class="ci-primary"/>
      </svg>
      대시보드
    </a>
  </li>

  <li class="nav-title">관리</li>
  <li class="nav-group">
    <a class="nav-link nav-group-toggle" href="#">
      <svg class="nav-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
        <path fill="var(--ci-primary-color, currentcolor)" d="M256 48a208 208 0 1 1 0 416A208 208 0 0 1 256 48m0-32C114.6 16 16 114.6 16 256s98.6 240 240 240 240-98.6 240-240S397.4 16 256 16m-16 320h32V240h-32zm0-128h32v-48h-32z" class="ci-primary"/>
      </svg>
      사용자 관리
    </a>
    <ul class="nav-group-items compact">
      <li class="nav-item">
        <a class="nav-link" href="${ctx}/admin/user/list.do">
          <span class="nav-icon"><span class="nav-icon-bullet"></span></span>
          사용자 목록
        </a>
      </li>
    </ul>
  </li>
</ul>
