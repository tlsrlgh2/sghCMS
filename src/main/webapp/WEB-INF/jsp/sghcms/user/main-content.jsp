<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<c:if test="${not empty mainPopups}">
  <div class="youth-popup-layer" id="youthPopupLayer" aria-live="polite" hidden>
    <div class="youth-popup-backdrop" data-popup-close></div>
    <c:forEach var="popup" items="${mainPopups}">
      <section class="youth-popup-card" role="dialog" aria-modal="true"
               aria-labelledby="popup-title-${popup.popupId}"
               data-popup-id="${popup.popupId}"
               data-popup-url="<c:out value='${popup.fileUrl}'/>"
               hidden>
        <div class="youth-popup-heading">
          <div>
            <span>SGH YOUTH NEWS</span>
            <h2 id="popup-title-${popup.popupId}"><c:out value="${popup.popupTitleNm}"/></h2>
          </div>
          <button type="button" class="youth-popup-close" data-popup-close aria-label="팝업 닫기">
            <i class="bi bi-x-lg"></i>
          </button>
        </div>
        <button type="button" class="youth-popup-visual" data-popup-link
                aria-label="<c:out value='${popup.popupTitleNm}'/> 자세히 보기">
          <img src="${ctx}/user/popup/image.do?popupId=${popup.popupId}"
               alt="<c:out value='${popup.popupTitleNm}'/>">
        </button>
        <div class="youth-popup-footer">
          <c:if test="${popup.stopvewSetupAt eq 'Y'}">
            <label>
              <input type="checkbox" data-popup-hide-today>
              <span>오늘 하루 보지 않기</span>
            </label>
          </c:if>
          <button type="button" data-popup-close>닫기</button>
        </div>
      </section>
    </c:forEach>
  </div>
</c:if>

