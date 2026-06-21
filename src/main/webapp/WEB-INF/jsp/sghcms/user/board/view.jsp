<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="boardTitle" value="${not empty menu.menuNm ? menu.menuNm : boardMasterVO.bbsNm}"/>
<html>
<head>
  <title><c:out value="${result.nttSj}"/> - SGH 청년공간</title>
  <style>
    /* 사용자 게시판 상세 - 제목/본문 직관적 구분 */
    .user-board-view .board-article {
      border: 1px solid #e3e6ea;
      border-radius: 12px;
      overflow: hidden;
      background: #fff;
      box-shadow: 0 2px 10px rgba(0, 0, 0, .04);
    }
    .user-board-view .board-article-header {
      padding: 28px 32px 20px;
      border-bottom: 1px solid #eef0f3;
      background: #fafbfc;
    }
    .user-board-view .board-article-title {
      margin: 0 0 14px;
      font-size: 1.6rem;
      font-weight: 700;
      line-height: 1.35;
      color: #1a1f27;
      word-break: keep-all;
    }
    .user-board-view .board-article-meta {
      display: flex;
      flex-wrap: wrap;
      gap: 18px;
      margin: 0;
      padding: 0;
      list-style: none;
      font-size: .9rem;
      color: #7a828c;
    }
    .user-board-view .board-article-meta .meta-label {
      font-weight: 600;
      color: #9aa1aa;
      margin-right: 4px;
    }
    .user-board-view .board-article-body {
      padding: 32px;
      min-height: 180px;
      font-size: 1rem;
      line-height: 1.8;
      color: #2c333c;
      word-break: keep-all;
    }
    /* 본문에 삽입된 이미지가 영역을 넘지 않도록 */
    .user-board-view .board-article-body img {
      max-width: 100%;
      height: auto;
    }
    .user-board-view .board-article-body table {
      max-width: 100%;
    }
    .user-board-view .board-article-actions {
      margin-top: 24px;
      text-align: center;
    }
    /* 관리자 답글(댓글) 섹션 */
    .user-board-view .admin-replies {
      margin-top: 32px;
      border-top: 2px solid #e3e6ea;
      padding-top: 24px;
    }
    .user-board-view .admin-replies-title {
      font-size: 1.05rem;
      font-weight: 700;
      color: #3a4050;
      margin: 0 0 16px;
    }
    .user-board-view .reply-item {
      background: #f6f8fb;
      border: 1px solid #e3e6ea;
      border-radius: 8px;
      padding: 16px 20px;
      margin-bottom: 12px;
    }
    .user-board-view .reply-meta {
      display: flex;
      gap: 12px;
      font-size: .85rem;
      color: #7a828c;
      margin-bottom: 8px;
    }
    .user-board-view .reply-author {
      font-weight: 700;
      color: #3c72c4;
    }
    .user-board-view .reply-content {
      font-size: .95rem;
      line-height: 1.7;
      color: #2c333c;
      word-break: keep-all;
    }
    .user-board-view .reply-content img {
      max-width: 100%;
      height: auto;
    }
  </style>
</head>
<body>
<section class="user-page-section user-board-view">
  <div class="container">
    <header class="user-page-heading">
      <h1><c:out value="${boardTitle}"/></h1>
    </header>

    <article class="board-article">
      <%-- 제목 영역 --%>
      <div class="board-article-header">
        <h2 class="board-article-title"><c:out value="${result.nttSj}"/></h2>
        <ul class="board-article-meta">
          <li><span class="meta-label">작성자</span><c:out value="${result.frstRegisterNm}"/></li>
          <li><span class="meta-label">등록일</span><c:out value="${result.frstRegisterPnttm}"/></li>
          <li><span class="meta-label">조회</span><c:out value="${result.inqireCo}"/></li>
        </ul>
      </div>

      <%-- 본문 영역: 저장 본문을 디코드·새니타이즈한 HTML(이미지 포함)을 렌더링 (UserBoardController) --%>
      <div class="board-article-body">
        ${contentHtml}
      </div>
    </article>

    <%-- 관리자 답글(댓글) 섹션 --%>
    <c:if test="${not empty adminReplies}">
      <section class="admin-replies">
        <h3 class="admin-replies-title">댓글 <span style="color:#888;font-weight:400">(${fn:length(adminReplies)})</span></h3>
        <c:forEach var="reply" items="${adminReplies}">
          <div class="reply-item">
            <div class="reply-meta">
              <span class="reply-author"><c:out value="${reply.frstRegisterNm}"/></span>
              <span><c:out value="${reply.frstRegisterPnttm}"/></span>
            </div>
            <div class="reply-content">${reply.nttCn}</div>
          </div>
        </c:forEach>
      </section>
    </c:if>

    <div class="board-article-actions">
      <a class="btn btn-outline-secondary"
         href="${ctx}/user/board/list.do?bbsId=${boardMasterVO.bbsId}&pageIndex=${searchVO.pageIndex}">목록</a>
      <%-- 사용자 작성 허용 + 본인 글인 경우 수정/삭제 버튼 노출 --%>
      <c:if test="${boardConfig.userWriteAt eq 'Y' and isOwner}">
        <a class="btn btn-outline-primary ms-2"
           href="${ctx}/user/board/modify.do?bbsId=${boardMasterVO.bbsId}&nttId=${result.nttId}&pageIndex=${searchVO.pageIndex}">수정</a>
        <form method="post" action="${ctx}/user/board/delete.do" class="d-inline ms-2"
              onsubmit="return confirm('삭제하시겠습니까?');">
          <input type="hidden" name="bbsId"     value="<c:out value='${boardMasterVO.bbsId}'/>">
          <input type="hidden" name="nttId"     value="<c:out value='${result.nttId}'/>">
          <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
          <button type="submit" class="btn btn-outline-danger">삭제</button>
        </form>
      </c:if>
    </div>
  </div>
</section>
</body>
</html>
