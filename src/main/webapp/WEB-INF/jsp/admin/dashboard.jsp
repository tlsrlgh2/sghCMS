<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
  <title>대시보드</title>
</head>
<body>
<div class="container-fluid">

  <!-- 통계 카드 -->
  <div class="row g-4 mb-4">
    <div class="col-sm-6 col-xl-3">
      <div class="card text-white bg-primary">
        <div class="card-body pb-0 d-flex justify-content-between align-items-start">
          <div>
            <div class="fs-4 fw-semibold">${stats.totalUsers}<span class="fs-6 ms-2 fw-normal">명</span></div>
            <div>전체 회원수</div><!-- TODO: DB 연동 -->
          </div>
        </div>
        <div class="c-chart-wrapper mt-3 mx-3" style="height:70px">
        </div>
      </div>
    </div>
    <div class="col-sm-6 col-xl-3">
      <div class="card text-white bg-info">
        <div class="card-body pb-0 d-flex justify-content-between align-items-start">
          <div>
            <div class="fs-4 fw-semibold">${stats.totalPosts}<span class="fs-6 ms-2 fw-normal">건</span></div>
            <div>전체 게시글</div><!-- TODO: DB 연동 -->
          </div>
        </div>
        <div class="c-chart-wrapper mt-3 mx-3" style="height:70px">
        </div>
      </div>
    </div>
    <div class="col-sm-6 col-xl-3">
      <div class="card text-white bg-warning">
        <div class="card-body pb-0 d-flex justify-content-between align-items-start">
          <div>
            <div class="fs-4 fw-semibold">${stats.todayVisits}<span class="fs-6 ms-2 fw-normal">명</span></div>
            <div>오늘 방문자</div><!-- TODO: DB 연동 -->
          </div>
        </div>
        <div class="c-chart-wrapper mt-3 mx-3" style="height:70px">
        </div>
      </div>
    </div>
    <div class="col-sm-6 col-xl-3">
      <div class="card text-white bg-danger">
        <div class="card-body pb-0 d-flex justify-content-between align-items-start">
          <div>
            <div class="fs-4 fw-semibold">${stats.newComments}<span class="fs-6 ms-2 fw-normal">건</span></div>
            <div>새 댓글</div><!-- TODO: DB 연동 -->
          </div>
        </div>
        <div class="c-chart-wrapper mt-3 mx-3" style="height:70px">
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <!-- 최근 게시글 -->
    <div class="col-md-8 mb-4">
      <div class="card">
        <div class="card-header">
          <strong>최근 게시글</strong><!-- TODO: DB 연동 -->
        </div>
        <div class="card-body">
          <table class="table table-hover table-sm mb-0">
            <thead class="table-light">
              <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>분류</th>
                <th>날짜</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="post" items="${recentPosts}">
              <tr>
                <td>${post.id}</td>
                <td>${post.title}</td>
                <td>${post.author}</td>
                <td><span class="badge bg-secondary">${post.category}</span></td>
                <td>${post.date}</td>
              </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- 최근 가입 회원 -->
    <div class="col-md-4 mb-4">
      <div class="card">
        <div class="card-header">
          <strong>최근 가입 회원</strong><!-- TODO: DB 연동 -->
        </div>
        <div class="card-body">
          <table class="table table-hover table-sm mb-0">
            <thead class="table-light">
              <tr>
                <th>ID</th>
                <th>이름</th>
                <th>구분</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="u" items="${recentUsers}">
              <tr>
                <td>${u.userId}</td>
                <td>${u.userName}</td>
                <td>
                  <c:choose>
                    <c:when test="${u.userSe == '업무'}"><span class="badge bg-danger">${u.userSe}</span></c:when>
                    <c:when test="${u.userSe == '기업'}"><span class="badge bg-warning text-dark">${u.userSe}</span></c:when>
                    <c:otherwise><span class="badge bg-primary">${u.userSe}</span></c:otherwise>
                  </c:choose>
                </td>
              </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

</div>
</body>
</html>