<section class="main-visual" aria-label="주요 소식">
  <div id="mainVisualCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel">
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#mainVisualCarousel" data-bs-slide-to="0"
              class="active" aria-current="true" aria-label="첫 번째 배너"></button>
      <button type="button" data-bs-target="#mainVisualCarousel" data-bs-slide-to="1"
              aria-label="두 번째 배너"></button>
      <button type="button" data-bs-target="#mainVisualCarousel" data-bs-slide-to="2"
              aria-label="세 번째 배너"></button>
    </div>

    <div class="carousel-inner">
      <div class="carousel-item active">
        <div class="visual-slide visual-slide-purple">
          <div class="container">
            <div class="row align-items-center min-vh-visual">
              <div class="col-lg-6 visual-copy">
                <p class="visual-kicker"><span>YOUTH SPACE</span> 청년의 오늘을 응원합니다</p>
                <h1>상상하고, 만나고,<br><em>함께 성장하는 공간</em></h1>
                <p class="visual-description">
                  새로운 일과 관계, 즐거운 경험이 필요한 청년이라면<br class="d-none d-md-block">
                  누구나 편하게 머물 수 있는 열린 커뮤니티입니다.
                </p>
                <div class="visual-buttons">
                  <a href="${ctx}/user/about/intro.do" class="btn visual-primary-btn">
                    공간 둘러보기 <i class="bi bi-arrow-right"></i>
                  </a>
                  <a href="${ctx}/user/program/list.do" class="btn visual-link-btn">
                    프로그램 보기
                  </a>
                </div>
              </div>
              <div class="col-lg-6 d-none d-lg-block">
                <div class="visual-art visual-art-community" aria-hidden="true">
                  <div class="art-orbit orbit-one"></div>
                  <div class="art-orbit orbit-two"></div>
                  <div class="art-card art-card-chat">
                    <i class="bi bi-chat-heart-fill"></i>
                    <span>Connect</span>
                  </div>
                  <div class="art-card art-card-idea">
                    <i class="bi bi-lightbulb-fill"></i>
                    <span>Imagine</span>
                  </div>
                  <div class="art-person person-one"><i class="bi bi-person-raised-hand"></i></div>
                  <div class="art-person person-two"><i class="bi bi-person-hearts"></i></div>
                  <div class="art-star star-one">✦</div>
                  <div class="art-star star-two">✦</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="carousel-item">
        <div class="visual-slide visual-slide-mint">
          <div class="container">
            <div class="row align-items-center min-vh-visual">
              <div class="col-lg-6 visual-copy">
                <p class="visual-kicker"><span>SPACE RENTAL</span> 우리만의 모임을 시작하세요</p>
                <h2>회의부터 촬영까지<br><em>목적에 맞는 공간 대관</em></h2>
                <p class="visual-description">
                  다목적홀, 회의실, 미디어실을 간편하게 확인하고<br class="d-none d-md-block">
                  온라인에서 바로 예약할 수 있습니다.
                </p>
                <div class="visual-buttons">
                  <a href="${ctx}/user/space/apply.do" class="btn visual-primary-btn">
                    대관 신청하기 <i class="bi bi-arrow-right"></i>
                  </a>
                  <a href="${ctx}/user/space/calendar.do" class="btn visual-link-btn">
                    예약 현황
                  </a>
                </div>
              </div>
              <div class="col-lg-6 d-none d-lg-block">
                <div class="visual-art visual-art-space" aria-hidden="true">
                  <div class="space-window"><span></span><span></span><span></span></div>
                  <div class="space-table"></div>
                  <div class="space-chair chair-one"></div>
                  <div class="space-chair chair-two"></div>
                  <div class="space-plant"><i class="bi bi-flower1"></i></div>
                  <div class="space-label"><i class="bi bi-calendar2-check"></i> 오늘도 이용 가능</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="carousel-item">
        <div class="visual-slide visual-slide-coral">
          <div class="container">
            <div class="row align-items-center min-vh-visual">
              <div class="col-lg-6 visual-copy">
                <p class="visual-kicker"><span>YOUTH PROGRAM</span> 6월 참여자 모집</p>
                <h2>배우고 도전하는<br><em>새로운 청년 프로그램</em></h2>
                <p class="visual-description">
                  진로, 문화, 생활, 네트워킹까지 지금 필요한 주제를<br class="d-none d-md-block">
                  골라 나만의 가능성을 넓혀보세요.
                </p>
                <div class="visual-buttons">
                  <a href="${ctx}/user/program/list.do" class="btn visual-primary-btn">
                    모집 프로그램 <i class="bi bi-arrow-right"></i>
                  </a>
                  <a href="${ctx}/user/support/counsel.do" class="btn visual-link-btn">
                    청년 상담
                  </a>
                </div>
              </div>
              <div class="col-lg-6 d-none d-lg-block">
                <div class="visual-art visual-art-program" aria-hidden="true">
                  <div class="program-poster poster-back">
                    <i class="bi bi-stars"></i>
                    <span>NEW<br>CLASS</span>
                  </div>
                  <div class="program-poster poster-front">
                    <small>2026. 06</small>
                    <strong>MAKE<br>YOUR<br>WAY</strong>
                    <i class="bi bi-arrow-up-right-circle-fill"></i>
                  </div>
                  <div class="program-dot dot-one"></div>
                  <div class="program-dot dot-two"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="visual-controls">
      <button type="button" data-bs-target="#mainVisualCarousel" data-bs-slide="prev" aria-label="이전 배너">
        <i class="bi bi-arrow-left"></i>
      </button>
      <span><strong>01</strong> / 03</span>
      <button type="button" data-bs-target="#mainVisualCarousel" data-bs-slide="next" aria-label="다음 배너">
        <i class="bi bi-arrow-right"></i>
      </button>
    </div>
  </div>
</section>

