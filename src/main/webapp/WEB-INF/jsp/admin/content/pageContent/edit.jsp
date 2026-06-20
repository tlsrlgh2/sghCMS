<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <title>페이지 콘텐츠 관리</title>
  <script src="${ctx}/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js"></script>
</head>
<body>

<div class="d-flex justify-content-between align-items-center mb-3">
  <h4 class="fw-bold mb-0">페이지 콘텐츠 관리</h4>
</div>

<c:if test="${saved}">
  <div class="alert alert-success alert-dismissible fade show" role="alert">
    저장되었습니다.
    <button type="button" class="btn-close" data-coreui-dismiss="alert"></button>
  </div>
</c:if>

<div class="card mb-3">
  <div class="card-body p-0">
    <ul class="nav nav-tabs px-3 pt-2">

      <li class="nav-item"><span class="nav-link disabled text-muted small fw-semibold pe-1">청년공간</span></li>
      <li class="nav-item">
        <a class="nav-link${content.pageKey == 'about_intro'    ? ' active' : ''}" href="${ctx}/admin/content/pageContent/edit.do?pageKey=about_intro">공간 소개</a>
      </li>
      <li class="nav-item">
        <a class="nav-link${content.pageKey == 'about_facility' ? ' active' : ''}" href="${ctx}/admin/content/pageContent/edit.do?pageKey=about_facility">시설 안내</a>
      </li>
      <li class="nav-item">
        <a class="nav-link${content.pageKey == 'about_org'      ? ' active' : ''}" href="${ctx}/admin/content/pageContent/edit.do?pageKey=about_org">운영 조직</a>
      </li>
      <li class="nav-item">
        <a class="nav-link${content.pageKey == 'about_location' ? ' active' : ''}" href="${ctx}/admin/content/pageContent/edit.do?pageKey=about_location">오시는 길</a>
      </li>

      <li class="nav-item"><span class="nav-link disabled text-muted px-2">|</span></li>
      <li class="nav-item"><span class="nav-link disabled text-muted small fw-semibold pe-1">공간대관</span></li>
      <li class="nav-item">
        <a class="nav-link${content.pageKey == 'space_guide'    ? ' active' : ''}" href="${ctx}/admin/content/pageContent/edit.do?pageKey=space_guide">대관 안내</a>
      </li>

      <li class="nav-item"><span class="nav-link disabled text-muted px-2">|</span></li>
      <li class="nav-item"><span class="nav-link disabled text-muted small fw-semibold pe-1">청년지원</span></li>
      <li class="nav-item">
        <a class="nav-link${content.pageKey == 'support_policy'  ? ' active' : ''}" href="${ctx}/admin/content/pageContent/edit.do?pageKey=support_policy">청년정책</a>
      </li>
      <li class="nav-item">
        <a class="nav-link${content.pageKey == 'support_job'     ? ' active' : ''}" href="${ctx}/admin/content/pageContent/edit.do?pageKey=support_job">일자리 정보</a>
      </li>
      <li class="nav-item">
        <a class="nav-link${content.pageKey == 'support_counsel' ? ' active' : ''}" href="${ctx}/admin/content/pageContent/edit.do?pageKey=support_counsel">청년 상담</a>
      </li>

    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header d-flex justify-content-between align-items-center">
    <span class="fw-semibold"><c:out value="${content.pageTitle}"/> 편집</span>
    <c:if test="${not empty content.updde}">
      <small class="text-muted">
        최종 수정: <fmt:formatDate value="${content.updde}" pattern="yyyy-MM-dd HH:mm"/>
        <c:if test="${not empty content.updusr}">(<c:out value="${content.updusr}"/>)</c:if>
      </small>
    </c:if>
  </div>
  <div class="card-body">
    <form method="post" action="${ctx}/admin/content/pageContent/save.do">
      <input type="hidden" name="pageKey"   value="${content.pageKey}"/>
      <input type="hidden" name="pageTitle" value="${content.pageTitle}"/>
      <textarea id="contentHtml" name="contentHtml" style="width:100%"><c:out value="${content.contentHtml}" escapeXml="false"/></textarea>
      <div class="mt-3 d-flex gap-2">
        <button type="submit" class="btn btn-primary">저장</button>
        <c:if test="${not empty previewUrl}">
          <a href="${ctx}${previewUrl}" target="_blank" class="btn btn-outline-secondary">
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
