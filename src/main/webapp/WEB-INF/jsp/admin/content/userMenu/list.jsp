<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <title>사용자 메뉴관리</title>
  <style>
    /* ── 트리 레이아웃 ── */
    .menu-tree { list-style: none; padding: 0; margin: 0; }
    .menu-tree .menu-tree { padding-left: 1.5rem; border-left: 2px solid #dee2e6; margin-left: 1rem; }
    .menu-node { }
    .menu-row {
      display: flex; align-items: center; gap: 0.5rem;
      padding: 0.45rem 0.75rem; border-radius: 6px; cursor: default;
      transition: background .12s;
    }
    .menu-row:hover { background: #f0f4ff; }
    .menu-row.active-edit { background: #e7f0ff; outline: 2px solid #6ea8fe; }

    /* 접기/펼치기 토글 */
    .toggle-btn {
      width: 1.25rem; height: 1.25rem; flex-shrink: 0;
      display: flex; align-items: center; justify-content: center;
      cursor: pointer; color: #6c757d; user-select: none;
      font-size: .75rem; border-radius: 3px; transition: background .1s;
    }
    .toggle-btn:hover { background: #dee2e6; color: #333; }
    .toggle-btn.leaf { cursor: default; color: transparent; }

    /* 유형 아이콘 */
    .node-icon { font-size: 1rem; flex-shrink: 0; }

    /* 이름 */
    .node-name { font-weight: 500; flex-shrink: 0; max-width: 180px;
      overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }

    /* URL/연결 */
    .node-meta { font-size: .75rem; color: #6c757d;
      overflow: hidden; text-overflow: ellipsis; white-space: nowrap; flex: 1; }

    /* 배지 */
    .node-badges { display: flex; gap: .25rem; flex-shrink: 0; }

    /* 버튼 그룹 */
    .node-actions { display: flex; gap: .25rem; flex-shrink: 0; margin-left: auto; }

    /* 하위 노드 영역 */
    .children-area { display: block; }
    .children-area.collapsed { display: none; }

    /* 빈 트리 */
    .empty-tree {
      text-align: center; padding: 2.5rem 1rem;
      color: #adb5bd; font-size: .9rem;
    }

    /* 구분선 */
    .menu-node + .menu-node { border-top: 1px solid #f0f0f0; }
    .menu-tree .menu-tree .menu-node + .menu-node { border-top: 1px solid #f5f5f5; }
  </style>
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

<%-- JS가 읽을 플랫 데이터 스토어 --%>
<div id="menu-data-store" style="display:none">
  <c:forEach var="m" items="${menuList}">
    <div class="mds"
         data-id="${m.menuId}"
         data-nm='<c:out value="${m.menuNm}"/>'
         data-type="${m.menuType}"
         data-upper="${m.upperId}"
         data-sort="${m.sortOrdr}"
         data-use="${m.useAt}"
         data-url='<c:out value="${m.urlPath}"/>'
         data-key='<c:out value="${m.linkedKey}"/>'></div>
  </c:forEach>
</div>

<div class="row g-3">

  <%-- 좌측: 트리 뷰 --%>
  <div class="col-lg-7">
    <div class="card h-100">
      <div class="card-header d-flex align-items-center justify-content-between fw-semibold">
        <span>메뉴 트리</span>
        <button class="btn btn-sm btn-outline-secondary" id="btnExpandAll" type="button">모두 펼치기</button>
      </div>
      <div class="card-body p-2">
        <div id="tree-root"></div>
      </div>
    </div>
  </div>

  <%-- 우측: 등록/수정 폼 --%>
  <div class="col-lg-5">
    <div class="card">
      <div class="card-header fw-semibold" id="form-card-title">
        <c:choose>
          <c:when test="${not empty editMenu}">메뉴 수정</c:when>
          <c:otherwise>새 메뉴 추가</c:otherwise>
        </c:choose>
      </div>
      <div class="card-body">
        <form method="post" action="${ctx}/admin/content/userMenu/save.do" id="menuForm">
          <c:if test="${not empty editMenu}">
            <input type="hidden" name="menuId" value="${editMenu.menuId}"/>
          </c:if>

          <div class="mb-3">
            <label class="form-label">메뉴 이름 <span class="text-danger">*</span></label>
            <input type="text" name="menuNm" id="f-menuNm" class="form-control" maxlength="50" required
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
            <select name="upperId" id="f-upperId" class="form-select">
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
              <input type="text" name="urlPath" id="f-urlPath" class="form-control" maxlength="50"
                     pattern="[a-z0-9][a-z0-9\-]*" placeholder="policy"
                     value="<c:out value='${editMenu.urlPath}'/>">
              <span class="input-group-text">.do</span>
            </div>
            <div class="form-text">영소문자·숫자·하이픈만 사용. 예: <code>policy</code>, <code>youth-news</code></div>
          </div>

          <div class="mb-3 type-dependent" data-type="CONTENT">
            <div class="alert alert-light border small mb-0">
              콘텐츠 본문은 <strong>트리의 [콘텐츠 편집]</strong> 버튼에서 작성합니다.
              별도의 페이지 키를 지정할 필요가 없습니다.
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
              <input type="number" name="sortOrdr" id="f-sortOrdr" class="form-control" min="0" max="9999"
                     value="${empty editMenu ? 0 : editMenu.sortOrdr}">
            </div>
            <div class="col-6">
              <label class="form-label">노출 여부</label>
              <select name="useAt" id="f-useAt" class="form-select">
                <option value="Y" ${empty editMenu or editMenu.useAt eq 'Y' ? 'selected' : ''}>노출</option>
                <option value="N" ${editMenu.useAt eq 'N' ? 'selected' : ''}>숨김</option>
              </select>
            </div>
          </div>

          <input type="hidden" name="linkedKey" id="linkedKey" value="<c:out value='${editMenu.linkedKey}'/>">

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

</div><%-- /row --%>

<script>
(function () {
  /* ── 1. 데이터 로드 ── */
  const CTX = '${ctx}';
  const EDIT_ID = '${editMenu.menuId}' || null;

  const rawItems = [];
  document.querySelectorAll('#menu-data-store .mds').forEach(el => {
    rawItems.push({
      menuId:   parseInt(el.dataset.id),
      menuNm:   el.dataset.nm,
      menuType: el.dataset.type,
      upperId:  parseInt(el.dataset.upper) || 0,
      sortOrdr: parseInt(el.dataset.sort)  || 0,
      useAt:    el.dataset.use,
      urlPath:  el.dataset.url  || '',
      linkedKey:el.dataset.key  || ''
    });
  });

  /* ── 2. 플랫 → 트리 변환 ── */
  function buildTree(items) {
    const map = {};
    items.forEach(it => { map[it.menuId] = { ...it, children: [] }; });
    const roots = [];
    items.forEach(it => {
      if (it.upperId && map[it.upperId]) {
        map[it.upperId].children.push(map[it.menuId]);
      } else {
        roots.push(map[it.menuId]);
      }
    });
    function sort(nodes) {
      nodes.sort((a, b) => a.sortOrdr - b.sortOrdr || a.menuId - b.menuId);
      nodes.forEach(n => sort(n.children));
    }
    sort(roots);
    return roots;
  }

  /* ── 3. 아이콘 ── */
  const ICONS = {
    FOLDER:  '📁',
    CONTENT: '📄',
    BOARD:   '📋'
  };
  const TYPE_LABELS = { FOLDER:'폴더', CONTENT:'콘텐츠', BOARD:'게시판' };
  const TYPE_COLORS = { FOLDER:'secondary', CONTENT:'primary', BOARD:'info' };

  /* ── 4. 트리 렌더링 ── */
  function renderTree(nodes) {
    if (!nodes.length) {
      return '<div class="empty-tree">등록된 메뉴가 없습니다.<br>오른쪽 폼에서 새 메뉴를 추가하세요.</div>';
    }
    return '<ul class="menu-tree">' + nodes.map(n => renderNode(n)).join('') + '</ul>';
  }

  function renderNode(node) {
    const hasChildren = node.children.length > 0;
    const isEditTarget = EDIT_ID && parseInt(EDIT_ID) === node.menuId;

    // 접기/펼치기 버튼
    const toggleHtml = hasChildren
      ? '<span class="toggle-btn expanded" onclick="toggleNode(this)" title="접기/펼치기">▼</span>'
      : '<span class="toggle-btn leaf">▶</span>';

    // 유형 배지
    const typeColor = TYPE_COLORS[node.menuType] || 'secondary';
    const typeLabel = TYPE_LABELS[node.menuType] || node.menuType;
    const typeBadge = '<span class="badge bg-' + typeColor + '">' + typeLabel + '</span>';

    // 노출 배지
    const useBadge = node.useAt === 'Y'
      ? '<span class="badge bg-success">노출</span>'
      : '<span class="badge bg-light text-dark border">숨김</span>';

    // 메타 정보 (URL / 연결)
    let metaHtml = '';
    if (node.menuType === 'CONTENT' && node.urlPath) {
      metaHtml = '<span class="node-meta">/user/page/' + esc(node.urlPath) + '.do</span>';
    } else if (node.menuType === 'BOARD') {
      metaHtml = node.linkedKey
        ? '<span class="node-meta text-primary-emphasis">→ ' + esc(node.linkedKey) + '</span>'
        : '<span class="node-meta text-warning-emphasis">게시판 미연결</span>';
    } else if (node.menuType === 'FOLDER') {
      metaHtml = '<span class="node-meta text-muted">' + node.children.length + '개 하위</span>';
    }

    // 액션 버튼
    let actions = '';
    if (node.menuType === 'CONTENT') {
      actions += '<a href="' + CTX + '/admin/content/userMenu/contentEdit.do?menuId=' + node.menuId + '"'
               + ' class="btn btn-sm btn-primary" title="콘텐츠 편집">편집</a>';
    }
    actions += '<a href="' + CTX + '/admin/content/userMenu/list.do?editId=' + node.menuId + '"'
             + ' class="btn btn-sm btn-outline-primary" title="수정">수정</a>';

    const delMsg = node.menuType === 'CONTENT'
      ? '메뉴와 연결된 콘텐츠가 함께 삭제됩니다. 계속하시겠습니까?'
      : '이 메뉴를 삭제하시겠습니까?';
    actions += '<form method="post" action="' + CTX + '/admin/content/userMenu/delete.do"'
             + ' class="d-inline" onsubmit="return confirm(\'' + delMsg.replace(/'/g, "\\'") + '\')">'
             + '<input type="hidden" name="menuId" value="' + node.menuId + '"/>'
             + '<button type="submit" class="btn btn-sm btn-outline-danger">삭제</button>'
             + '</form>';

    const rowClass = 'menu-row' + (isEditTarget ? ' active-edit' : '');
    const icon = ICONS[node.menuType] || '📎';

    const childrenHtml = hasChildren
      ? '<div class="children-area">' + renderTree(node.children) + '</div>'
      : '';

    return '<li class="menu-node">'
         + '<div class="' + rowClass + '" data-id="' + node.menuId + '">'
         + toggleHtml
         + '<span class="node-icon">' + icon + '</span>'
         + '<span class="node-name" title="' + esc(node.menuNm) + '">' + esc(node.menuNm) + '</span>'
         + metaHtml
         + '<span class="node-badges">' + typeBadge + useBadge + '</span>'
         + '<span class="node-actions">' + actions + '</span>'
         + '</div>'
         + childrenHtml
         + '</li>';
  }

  /* ── 5. HTML 이스케이프 ── */
  function esc(str) {
    if (!str) return '';
    return str.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;')
              .replace(/"/g,'&quot;').replace(/'/g,'&#39;');
  }

  /* ── 6. 마운트 ── */
  const tree = buildTree(rawItems);
  document.getElementById('tree-root').innerHTML = renderTree(tree);

  /* ── 7. 접기/펼치기 ── */
  window.toggleNode = function(btn) {
    const childArea = btn.closest('.menu-node').querySelector('.children-area');
    if (!childArea) return;
    const collapsed = childArea.classList.toggle('collapsed');
    btn.textContent = collapsed ? '▶' : '▼';
    btn.classList.toggle('expanded', !collapsed);
  };

  /* ── 8. 모두 펼치기/접기 ── */
  let allExpanded = true;
  document.getElementById('btnExpandAll').addEventListener('click', function () {
    allExpanded = !allExpanded;
    document.querySelectorAll('.children-area').forEach(el => {
      el.classList.toggle('collapsed', !allExpanded);
    });
    document.querySelectorAll('.toggle-btn:not(.leaf)').forEach(btn => {
      btn.textContent = allExpanded ? '▼' : '▶';
      btn.classList.toggle('expanded', allExpanded);
    });
    this.textContent = allExpanded ? '모두 접기' : '모두 펼치기';
  });

  /* ── 9. 폼 유형 토글 ── */
  window.toggleType = function () {
    const type = document.getElementById('menuType').value;
    document.querySelectorAll('.type-dependent').forEach(el => {
      const applicable = el.getAttribute('data-type').split(' ');
      el.style.display = applicable.includes(type) ? '' : 'none';
    });
  };

  /* ── 10. linkedKey 동기화 ── */
  function syncLinkedKey() {
    const type = document.getElementById('menuType').value;
    const hidden = document.getElementById('linkedKey');
    hidden.value = (type === 'BOARD')
      ? (document.getElementById('linkedKeyBoard').value || '')
      : '';
  }

  document.addEventListener('DOMContentLoaded', function () {
    toggleType();
    const form = document.getElementById('menuForm');
    if (form) form.addEventListener('submit', syncLinkedKey);
  });

  toggleType(); // 페이지 로드 즉시도 실행

  /* ── 11. 수정 중인 행 스크롤 이동 ── */
  if (EDIT_ID) {
    const activeRow = document.querySelector('.menu-row.active-edit');
    if (activeRow) {
      activeRow.scrollIntoView({ behavior: 'smooth', block: 'center' });
      // 부모 children-area가 접혀 있으면 펼침
      let el = activeRow.parentElement;
      while (el) {
        if (el.classList.contains('children-area') && el.classList.contains('collapsed')) {
          el.classList.remove('collapsed');
          const btn = el.closest('.menu-node')?.previousElementSibling?.querySelector('.toggle-btn');
          if (btn) { btn.textContent = '▼'; btn.classList.add('expanded'); }
        }
        el = el.parentElement;
      }
    }
  }
})();
</script>
</body>
</html>
