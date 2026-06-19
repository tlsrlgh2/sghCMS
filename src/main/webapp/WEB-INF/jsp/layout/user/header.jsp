<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<header class="header sticky-top border-bottom">
  <div class="container-lg px-4 d-flex align-items-center">
    <a class="fw-bold text-decoration-none fs-5 me-auto" href="${ctx}/user/main.do">SGHCMS</a>
    <nav class="d-flex gap-3">
      <c:choose>
        <c:when test="${not empty sessionScope.loginVO}">
          <span class="align-self-center">${sessionScope.loginVO.userName}</span>
          <a class="btn btn-outline-secondary btn-sm" href="${ctx}/uat/uia/actionLogout.do">로그아웃</a>
        </c:when>
        <c:otherwise>
          <a class="btn btn-primary btn-sm" href="${ctx}/uat/uia/egovLoginUsr.do">로그인</a>
        </c:otherwise>
      </c:choose>
    </nav>
  </div>
</header>