<section class="quick-service-wrap" aria-label="주요 서비스">
  <div class="container">
    <div class="quick-service-grid">
      <a href="${ctx}/user/about/intro.do" class="quick-service-item">
        <span class="quick-icon quick-icon-purple"><i class="bi bi-door-open"></i></span>
        <span><strong>청년공간</strong><small>시설 및 이용 안내</small></span>
        <i class="bi bi-arrow-up-right quick-arrow"></i>
      </a>
      <a href="${ctx}/user/space/apply.do" class="quick-service-item">
        <span class="quick-icon quick-icon-blue"><i class="bi bi-calendar2-check"></i></span>
        <span><strong>대관신청</strong><small>공간 예약 바로가기</small></span>
        <i class="bi bi-arrow-up-right quick-arrow"></i>
      </a>
      <a href="${ctx}/user/program/list.do" class="quick-service-item">
        <span class="quick-icon quick-icon-coral"><i class="bi bi-grid-1x2"></i></span>
        <span><strong>프로그램</strong><small>모집 프로그램 확인</small></span>
        <i class="bi bi-arrow-up-right quick-arrow"></i>
      </a>
      <a href="${ctx}/user/support/policy.do" class="quick-service-item">
        <span class="quick-icon quick-icon-green"><i class="bi bi-megaphone"></i></span>
        <span><strong>청년정책</strong><small>맞춤 정책 한눈에</small></span>
        <i class="bi bi-arrow-up-right quick-arrow"></i>
      </a>
      <a href="${ctx}/user/support/counsel.do" class="quick-service-item">
        <span class="quick-icon quick-icon-yellow"><i class="bi bi-chat-square-heart"></i></span>
        <span><strong>청년상담</strong><small>고민 상담 신청</small></span>
        <i class="bi bi-arrow-up-right quick-arrow"></i>
      </a>
    </div>
  </div>
</section>

