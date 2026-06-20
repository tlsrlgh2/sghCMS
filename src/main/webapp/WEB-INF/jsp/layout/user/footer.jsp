<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<footer class="user-footer">
  <div class="footer-top">
    <div class="container">
      <div class="row g-4 g-lg-5">
        <div class="col-lg-4">
          <a href="${ctx}/" class="footer-brand">
            <span class="logo-symbol" aria-hidden="true">
              <span></span><span></span><span></span>
            </span>
            <strong>SGH 청년공간</strong>
          </a>
          <p class="footer-summary">
            청년이 편하게 머물고 새로운 가능성을 발견할 수 있도록
            공간, 프로그램, 정책 정보를 연결합니다.
          </p>
        </div>

        <div class="col-6 col-md-3 col-lg-2">
          <h2 class="footer-heading">청년공간</h2>
          <ul class="footer-links">
            <li><a href="${ctx}/user/about/intro.do">공간 소개</a></li>
            <li><a href="${ctx}/user/about/facility.do">시설 안내</a></li>
            <li><a href="${ctx}/user/space/guide.do">대관 안내</a></li>
            <li><a href="${ctx}/user/about/location.do">오시는 길</a></li>
          </ul>
        </div>

        <div class="col-6 col-md-3 col-lg-2">
          <h2 class="footer-heading">이용안내</h2>
          <ul class="footer-links">
            <li><a href="${ctx}/user/program/list.do">프로그램</a></li>
            <li><a href="${ctx}/user/notice/list.do">공지사항</a></li>
            <li><a href="${ctx}/user/support/policy.do">청년정책</a></li>
            <li><a href="${ctx}/user/support/counsel.do">청년상담</a></li>
          </ul>
        </div>

        <div class="col-md-6 col-lg-2">
          <h2 class="footer-heading">문의</h2>
          <address class="footer-contact">
            <strong>02-0000-0000</strong>
            <p>평일 09:00 - 18:00</p>
            <p>서울특별시 OO구 청년로 123</p>
            <p>hello@sghyouth.or.kr</p>
          </address>
        </div>

        <div class="col-lg-2">
          <h2 class="footer-heading">관련 사이트</h2>
          <select class="form-select footer-select" aria-label="관련 사이트"
                  onchange="if(this.value){window.open(this.value, '_blank', 'noopener'); this.selectedIndex=0;}">
            <option value="">관련 사이트 선택</option>
            <option value="https://www.gov.kr">정부24</option>
            <option value="https://www.youthcenter.go.kr">온통청년</option>
            <option value="https://www.mois.go.kr">행정안전부</option>
          </select>
        </div>
      </div>
    </div>
  </div>

  <div class="footer-bottom">
    <div class="container d-flex justify-content-between align-items-center gap-3">
      <div class="footer-policy">
        <a href="${ctx}/user/policy/privacy.do">개인정보처리방침</a>
        <a href="${ctx}/user/policy/email.do">이메일무단수집거부</a>
        <a href="${ctx}/user/sitemap.do">사이트맵</a>
      </div>
      <p class="footer-copyright">Copyright &copy; 2026 SGH YOUTH SPACE. All rights reserved.</p>
    </div>
  </div>
</footer>
