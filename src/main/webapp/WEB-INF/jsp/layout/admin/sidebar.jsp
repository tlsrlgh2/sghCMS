<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<ul class="sidebar-nav" data-coreui="navigation" data-simplebar>
  <li class="nav-title">CMS</li>
  <li class="nav-item">
    <a class="nav-link" href="${ctx}/admin/dashboard.do">
      <svg class="nav-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" aria-hidden="true">
        <path fill="currentColor" d="M64 32h160v192H32V64a32 32 0 0 1 32-32Zm224 0h160a32 32 0 0 1 32 32v96H288ZM32 288h192v192H64a32 32 0 0 1-32-32Zm256-32h192v192a32 32 0 0 1-32 32H288Z"/>
      </svg>
      대시보드
    </a>
  </li>

  <c:forEach var="menu" items="${adminMenuTree}">
    <c:choose>
      <c:when test="${not empty menu.children}">
        <c:set var="groupActive" value="false"/>
        <c:forEach var="child" items="${menu.children}">
          <c:if test="${child.menuNo == currentAdminMenuNo}">
            <c:set var="groupActive" value="true"/>
          </c:if>
        </c:forEach>
        <li class="nav-group${groupActive ? ' show' : ''}">
          <a class="nav-link nav-group-toggle" href="#">
            <svg class="nav-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" aria-hidden="true">
              <path fill="currentColor" d="M64 96h144l32 40h208a32 32 0 0 1 32 32v248a32 32 0 0 1-32 32H64a32 32 0 0 1-32-32V128a32 32 0 0 1 32-32Z"/>
            </svg>
            <c:out value="${menu.menuName}"/>
          </a>
          <ul class="nav-group-items compact">
            <c:forEach var="child" items="${menu.children}">
              <li class="nav-item">
                <a class="nav-link${child.menuNo == currentAdminMenuNo ? ' active' : ''}"
                   href="${ctx}/admin/cms/open.do?menuNo=${child.menuNo}">
                  <span class="nav-icon"><span class="nav-icon-bullet"></span></span>
                  <c:out value="${child.menuName}"/>
                </a>
              </li>
            </c:forEach>
          </ul>
        </li>
      </c:when>
      <c:otherwise>
        <li class="nav-item">
          <a class="nav-link${menu.menuNo == currentAdminMenuNo ? ' active' : ''}"
             href="${ctx}/admin/cms/open.do?menuNo=${menu.menuNo}">
            <span class="nav-icon"><span class="nav-icon-bullet"></span></span>
            <c:out value="${menu.menuName}"/>
          </a>
        </li>
      </c:otherwise>
    </c:choose>
  </c:forEach>

  <c:if test="${empty adminMenuTree}">
    <li class="nav-title">설정 필요</li>
    <li class="nav-item px-3 py-2 small text-body-secondary">
      CMS 메뉴 DB 초기화 스크립트를 적용하세요.
    </li>
  </c:if>
</ul>
