<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <title>사용자 메뉴관리</title>
</head>
<body>

<div class="d-flex justify-content-between align-items-center mb-3">
  <h4 class="fw-bold mb-0">사용자 메뉴관리</h4>
  <span class="text-muted small">사용자(프론트) 페이지 메뉴를 등록하고 콘텐츠/게시판과 연결합니다.</span>
</div>

<c:if test="${not empty message}">
  <div class="alert alert-${empty messageType ? 'info' : messageType} alert-dismissible fade show" role="alert">
    <c:out value="${message}"/>
    <button type="button" class="btn-close" data-coreui-dismiss="alert" data-bs-dismiss="alert"></button>
  </div>
</c:if>

<div class="row g-3">
  <!-- 좌측: 메뉴 목록 -->
  <div class="col-lg-7">
    <div class="card">
      <div class="card-header fw-semibold">등록된 메뉴</div>
      <div class="card-body p-0">
        <table class="table table-hover table-sm mb-0 align-middle">
          <thead class="table-light">
            <tr>
              <th style="width:60px">순서</th>
              <th>메뉴 이름</th>
              <th style="width:90px">유형</th>
              <th>URL / 연결</th>
              <th style="width:60px">노출</th>
              <th style="width:110px">관리</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="m" items="${menuList}">
              <tr>
                <td>${m.sortOrdr}</td>
                <td>
                  <c:if test="${m.upperId ne 0}"><span class="text-muted">└ </span></c:if>
                  <c:out value="${m.menuNm}"/>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${m.menuType eq 'FOLDER'}"><span class="badge bg-secondary">폴더</span></c:when>
                    <c:when test="${m.menuType eq 'CONTENT'}"><span class="badge bg-primary">콘텐츠</span></c:when>
                    <c:when test="${m.menuType eq 'BOARD'}"><span class="badge bg-info">게시판</span></c:when>
                  </c:choose>
                </td>
                <td class="small">
                  <c:if test="${not empty m.urlPath}">
                    <code>/user/page/<c:out value="${m.urlPath}"/>.do</code><br>
                  </c:if>
                  <c:choose>
                    <c:when test="${m.menuType eq 'CONTENT'}">
                      <span class="text-muted">콘텐츠 본문 (편집 가능)</span>
                    </c:when>
                    <c:when test="${m.menuType eq 'BOARD' and empty m.linkedKey}">
                      <span class="text-warning-emphasis">게시판 미연결</span>
                    </c:when>
                    <c:when test="${m.menuType eq 'BOARD'}">
                      <span class="text-muted">게시판 → <c:out value="${m.linkedKey}"/></span>
                    </c:when>
                  </c:choose>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${m.useAt eq 'Y'}"><span class="badge bg-success">노출</span></c:when>
                    <c:otherwise><span class="badge bg-light text-dark">숨김</span></c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <c:set var="delMsg" value="이 메뉴를 삭제하시겠습니까?"/>
                  <c:if test="${m.menuType eq 'CONTENT'}">
                    <c:set var="delMsg" value="메뉴와 연결된 콘텐츠가 함께 삭제됩니다. 계속하시겠습니까?"/>
                    <a href="${ctx}/admin/content/userMenu/contentEdit.do?menuId=${m.menuId}"
                       class="btn btn-sm btn-primary">콘텐츠 편집</a>
                  </c:if>
                  <a href="${ctx}/admin/content/userMenu/list.do?editId=${m.menuId}"
                     class="btn btn-sm btn-outline-primary">수정</a>
                  <form method="post" action="${ctx}/admin/content/userMenu/delete.do"
                        class="d-inline" onsubmit="return confirm('${delMsg}');">
                    <input type="hidden" name="menuId" value="${m.menuId}"/>
                    <button type="submit" class="btn btn-sm btn-outline-danger">삭제</button>
                  </form>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty menuList}">
              <tr><td colspan="6" class="text-center text-muted py-4">등록된 메뉴가 없습니다. 우측에서 새 메뉴를 추가하세요.</td></tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- 우측: 등록/수정 폼 -->
  <div class="col-lg-5">
    <div class="card">
      <div class="card-header fw-semibold">
        <c:choose>
          <c:when test="${not empty editMenu}">메뉴 수정</c:when>
          <c:otherwise>새 메뉴 추가</c:otherwise>
        </c:choose>
      </div>
      <div class="card-body">
        <form method="post" action="${ctx}/admin/content/userMenu/save.do">
          <c:if test="${not empty editMenu}">
            <input type="hidden" name="menuId" value="${editMenu.menuId}"/>
          </c:if>

          <div class="mb-3">
            <label class="form-label">메뉴 이름 <span class="text-danger">*</span></label>
            <input type="text" name="menuNm" class="form-control" maxlength="50" required
                   value="<c:out value='${editMenu.menuNm}'/>">
          </div>

          <div class="mb-3">
            <label class="form-label">메뉴 유형 <span class="text-danger">*</span></label>
            <select name="menuType" id="menuType" class="form-select" required onchange="toggleType()">
              <option value="FOLDER"  ${editMenu.menuType eq 'FOLDER'  ? 'selected' : ''}>폴더 (하위 메뉴 그룹)</option>
              <option value="CONTENT" ${editMenu.menuType eq 'CONTENT' ? 'selected' : ''}>콘텐츠 페이지</option>
              <option value="BOARD"   ${editMenu.menuType eq 'BOARD'   ? 'selected' : ''}>게시판</option>
            </select>
          </div>

          <div class="mb-3">
            <label class="form-label">상위 메뉴</label>
            <select name="upperId" class="form-select">
              <option value="0">(최상위 메뉴)</option>
              <c:forEach var="m" items="${menuList}">
                <c:if test="${empty editMenu or m.menuId ne editMenu.menuId}">
                  <option value="${m.menuId}" ${editMenu.upperId eq m.menuId ? 'selected' : ''}>
                    <c:choose>
                      <c:when test="${m.menuType eq 'FOLDER'}">[폴더] </c:when>
                      <c:when test="${m.menuType eq 'CONTENT'}">[콘텐츠] </c:when>
                      <c:when test="${m.menuType eq 'BOARD'}">[게시판] </c:when>
                    </c:choose>
                    <c:out value="${m.menuNm}"/>
                  </option>
                </c:if>
              </c:forEach>
            </select>
            <div class="form-text">
              상위 메뉴를 선택하면 그 메뉴의 <strong>하위(드롭다운) 메뉴</strong>가 됩니다.
              여러 메뉴를 묶기만 할 그룹은 <strong>폴더</strong> 유형으로 만들어 상위로 지정하세요.
            </div>
          </div>

          <div class="mb-3 type-dependent" data-type="CONTENT BOARD">
            <label class="form-label">URL 경로 <span class="text-danger">*</span></label>
            <div class="input-group">
              <span class="input-group-text">/user/page/</span>
              <input type="text" name="urlPath" class="form-control" maxlength="50"
                     pattern="[a-z0-9][a-z0-9\-]*" placeholder="policy"
                     value="<c:out value='${editMenu.urlPath}'/>">
              <span class="input-group-text">.do</span>
            </div>
            <div class="form-text">영소문자·숫자·하이픈만 사용. 예: <code>policy</code>, <code>youth-news</code></div>
          </div>

          <div class="mb-3 type-dependent" data-type="CONTENT">
            <div class="alert alert-light border small mb-0">
              <i class="bi bi-info-circle"></i>
              콘텐츠 본문은 <strong>저장 후 목록의 [콘텐츠 편집]</strong> 버튼에서 작성합니다.
              별도의 페이지 키를 지정할 필요가 없습니다(메뉴에 자동 연결).
            </div>
          </div>

          <div class="mb-3 type-dependent" data-type="BOARD">
            <label class="form-label">연결 게시판</label>
            <select name="linkedKeyBoard" id="linkedKeyBoard" class="form-select">
              <option value="">(나중에 연결)</option>
              <c:forEach var="b" items="${boardList}">
                <option value="${b.bbsId}"
                        ${editMenu.menuType eq 'BOARD' and editMenu.linkedKey eq b.bbsId ? 'selected' : ''}>
                  <c:out value="${b.bbsNm}"/> (${b.bbsId})
                </option>
              </c:forEach>
            </select>
            <div class="form-text">게시판 관리에서 만든 게시판을 선택합니다.</div>
          </div>

          <div class="row g-2 mb-3">
            <div class="col-6">
              <label class="form-label">정렬 순서</label>
              <input type="number" name="sortOrdr" class="form-control" min="0" max="9999"
                     value="${empty editMenu ? 0 : editMenu.sortOrdr}">
            </div>
            <div class="col-6">
              <label class="form-label">노출 여부</label>
              <select name="useAt" class="form-select">
                <option value="Y" ${empty editMenu or editMenu.useAt eq 'Y' ? 'selected' : ''}>노출</option>
                <option value="N" ${editMenu.useAt eq 'N' ? 'selected' : ''}>숨김</option>
              </select>
            </div>
          </div>

          <!-- 유형별로 실제 전송될 linkedKey 를 하나로 합쳐 보냄 -->
          <input type="hidden" name="linkedKey" id="linkedKey"
                 value="<c:out value='${editMenu.linkedKey}'/>">

          <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">저장</button>
            <c:if test="${not empty editMenu}">
              <a href="${ctx}/admin/content/userMenu/list.do" class="btn btn-outline-secondary">취소</a>
            </c:if>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
  function toggleType() {
    var type = document.getElementById('menuType').value;
    document.querySelectorAll('.type-dependent').forEach(function (el) {
      var applicable = el.getAttribute('data-type').split(' ');
      el.style.display = applicable.indexOf(type) >= 0 ? '' : 'none';
    });
  }

  // 게시판만 클라이언트에서 linkedKey 를 전달한다.
  // (콘텐츠는 서버가 menu_{id} 자동 부여, 폴더는 없음)
  function syncLinkedKey() {
    var type = document.getElementById('menuType').value;
    var hidden = document.getElementById('linkedKey');
    if (type === 'BOARD') {
      hidden.value = document.getElementById('linkedKeyBoard').value || '';
    } else {
      hidden.value = '';
    }
  }

  document.addEventListener('DOMContentLoaded', function () {
    toggleType();
    var form = document.querySelector('form[action$="/userMenu/save.do"]');
    if (form) {
      form.addEventListener('submit', syncLinkedKey);
    }
  });
</script>
</body>
</html>
