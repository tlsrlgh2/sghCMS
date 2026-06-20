<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<a class="skip-link" href="#main-content">본문 바로가기</a>

<div class="user-util-bar">
  <div class="container d-flex justify-content-end align-items-center gap-3">
    <c:choose>
      <c:when test="${not empty sessionScope.loginVO}">
        <span class="util-welcome">${sessionScope.loginVO.userName}님</span>
        <a href="${ctx}/uat/uia/actionLogout.do">로그아웃</a>
        <a href="${ctx}/user/mypage.do">마이페이지</a>
      </c:when>
      <c:otherwise>
        <a href="${ctx}/uat/uia/egovLoginUsr.do">로그인</a>
        <a href="${ctx}/user/join.do">회원가입</a>
      </c:otherwise>
    </c:choose>
    <a href="${ctx}/user/sitemap.do">사이트맵</a>
  </div>
</div>

<header class="user-header">
  <nav class="navbar navbar-expand-xl" aria-label="주요 메뉴">
    <div class="container">
      <a href="${ctx}/" class="navbar-brand user-logo">
        <span class="logo-symbol" aria-hidden="true">
          <span></span><span></span><span></span>
        </span>
        <span class="logo-copy">
          <strong>SGH 청년공간</strong>
          <small>YOUTH COMMUNITY SPACE</small>
        </span>
      </a>

      <button class="navbar-toggler user-nav-toggler" type="button"
              data-bs-toggle="collapse" data-bs-target="#userMainNav"
              aria-controls="userMainNav" aria-expanded="false" aria-label="메뉴 열기">
        <i class="bi bi-list"></i>
      </button>

      <div class="collapse navbar-collapse" id="userMainNav">
        <c:choose>
          <%-- DB 기반 사용자 메뉴(관리자 사용자 메뉴관리에서 등록)가 있으면 우선 사용 --%>
          <c:when test="${not empty userMenuTree}">
            <ul class="navbar-nav user-menu-list mx-xl-auto">
              <c:forEach var="top" items="${userMenuTree}">
                <c:set var="topHref">
                  <c:choose>
                    <c:when test="${not empty top.urlPath}">${ctx}/user/page/${top.urlPath}.do</c:when>
                    <c:otherwise>#</c:otherwise>
                  </c:choose>
                </c:set>
                <c:choose>
                  <c:when test="${not empty top.children}">
                    <li class="nav-item dropdown">
                      <a class="nav-link dropdown-toggle" href="${fn:trim(topHref)}"
                         role="button" data-bs-toggle="dropdown" aria-expanded="false"><c:out value="${top.menuNm}"/></a>
                      <ul class="dropdown-menu">
                        <c:forEach var="child" items="${top.children}">
                          <li>
                            <a class="dropdown-item"
                               href="<c:choose><c:when test='${not empty child.urlPath}'>${ctx}/user/page/${child.urlPath}.do</c:when><c:otherwise>#</c:otherwise></c:choose>">
                              <c:out value="${child.menuNm}"/>
                            </a>
                          </li>
                        </c:forEach>
                      </ul>
                    </li>
                  </c:when>
                  <c:otherwise>
                    <li class="nav-item">
                      <a class="nav-link" href="${fn:trim(topHref)}"><c:out value="${top.menuNm}"/></a>
                    </li>
                  </c:otherwise>
                </c:choose>
              </c:forEach>
            </ul>
          </c:when>
          <%-- 등록된 사용자 메뉴가 없으면 기존 정적 메뉴로 폴백 --%>
          <c:otherwise>
        <ul class="navbar-nav user-menu-list mx-xl-auto">
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="${ctx}/user/about/intro.do"
               role="button" data-bs-toggle="dropdown" aria-expanded="false">청년공간</a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="${ctx}/user/about/intro.do">공간 소개</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/about/facility.do">시설 안내</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/about/org.do">운영 조직</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/about/location.do">오시는 길</a></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="${ctx}/user/notice/list.do"
               role="button" data-bs-toggle="dropdown" aria-expanded="false">알림소식</a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="${ctx}/user/notice/list.do">공지사항</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/news/list.do">센터 소식</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/press/list.do">언론보도</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/gallery/list.do">활동 갤러리</a></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="${ctx}/user/space/list.do"
               role="button" data-bs-toggle="dropdown" aria-expanded="false">공간대관</a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="${ctx}/user/space/list.do">공간 둘러보기</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/space/guide.do">대관 안내</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/space/calendar.do">대관 현황</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/space/apply.do">대관 신청</a></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="${ctx}/user/program/list.do"
               role="button" data-bs-toggle="dropdown" aria-expanded="false">프로그램</a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="${ctx}/user/program/list.do">전체 프로그램</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/program/list.do?type=center">센터 프로그램</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/program/list.do?type=outside">외부 프로그램</a></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="${ctx}/user/support/policy.do"
               role="button" data-bs-toggle="dropdown" aria-expanded="false">청년지원</a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="${ctx}/user/support/policy.do">청년정책</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/support/job.do">일자리 정보</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/support/counsel.do">청년 상담</a></li>
              <li><a class="dropdown-item" href="${ctx}/user/data/list.do">자료실</a></li>
            </ul>
          </li>
        </ul>
          </c:otherwise>
        </c:choose>

        <div class="header-actions">
          <button class="header-icon-btn" type="button" data-bs-toggle="collapse"
                  data-bs-target="#headerSearch" aria-controls="headerSearch"
                  aria-expanded="false" aria-label="검색 열기">
            <i class="bi bi-search"></i>
          </button>
          <a class="header-membership" href="${ctx}/user/join.do">멤버십 가입</a>
        </div>
      </div>
    </div>
  </nav>

  <div class="collapse header-search-panel" id="headerSearch">
    <div class="container">
      <form class="header-search-form" action="${ctx}/user/search.do" method="get">
        <label class="visually-hidden" for="headerKeyword">검색어</label>
        <input id="headerKeyword" type="search" name="keyword" class="form-control"
               placeholder="찾고 싶은 프로그램이나 정책을 검색해 보세요">
        <button type="submit" aria-label="검색"><i class="bi bi-search"></i></button>
      </form>
    </div>
  </div>
</header>
