<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <title>콘텐츠 편집 - <c:out value="${menu.menuNm}"/></title>
  <script src="${ctx}/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js"></script>
</head>
<body>

<div class="d-flex justify-content-between align-items-center mb-3">
  <h4 class="fw-bold mb-0">콘텐츠 편집 — <c:out value="${menu.menuNm}"/></h4>
  <a href="${ctx}/admin/content/userMenu/list.do" class="btn btn-outline-secondary btn-sm">← 메뉴 목록</a>
</div>

<c:if test="${saved}">
  <div class="alert alert-success alert-dismissible fade show" role="alert">
    저장되었습니다.
    <button type="button" class="btn-close" data-coreui-dismiss="alert" data-bs-dismiss="alert"></button>
  </div>
</c:if>

<div class="card">
  <div class="card-header d-flex justify-content-between align-items-center">
    <span class="fw-semibold"><c:out value="${menu.menuNm}"/> 페이지 본문</span>
    <c:if test="${not empty content.updde}">
      <small class="text-muted">
        최종 수정: <fmt:formatDate value="${content.updde}" pattern="yyyy-MM-dd HH:mm"/>
        <c:if test="${not empty content.updusr}">(<c:out value="${content.updusr}"/>)</c:if>
      </small>
    </c:if>
  </div>
  <div class="card-body">
    <form method="post" action="${ctx}/admin/content/userMenu/contentSave.do">
      <input type="hidden" name="menuId" value="${menu.menuId}"/>
      <textarea id="contentHtml" name="contentHtml" style="width:100%"><c:out value="${content.contentHtml}" escapeXml="false"/></textarea>
      <div class="mt-3 d-flex gap-2">
        <button type="submit" class="btn btn-primary">저장</button>
        <c:if test="${not empty menu.urlPath}">
          <a href="${ctx}/user/page/${menu.urlPath}.do" target="_blank" class="btn btn-outline-secondary">
            사용자 페이지 미리보기
          </a>
        </c:if>
      </div>
    </form>
  </div>
</div>

<script>
  CKEDITOR.replace('contentHtml', {
    height: 500,
    filebrowserImageUploadUrl: '${ctx}/ckUploadImage'
  });
</script>
</body>
</html>
