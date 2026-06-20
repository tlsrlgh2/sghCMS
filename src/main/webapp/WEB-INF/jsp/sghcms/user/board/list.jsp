<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="boardTitle" value="${not empty menu.menuNm ? menu.menuNm : boardMasterVO.bbsNm}"/>
<html>
<head>
  <title><c:out value="${boardTitle}"/> - SGH 청년공간</title>
</head>
<body>
<section class="user-page-section user-board">
  <div class="container">
    <header class="user-page-heading">
      <h1><c:out value="${boardTitle}"/></h1>
    </header>

    <div class="table-responsive">
      <table class="table user-board-list align-middle">
        <caption class="visually-hidden"><c:out value="${boardTitle}"/> 게시물 목록</caption>
        <thead>
          <tr>
            <th scope="col" style="width:80px;">번호</th>
            <th scope="col">제목</th>
            <th scope="col" style="width:140px;">작성자</th>
            <th scope="col" style="width:130px;">등록일</th>
            <th scope="col" style="width:90px;">조회</th>
          </tr>
        </thead>
        <tbody>
          <%-- 상단 고정 공지 --%>
          <c:forEach var="notice" items="${noticeList}">
            <tr class="board-notice-row">
              <td><span class="badge text-bg-primary">공지</span></td>
              <td class="text-start">
                <a href="${ctx}/user/board/view.do?bbsId=${boardMasterVO.bbsId}&nttId=${notice.nttId}&pageIndex=${searchVO.pageIndex}">
                  <c:out value="${notice.nttSj}"/>
                </a>
              </td>
              <td><c:out value="${notice.frstRegisterNm}"/></td>
              <td><c:out value="${notice.frstRegisterPnttm}"/></td>
              <td><c:out value="${notice.inqireCo}"/></td>
            </tr>
          </c:forEach>

          <%-- 일반 게시물 --%>
          <c:forEach var="row" items="${resultList}" varStatus="status">
            <c:set var="listNo"
                   value="${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo - 1) * paginationInfo.recordCountPerPage) - status.index}"/>
            <tr>
              <td><c:out value="${listNo}"/></td>
              <td class="text-start">
                <a href="${ctx}/user/board/view.do?bbsId=${boardMasterVO.bbsId}&nttId=${row.nttId}&pageIndex=${searchVO.pageIndex}">
                  <c:out value="${row.nttSj}"/>
                </a>
              </td>
              <td><c:out value="${row.frstRegisterNm}"/></td>
              <td><c:out value="${row.frstRegisterPnttm}"/></td>
              <td><c:out value="${row.inqireCo}"/></td>
            </tr>
          </c:forEach>

          <c:if test="${empty resultList and empty noticeList}">
            <tr>
              <td colspan="5" class="text-center py-5 text-muted">등록된 게시물이 없습니다.</td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>

    <%-- 페이지네이션 --%>
    <c:if test="${paginationInfo.totalPageCount > 1}">
      <nav class="user-board-pagination" aria-label="페이지 이동">
        <ul class="pagination justify-content-center">
          <c:if test="${paginationInfo.currentPageNo > 1}">
            <li class="page-item">
              <a class="page-link" href="${ctx}/user/board/list.do?bbsId=${boardMasterVO.bbsId}&pageIndex=${paginationInfo.currentPageNo - 1}" aria-label="이전">&laquo;</a>
            </li>
          </c:if>
          <c:forEach var="pageNo" begin="${paginationInfo.firstPageNoOnPageList}" end="${paginationInfo.lastPageNoOnPageList}">
            <li class="page-item ${pageNo == paginationInfo.currentPageNo ? 'active' : ''}">
              <a class="page-link" href="${ctx}/user/board/list.do?bbsId=${boardMasterVO.bbsId}&pageIndex=${pageNo}"><c:out value="${pageNo}"/></a>
            </li>
          </c:forEach>
          <c:if test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount}">
            <li class="page-item">
              <a class="page-link" href="${ctx}/user/board/list.do?bbsId=${boardMasterVO.bbsId}&pageIndex=${paginationInfo.currentPageNo + 1}" aria-label="다음">&raquo;</a>
            </li>
          </c:if>
        </ul>
      </nav>
    </c:if>
  </div>
</section>
</body>
</html>
