<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="boardTitle" value="${not empty menu.menuNm ? menu.menuNm : boardMasterVO.bbsNm}"/>
<html>
<head>
  <title><c:out value="${boardTitle}"/> 수정 - SGH 청년공간</title>
</head>
<body>
<section class="user-page-section user-board-modify">
  <div class="container">
    <header class="user-page-heading">
      <h1><c:out value="${boardTitle}"/> 수정</h1>
    </header>

    <form method="post" action="${ctx}/user/board/modifySave.do"
          enctype="multipart/form-data" class="board-write-form">
      <input type="hidden" name="bbsId"     value="<c:out value='${boardMasterVO.bbsId}'/>">
      <input type="hidden" name="nttId"     value="<c:out value='${articleVO.nttId}'/>">
      <input type="hidden" name="atchFileId" value="<c:out value='${articleVO.atchFileId}'/>">
      <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">

      <div class="mb-3">
        <label for="nttSj" class="form-label fw-semibold">제목 <span class="text-danger">*</span></label>
        <input type="text" id="nttSj" name="nttSj" class="form-control"
               maxlength="200" required value="<c:out value='${articleVO.nttSj}'/>">
      </div>

      <div class="mb-3">
        <label for="nttCn" class="form-label fw-semibold">내용 <span class="text-danger">*</span></label>
        <textarea id="nttCn" name="nttCn" class="form-control" rows="12" required><c:out value="${articleVO.nttCn}"/></textarea>
      </div>

      <c:if test="${boardMasterVO.fileAtchPosblAt eq 'Y'}">
        <div class="mb-3">
          <label class="form-label fw-semibold">첨부파일</label>
          <input type="file" name="file_1" class="form-control" multiple>
        </div>
      </c:if>

      <div class="d-flex gap-2 justify-content-center mt-4">
        <button type="submit" class="btn btn-primary px-4">저장</button>
        <a href="${ctx}/user/board/view.do?bbsId=${boardMasterVO.bbsId}&nttId=${articleVO.nttId}&pageIndex=${searchVO.pageIndex}"
           class="btn btn-outline-secondary px-4">취소</a>
      </div>
    </form>
  </div>
</section>
</body>
</html>
