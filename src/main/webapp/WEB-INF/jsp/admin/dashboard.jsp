<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<title>대시보드</title>

<div class="container-fluid px-4 py-4">

  <!-- 페이지 타이틀 -->
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="mb-0 fw-bold">대시보드</h4>
    <span class="text-muted small">최근 업데이트: 2026-06-19</span><!-- TODO: 동적 날짜로 교체 -->
  </div>

  <!-- 통계 카드 -->
  <div class="row g-4 mb-4">
    <div class="col-sm-6 col-xl-3">
      <div class="card text-white bg-primary">
        <div class="card-body d-flex justify-content-between align-items-center">
          <div>
            <div class="fs-4 fw-bold">${stats.totalUsers}</div><!-- TODO: DB 연동 -->
            <div class="small">전체 회원수</div>
          </div>
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="48" height="48" fill="rgba(255,255,255,0.4)">
            <path d="M256 288a128 128 0 1 0-128-128 128.14 128.14 0 0 0 128 128Zm0-224a96 96 0 1 1-96 96 96.11 96.11 0 0 1 96-96ZM256 320c-88.37 0-160 57.31-160 128v16h32v-16c0-52.94 57.41-96 128-96s128 43.06 128 96v16h32v-16c0-70.69-71.63-128-160-128Z"/>
          </svg>
        </div>
      </div>
    </div>
    <div class="col-sm-6 col-xl-3">
      <div class="card text-white bg-success">
        <div class="card-body d-flex justify-content-between align-items-center">
          <div>
            <div class="fs-4 fw-bold">${stats.totalPosts}</div><!-- TODO: DB 연동 -->
            <div class="small">전체 게시글</div>
          </div>
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="48" height="48" fill="rgba(255,255,255,0.4)">
            <path d="M112 152h288v32H112zm0 88h288v32H112zm0 88h152v32H112z"/>
          </svg>
        </div>
      </div>
    </div>
    <div class="col-sm-6 col-xl-3">
      <div class="card text-white bg-warning">
        <div class="card-body d-flex justify-content-between align-items-center">
          <div>
            <div class="fs-4 fw-bold">${stats.todayVisits}</div><!-- TODO: DB 연동 -->
            <div class="small">오늘 방문수</div>
          </div>
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="48" height="48" fill="rgba(255,255,255,0.4)">
            <path d="M425.706 142.294A240 240 0 0 0 16 312v88h144v-32H48v-56c0-114.691 93.309-208 208-208s208 93.309 208 208v56H352v32h144v-88a238.43 238.43 0 0 0-70.294-169.706"/>
          </svg>
        </div>
      </div>
    </div>
    <div class="col-sm-6 col-xl-3">
      <div class="card text-white bg-danger">
        <div class="card-body d-flex justify-content-between align-items-center">
          <div>
            <div class="fs-4 fw-bold">${stats.newComments}</div><!-- TODO: DB 연동 -->
            <div class="small">새 댓글</div>
          </div>
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="48" height="48" fill="rgba(255,255,255,0.4)">
            <path d="M448 0H64A64.072 64.072 0 0 0 0 64v288a64.072 64.072 0 0 0 64 64h96v88l120-88h168a64.072 64.072 0 0 0 64-64V64a64.072 64.072 0 0 0-64-64Z"/>
          </svg>
        </div>
      </div>
    </div>
  </div>

  <div class="row g-4">
    <!-- 최근 게시글 -->
    <div class="col-lg-7">
      <div class="card h-100">
        <div class="card-header d-flex justify-content-between align-items-center">
          <span class="fw-semibold">최근 게시글</span>
          <a href="#" class="btn btn-sm btn-outline-primary">더보기</a><!-- TODO: 게시판 목록 URL 연동 -->
        </div>
        <div class="card-body p-0">
          <table class="table table-hover mb-0">
            <thead class="table-light">
              <tr>
                <th class="ps-3">번호</th>
                <th>제목</th>
                <th>분류</th>
                <th>작성자</th>
                <th>날짜</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="post" items="${recentPosts}" varStatus="status">
              <tr>
                <td class="ps-3">${post.id}</td>
                <td>
                  <a href="#" class="text-decoration-none text-dark">${post.title}</a><!-- TODO: 게시글 상세 URL 연동 -->
                </td>
                <td><span class="badge bg-secondary">${post.category}</span></td>
                <td>${post.author}</td>
                <td class="text-muted small">${post.date}</td>
              </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- 최근 가입 회원 -->
    <div class="col-lg-5">
      <div class="card h-100">
        <div class="card-header d-flex justify-content-between align-items-center">
          <span class="fw-semibold">최근 가입 회원</span>
          <a href="#" class="btn btn-sm btn-outline-primary">더보기</a><!-- TODO: 회원 목록 URL 연동 -->
        </div>
        <div class="card-body p-0">
          <table class="table table-hover mb-0">
            <thead class="table-light">
              <tr>
                <th class="ps-3">아이디</th>
                <th>이름</th>
                <th>구분</th>
                <th>가입일</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="user" items="${recentUsers}">
              <tr>
                <td class="ps-3">${user.userId}</td>
                <td>${user.userName}</td>
                <td>
                  <span class="badge ${user.userSe == '일반' ? 'bg-primary' : user.userSe == '기업' ? 'bg-success' : 'bg-info'}">
                    ${user.userSe}
                  </span>
                </td>
                <td class="text-muted small">${user.regDate}</td>
              </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

</div>
