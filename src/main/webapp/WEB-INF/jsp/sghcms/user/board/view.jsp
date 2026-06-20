<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="boardTitle" value="${not empty menu.menuNm ? menu.menuNm : boardMasterVO.bbsNm}"/>
<html>
<head>
  <title><c:out value="${result.nttSj}"/> - SGH 청년공간</title>
</head>
<body>
<section class="user-page-section user-board-view">
  <div class="container">
    <header class="user-page-heading">
      <h1><c:out value="${boardTitle}"/></h1>
    </header>

    <article class="board-article">
      <h2 class="board-article-title"><c:out value="${result.nttSj}"/></h2>
      <ul class="board-article-meta list-inline text-muted">
        <li class="list-inline-item">작성자 <c:out value="${result.frstRegisterNm}"/></li>
        <li class="list-inline-item">등록일 <c:out value="${result.frstRegisterPnttm}"/></li>
        <li class="list-inline-item">조회 <c:out value="${result.inqireCo}"/></li>
      </ul>

      <div class="board-article-body" style="white-space: pre-wrap;">
        <c:out value="${result.nttCn}" escapeXml="true"/>
      </div>
    </article>

    <div class="board-article-actions">
      <a class="btn btn-outline-secondary"
         href="${ctx}/user/board/list.do?bbsId=${boardMasterVO.bbsId}&pageIndex=${searchVO.pageIndex}">목록</a>
    </div>
  </div>
</section>
</body>
</html>