<section class="main-section program-section">
  <div class="container">
    <div class="section-heading section-heading-center">
      <p class="section-eyebrow">YOUTH PROGRAM</p>
      <h2>지금 참여할 수 있는 프로그램</h2>
      <p>관심 있는 프로그램을 발견하고 새로운 경험을 시작해 보세요.</p>
    </div>

    <ul class="nav program-tabs justify-content-center" id="programTabs" role="tablist">
      <li class="nav-item" role="presentation">
        <button class="nav-link active" id="center-program-tab" data-bs-toggle="tab"
                data-bs-target="#center-program" type="button" role="tab"
                aria-controls="center-program" aria-selected="true">센터 프로그램</button>
      </li>
      <li class="nav-item" role="presentation">
        <button class="nav-link" id="outside-program-tab" data-bs-toggle="tab"
                data-bs-target="#outside-program" type="button" role="tab"
                aria-controls="outside-program" aria-selected="false">외부 프로그램</button>
      </li>
    </ul>

    <div class="tab-content">
      <div class="tab-pane fade show active" id="center-program" role="tabpanel"
           aria-labelledby="center-program-tab" tabindex="0">
        <div class="row g-4">
          <div class="col-sm-6 col-lg-3">
            <a href="${ctx}/user/program/detail.do?id=1" class="program-card">
              <div class="program-thumbnail program-thumb-one">
                <span class="program-status status-open">모집중</span>
                <div class="thumb-shape shape-circle"></div>
                <div class="thumb-copy">
                  <small>YOUTH NETWORKING</small>
                  <strong>낭만의 밤,<br>우리 동네 지도 만들기</strong>
                </div>
                <i class="bi bi-geo-alt-fill thumb-icon"></i>
              </div>
              <div class="program-card-body">
                <span class="program-category">네트워킹</span>
                <h3>낭만의 밤, 우리 동네 지도 만들기</h3>
                <p><i class="bi bi-calendar3"></i> 2026.06.26 (금)</p>
              </div>
            </a>
          </div>
          <div class="col-sm-6 col-lg-3">
            <a href="${ctx}/user/program/detail.do?id=2" class="program-card">
              <div class="program-thumbnail program-thumb-two">
                <span class="program-status status-open">모집중</span>
                <div class="thumb-shape shape-square"></div>
                <div class="thumb-copy">
                  <small>LIFE CLASS</small>
                  <strong>처음 시작하는<br>부동산 특강 A to Z</strong>
                </div>
                <i class="bi bi-house-heart-fill thumb-icon"></i>
              </div>
              <div class="program-card-body">
                <span class="program-category">생활경제</span>
                <h3>처음 시작하는 부동산 특강 A to Z</h3>
                <p><i class="bi bi-calendar3"></i> 2026.06.27 (토)</p>
              </div>
            </a>
          </div>
          <div class="col-sm-6 col-lg-3">
            <a href="${ctx}/user/program/detail.do?id=3" class="program-card">
              <div class="program-thumbnail program-thumb-three">
                <span class="program-status status-soon">마감임박</span>
                <div class="thumb-shape shape-wave"></div>
                <div class="thumb-copy">
                  <small>WRITING CLASS</small>
                  <strong>사진 한 장으로<br>시와 에세이 쓰기</strong>
                </div>
                <i class="bi bi-pencil-fill thumb-icon"></i>
              </div>
              <div class="program-card-body">
                <span class="program-category">문화예술</span>
                <h3>사진 한 장으로 시와 에세이 쓰기</h3>
                <p><i class="bi bi-calendar3"></i> 2026.07.02 (목)</p>
              </div>
            </a>
          </div>
          <div class="col-sm-6 col-lg-3">
            <a href="${ctx}/user/program/detail.do?id=4" class="program-card">
              <div class="program-thumbnail program-thumb-four">
                <span class="program-status status-closed">모집마감</span>
                <div class="thumb-shape shape-arch"></div>
                <div class="thumb-copy">
                  <small>HANDMADE CLASS</small>
                  <strong>내 손으로 만드는<br>컬러 뜨개 시계</strong>
                </div>
                <i class="bi bi-clock-fill thumb-icon"></i>
              </div>
              <div class="program-card-body">
                <span class="program-category">취미생활</span>
                <h3>내 손으로 만드는 컬러 뜨개 시계</h3>
                <p><i class="bi bi-calendar3"></i> 2026.07.04 (토)</p>
              </div>
            </a>
          </div>
        </div>
      </div>

      <div class="tab-pane fade" id="outside-program" role="tabpanel"
           aria-labelledby="outside-program-tab" tabindex="0">
        <div class="row g-4">
          <div class="col-sm-6 col-lg-3">
            <a href="${ctx}/user/program/detail.do?id=5" class="program-card">
              <div class="program-thumbnail program-thumb-five">
                <span class="program-status status-open">모집중</span>
                <div class="thumb-copy">
                  <small>CAREER</small>
                  <strong>디지털 전환<br>실무 전문가 과정</strong>
                </div>
                <i class="bi bi-laptop-fill thumb-icon"></i>
              </div>
              <div class="program-card-body">
                <span class="program-category">외부기관</span>
                <h3>디지털 전환 실무 전문가 과정</h3>
                <p><i class="bi bi-calendar3"></i> 2026.07.08 (수)</p>
              </div>
            </a>
          </div>
          <div class="col-sm-6 col-lg-3">
            <a href="${ctx}/user/program/detail.do?id=6" class="program-card">
              <div class="program-thumbnail program-thumb-six">
                <span class="program-status status-open">모집중</span>
                <div class="thumb-copy">
                  <small>JOB FAIR</small>
                  <strong>청년 일자리<br>매칭 데이</strong>
                </div>
                <i class="bi bi-briefcase-fill thumb-icon"></i>
              </div>
              <div class="program-card-body">
                <span class="program-category">유관기관</span>
                <h3>청년 일자리 매칭 데이</h3>
                <p><i class="bi bi-calendar3"></i> 2026.07.10 (금)</p>
              </div>
            </a>
          </div>
          <div class="col-sm-6 col-lg-3">
            <a href="${ctx}/user/program/detail.do?id=7" class="program-card">
              <div class="program-thumbnail program-thumb-seven">
                <span class="program-status status-soon">마감임박</span>
                <div class="thumb-copy">
                  <small>MENTORING</small>
                  <strong>현직자와 함께하는<br>온라인 멘토링</strong>
                </div>
                <i class="bi bi-camera-video-fill thumb-icon"></i>
              </div>
              <div class="program-card-body">
                <span class="program-category">온라인</span>
                <h3>현직자와 함께하는 온라인 멘토링</h3>
                <p><i class="bi bi-calendar3"></i> 2026.07.15 (수)</p>
              </div>
            </a>
          </div>
          <div class="col-sm-6 col-lg-3">
            <a href="${ctx}/user/program/detail.do?id=8" class="program-card">
              <div class="program-thumbnail program-thumb-eight">
                <span class="program-status status-open">모집중</span>
                <div class="thumb-copy">
                  <small>WELLNESS</small>
                  <strong>퇴근 후<br>마음 돌봄 클래스</strong>
                </div>
                <i class="bi bi-heart-pulse-fill thumb-icon"></i>
              </div>
              <div class="program-card-body">
                <span class="program-category">마음건강</span>
                <h3>퇴근 후 마음 돌봄 클래스</h3>
                <p><i class="bi bi-calendar3"></i> 2026.07.17 (금)</p>
              </div>
            </a>
          </div>
        </div>
      </div>
    </div>

    <div class="section-more-wrap">
      <a href="${ctx}/user/program/list.do" class="outline-more-btn">
        프로그램 전체보기 <i class="bi bi-arrow-right"></i>
      </a>
    </div>
  </div>
