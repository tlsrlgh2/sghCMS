<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<header class="header sticky-top">
  <div class="container-fluid px-4">
    <button class="header-toggler d-lg-none" type="button"
      onclick="coreui.Sidebar.getInstance(document.querySelector('#sidebar')).toggle()">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="icon icon-lg" role="img" aria-hidden="true">
        <path fill="var(--ci-primary-color, currentcolor)" d="M64 384h384v-42.666H64zm0-106.666h384v-42.667H64zM64 128v42.665h384V128z" class="ci-primary"/>
      </svg>
    </button>
    <a class="header-brand d-lg-none" href="${ctx}/admin/dashboard.do">
      <span class="fw-bold">SGHCMS</span>
    </a>
    <div class="header-nav ms-auto">
      <div class="nav-item dropdown">
        <a class="nav-link" data-coreui-toggle="dropdown" href="#" role="button">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="icon icon-lg" role="img" aria-hidden="true">
            <path fill="var(--ci-primary-color, currentcolor)" d="M256 288a128 128 0 1 0-128-128 128.14 128.14 0 0 0 128 128Zm0-224a96 96 0 1 1-96 96 96.11 96.11 0 0 1 96-96ZM256 320c-88.37 0-160 57.31-160 128v16h32v-16c0-52.94 57.41-96 128-96s128 43.06 128 96v16h32v-16c0-70.69-71.63-128-160-128Z" class="ci-primary"/>
          </svg>
          <span class="ms-1">${sessionScope.loginVO.userName}</span>
        </a>
        <div class="dropdown-menu dropdown-menu-end">
          <a class="dropdown-item" href="${ctx}/uat/uia/actionLogout.do">로그아웃</a>
        </div>
      </div>
    </div>
  </div>
</header>
