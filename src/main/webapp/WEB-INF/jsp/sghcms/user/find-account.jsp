<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<head>
  <title>아이디 / 비밀번호 찾기 | SGH 청년공간</title>
  <link href="${ctx}/css/user/find-account.css" rel="stylesheet">
</head>

<body>
<section class="find-section">
  <div class="container">
    <div class="find-card">
      <div class="find-card-title">아이디 / 비밀번호 찾기</div>

      <!-- 탭 버튼 -->
      <div class="find-tabs" role="tablist">
        <button type="button" class="find-tab-btn <c:if test="${mode ne 'pw'}">active</c:if>"
                id="tab-id" role="tab" onclick="switchTab('id')">아이디 찾기</button>
        <button type="button" class="find-tab-btn <c:if test="${mode eq 'pw'}">active</c:if>"
                id="tab-pw" role="tab" onclick="switchTab('pw')">비밀번호 찾기</button>
      </div>

      <!-- ── 아이디 찾기 패널 ── -->
      <div id="panel-id" class="find-tab-panel <c:if test="${mode ne 'pw'}">active</c:if>">

        <c:if test="${mode ne 'pw'}">
          <c:if test="${not empty foundId}">
            <div class="find-result success">
              가입하신 아이디입니다.
              <strong><c:out value="${foundId}"/></strong>
            </div>
          </c:if>
          <c:if test="${not empty errorMsg and mode ne 'pw'}">
            <div class="find-result error"><c:out value="${errorMsg}"/></div>
          </c:if>
        </c:if>

        <form action="${ctx}/user/findId.do" method="post">
          <div class="find-field">
            <label for="mberNm_id">이름</label>
            <input type="text" id="mberNm_id" name="mberNm" maxlength="50"
                   placeholder="가입 시 등록한 이름을 입력하세요" required>
          </div>
          <div class="find-field">
            <label for="mberEmail_id">이메일</label>
            <input type="email" id="mberEmail_id" name="mberEmailAdres" maxlength="50"
                   placeholder="가입 시 등록한 이메일을 입력하세요" required>
          </div>
          <button type="submit" class="btn-find-submit">아이디 찾기</button>
        </form>
      </div>

      <!-- ── 비밀번호 찾기 패널 ── -->
      <div id="panel-pw" class="find-tab-panel <c:if test="${mode eq 'pw'}">active</c:if>">

        <c:if test="${mode eq 'pw'}">
          <c:if test="${pwSuccess}">
            <div class="find-result success">
              임시 비밀번호를 이메일로 발송하였습니다.<br>
              로그인 후 반드시 비밀번호를 변경해 주세요.
            </div>
          </c:if>
          <c:if test="${not empty errorMsg}">
            <div class="find-result error"><c:out value="${errorMsg}"/></div>
          </c:if>
        </c:if>

        <form action="${ctx}/user/findPw.do" method="post">
          <div class="find-field">
            <label for="mberId_pw">아이디</label>
            <input type="text" id="mberId_pw" name="mberId" maxlength="20"
                   placeholder="아이디를 입력하세요" required>
          </div>
          <div class="find-field">
            <label for="mberNm_pw">이름</label>
            <input type="text" id="mberNm_pw" name="mberNm" maxlength="50"
                   placeholder="이름을 입력하세요" required>
          </div>
          <div class="find-field">
            <label for="mberEmail_pw">이메일</label>
            <input type="email" id="mberEmail_pw" name="mberEmailAdres" maxlength="50"
                   placeholder="가입 시 등록한 이메일을 입력하세요" required>
          </div>
          <button type="submit" class="btn-find-submit">임시 비밀번호 발송</button>
        </form>
      </div>

      <div class="find-back-link">
        <a href="${ctx}/user/login.do">&larr; 로그인으로 돌아가기</a>
      </div>
    </div>
  </div>
</section>

<script>
function switchTab(tab) {
  document.getElementById('panel-id').classList.toggle('active', tab === 'id');
  document.getElementById('panel-pw').classList.toggle('active', tab === 'pw');
  document.getElementById('tab-id').classList.toggle('active', tab === 'id');
  document.getElementById('tab-pw').classList.toggle('active', tab === 'pw');
}
</script>
</body>