</section>

<section class="main-section information-section">
  <div class="container">
    <div class="row g-4 g-xl-5">
      <div class="col-lg-7">
        <div class="section-heading section-heading-inline">
          <div>
            <p class="section-eyebrow">NOTICE</p>
            <h2>공지사항</h2>
          </div>
          <a href="${ctx}/user/notice/list.do" class="circle-more-btn" aria-label="공지사항 더보기">
            <i class="bi bi-plus-lg"></i>
          </a>
        </div>
        <div class="notice-feature">
          <a href="#" class="notice-feature-date">
            <strong>19</strong><span>2026.06</span>
          </a>
          <a href="#" class="notice-feature-copy">
            <span class="notice-label">공지</span>
            <strong>SGH 청년공간 7월 프로그램 참여자 모집 안내</strong>
            <p>문화·생활·진로 분야의 새로운 프로그램 신청 일정을 확인해 주세요.</p>
          </a>
        </div>
        <ul class="main-notice-list">
          <li>
            <a href="#"><span>2026년 청년 커뮤니티 지원사업 선정 결과 안내</span><time>2026.06.17</time></a>
          </li>
          <li>
            <a href="#"><span>다목적실 음향 장비 교체에 따른 이용 제한 안내</span><time>2026.06.12</time></a>
          </li>
          <li>
            <a href="#"><span>청년 마음건강 상담 3기 신청 접수</span><time>2026.06.09</time></a>
          </li>
          <li>
            <a href="#"><span>6월 휴관일 및 시설 운영시간 안내</span><time>2026.06.03</time></a>
          </li>
        </ul>
      </div>

      <div class="col-lg-5">
        <div class="schedule-card">
          <div class="schedule-header">
            <div>
              <p class="section-eyebrow">SCHEDULE</p>
              <h2>센터 일정</h2>
            </div>
            <div class="schedule-month">
              <button type="button" aria-label="이전 달"><i class="bi bi-chevron-left"></i></button>
              <strong>2026. 06</strong>
              <button type="button" aria-label="다음 달"><i class="bi bi-chevron-right"></i></button>
            </div>
          </div>
          <div class="mini-calendar" aria-label="2026년 6월 달력">
            <div class="calendar-week calendar-head">
              <span class="sunday">SUN</span><span>MON</span><span>TUE</span><span>WED</span>
              <span>THU</span><span>FRI</span><span class="saturday">SAT</span>
            </div>
            <div class="calendar-week">
              <span></span><span>1</span><span>2</span><span>3</span><span>4</span><span>5</span><span class="saturday">6</span>
            </div>
            <div class="calendar-week">
              <span class="sunday">7</span><span>8</span><span>9</span><span>10</span><span>11</span><span>12</span><span class="saturday">13</span>
            </div>
            <div class="calendar-week">
              <span class="sunday">14</span><span>15</span><span>16</span><span>17</span><span>18</span><span class="has-event">19</span><span class="saturday">20</span>
            </div>
            <div class="calendar-week">
              <span class="sunday">21</span><span>22</span><span>23</span><span class="has-event event-coral">24</span><span>25</span><span>26</span><span class="saturday">27</span>
            </div>
            <div class="calendar-week">
              <span class="sunday">28</span><span>29</span><span>30</span><span></span><span></span><span></span><span></span>
            </div>
          </div>
          <div class="schedule-items">
            <a href="#">
              <time>06.19</time>
              <span><strong>청년 네트워킹 데이</strong><small>18:30 · 커뮤니티홀</small></span>
              <i class="bi bi-chevron-right"></i>
            </a>
            <a href="#">
              <time>06.24</time>
              <span><strong>6월 문화 프로그램</strong><small>19:00 · 다목적실</small></span>
              <i class="bi bi-chevron-right"></i>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="main-section gallery-section">
  <div class="container">
    <div class="section-heading section-heading-split">
      <div>
        <p class="section-eyebrow">YOUTH STORY</p>
        <h2>청년공간 활동 이야기</h2>
        <p>SGH 청년공간에서 함께 만든 즐거운 순간을 만나보세요.</p>
      </div>
      <a href="${ctx}/user/gallery/list.do" class="outline-more-btn">
        활동사진 더보기 <i class="bi bi-arrow-right"></i>
      </a>
    </div>

    <div class="row g-4">
      <div class="col-md-6 col-xl-3">
        <a href="#" class="story-card">
          <div class="story-visual story-visual-one">
            <div class="story-scene">
              <span class="scene-board"><i class="bi bi-lightbulb"></i></span>
              <span class="scene-person scene-person-a"><i class="bi bi-person-standing"></i></span>
              <span class="scene-person scene-person-b"><i class="bi bi-person-standing-dress"></i></span>
            </div>
            <span class="story-arrow"><i class="bi bi-arrow-up-right"></i></span>
          </div>
          <div class="story-card-body">
            <span>프로그램 후기</span>
            <h3>청년 커뮤니티 아이디어 워크숍</h3>
            <time>2026.06.14</time>
          </div>
        </a>
      </div>
      <div class="col-md-6 col-xl-3">
        <a href="#" class="story-card">
          <div class="story-visual story-visual-two">
            <div class="story-scene">
              <span class="scene-table"></span>
              <span class="scene-cup cup-a"><i class="bi bi-cup-hot-fill"></i></span>
              <span class="scene-cup cup-b"><i class="bi bi-cup-straw"></i></span>
            </div>
            <span class="story-arrow"><i class="bi bi-arrow-up-right"></i></span>
          </div>
          <div class="story-card-body">
            <span>네트워킹</span>
            <h3>퇴근 후 만나는 느슨한 연결의 밤</h3>
            <time>2026.06.08</time>
          </div>
        </a>
      </div>
      <div class="col-md-6 col-xl-3">
        <a href="#" class="story-card">
          <div class="story-visual story-visual-three">
            <div class="story-scene">
              <span class="scene-laptop"><i class="bi bi-code-slash"></i></span>
              <span class="scene-key key-a"></span><span class="scene-key key-b"></span>
              <span class="scene-key key-c"></span>
            </div>
            <span class="story-arrow"><i class="bi bi-arrow-up-right"></i></span>
          </div>
          <div class="story-card-body">
            <span>역량강화</span>
            <h3>나만의 포트폴리오 웹사이트 만들기</h3>
            <time>2026.05.31</time>
          </div>
        </a>
      </div>
      <div class="col-md-6 col-xl-3">
        <a href="#" class="story-card">
          <div class="story-visual story-visual-four">
            <div class="story-scene">
              <span class="scene-heart"><i class="bi bi-heart-fill"></i></span>
              <span class="scene-spark spark-a">✦</span><span class="scene-spark spark-b">✦</span>
            </div>
            <span class="story-arrow"><i class="bi bi-arrow-up-right"></i></span>
          </div>
          <div class="story-card-body">
            <span>마음건강</span>
            <h3>오늘의 마음을 돌보는 작은 연습</h3>
            <time>2026.05.24</time>
          </div>
        </a>
      </div>
    </div>
  </div>
</section>

<section class="main-contact-banner">
  <div class="container">
    <div class="contact-banner-inner">
      <div>
        <span class="contact-icon"><i class="bi bi-chat-dots-fill"></i></span>
        <div>
          <p>무엇이든 편하게 물어보세요</p>
          <h2>청년의 내일을 함께 고민하겠습니다.</h2>
        </div>
      </div>
      <div class="contact-actions">
        <a href="${ctx}/user/support/counsel.do">온라인 상담 <i class="bi bi-arrow-right"></i></a>
        <a href="tel:02-0000-0000">02-0000-0000</a>
      </div>
    </div>
  </div>
</section>

<aside class="social-quick" aria-label="소셜 미디어 및 빠른 메뉴">
  <a href="#" aria-label="인스타그램"><i class="bi bi-instagram"></i></a>
  <a href="#" aria-label="유튜브"><i class="bi bi-youtube"></i></a>
  <a href="#" aria-label="블로그"><i class="bi bi-chat-fill"></i></a>
  <button type="button" id="pageTopBtn" aria-label="페이지 맨 위로"><i class="bi bi-chevron-up"></i></button>
</aside>
