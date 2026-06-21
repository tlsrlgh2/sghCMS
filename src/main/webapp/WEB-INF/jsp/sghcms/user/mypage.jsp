<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"    uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="tab" value="${not empty activeTab ? activeTab : 'basic'}"/>

<head>
  <title>개인정보 수정 | SGH 청년공간</title>
  <link href="${ctx}/css/user/mypage.css" rel="stylesheet">
</head>

<body>
<section class="mypage-section">
  <div class="container">
    <div class="mypage-card">
      <div class="mypage-card-title">개인정보 수정</div>

      <%-- 성공/오류 알림 --%>
      <c:if test="${not empty basicSuccess}">
        <div class="mypage-alert success">${basicSuccess}</div>
      </c:if>
      <c:if test="${not empty passwordSuccess}">
        <div class="mypage-alert success">${passwordSuccess}</div>
      </c:if>

      <%-- 탭 --%>
      <div class="mypage-tabs">
        <button type="button" class="mypage-tab-btn ${tab == 'basic' ? 'active' : ''}"
                onclick="switchTab('basic')">기본 정보</button>
        <button type="button" class="mypage-tab-btn ${tab == 'password' ? 'active' : ''}"
                onclick="switchTab('password')">비밀번호 변경</button>
      </div>

      <%-- 기본 정보 탭 --%>
      <div id="tab-basic" class="mypage-tab-pane ${tab == 'basic' ? 'active' : ''}">
        <form:form modelAttribute="mberInfo" action="${ctx}/user/mypageBasicUpdate.do" method="post">

          <div class="join-field">
            <label>아이디</label>
            <input type="text" value="${mberInfo.mberId}" readonly
                   style="background:#f0f0f8;color:#999;cursor:not-allowed;">
          </div>

          <div class="join-field">
            <label for="mberNm">이름 <span class="req">*</span></label>
            <form:input path="mberNm" id="mberNm" maxlength="50" placeholder="이름을 입력해 주세요"/>
            <div id="err-mberNm" class="field-feedback" aria-live="polite"></div>
            <form:errors path="mberNm" element="ul" cssClass="field-error-list" itemElement="li"/>
          </div>

          <hr class="join-divider">

          <div class="join-field">
            <label for="mberEmailAdres">이메일 <span class="req">*</span></label>
            <form:input path="mberEmailAdres" id="mberEmailAdres" maxlength="50" placeholder="example@email.com"/>
            <div id="err-email" class="field-feedback" aria-live="polite"></div>
            <form:errors path="mberEmailAdres" element="ul" cssClass="field-error-list" itemElement="li"/>
          </div>

          <div class="join-field">
            <label for="moblphonNo">휴대폰 번호</label>
            <form:input path="moblphonNo" id="moblphonNo" maxlength="15" placeholder="'-' 없이 숫자만 입력"/>
            <div id="err-phone" class="field-feedback" aria-live="polite"></div>
            <form:errors path="moblphonNo" element="ul" cssClass="field-error-list" itemElement="li"/>
          </div>

          <button type="submit" class="btn-mypage-submit" onclick="return validateBasic()">정보 저장</button>
        </form:form>
      </div>

      <%-- 비밀번호 변경 탭 --%>
      <div id="tab-password" class="mypage-tab-pane ${tab == 'password' ? 'active' : ''}">
        <form:form modelAttribute="passwordChangeVO" action="${ctx}/user/mypagePasswordUpdate.do" method="post">

          <div class="join-field">
            <label for="currentPassword">현재 비밀번호 <span class="req">*</span></label>
            <form:password path="currentPassword" id="currentPassword" maxlength="20"
                           placeholder="현재 비밀번호를 입력해 주세요"/>
            <c:if test="${not empty currentPwError}">
              <div class="field-feedback error">${currentPwError}</div>
            </c:if>
            <form:errors path="currentPassword" element="ul" cssClass="field-error-list" itemElement="li"/>
          </div>

          <hr class="join-divider">

          <div class="join-field">
            <label for="newPassword">새 비밀번호 <span class="req">*</span></label>
            <form:password path="newPassword" id="newPassword" maxlength="20" placeholder="8~20자"/>
            <div id="err-newPw" class="field-feedback" aria-live="polite"></div>
            <form:errors path="newPassword" element="ul" cssClass="field-error-list" itemElement="li"/>
          </div>

          <div class="join-field">
            <label for="newPassword2">새 비밀번호 확인 <span class="req">*</span></label>
            <form:password path="newPassword2" id="newPassword2" maxlength="20"
                           placeholder="새 비밀번호를 다시 입력해 주세요"/>
            <div id="err-newPw2" class="field-feedback" aria-live="polite"></div>
            <form:errors path="newPassword2" element="ul" cssClass="field-error-list" itemElement="li"/>
          </div>

          <button type="submit" class="btn-mypage-submit" onclick="return validatePassword()">비밀번호 변경</button>
        </form:form>
      </div>

    </div>
  </div>
</section>

<script>
function switchTab(name) {
  document.querySelectorAll('.mypage-tab-btn').forEach(function(btn) {
    btn.classList.remove('active');
  });
  document.querySelectorAll('.mypage-tab-pane').forEach(function(pane) {
    pane.classList.remove('active');
  });
  document.querySelector('.mypage-tab-btn[onclick="switchTab(\'' + name + '\')"]').classList.add('active');
  document.getElementById('tab-' + name).classList.add('active');
}

/* ── 새 비밀번호 확인 실시간 피드백 ── */
var newPwEl = document.getElementById('newPassword');
var newPw2El = document.getElementById('newPassword2');
if (newPw2El) {
  newPw2El.addEventListener('input', function() {
    var fb = document.getElementById('err-newPw2');
    var pw = newPwEl.value;
    if (!this.value) { clearFb(fb); return; }
    if (pw === this.value) showOk(fb, '비밀번호가 일치합니다.');
    else                   showErr(fb, '비밀번호가 일치하지 않습니다.');
  });
}

function validateBasic() {
  var nm    = document.getElementById('mberNm').value.trim();
  var email = document.getElementById('mberEmailAdres').value.trim();
  var phone = document.getElementById('moblphonNo').value.trim();
  var ok = true;

  if (!nm) {
    showErr(document.getElementById('err-mberNm'), '이름을 입력해 주세요.');
    ok = false;
  }
  if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    showErr(document.getElementById('err-email'), '올바른 이메일 형식으로 입력해 주세요.');
    ok = false;
  }
  if (phone && !/^\d{10,11}$/.test(phone)) {
    showErr(document.getElementById('err-phone'), '10~11자리 숫자만 입력해 주세요.');
    ok = false;
  }
  return ok;
}

function validatePassword() {
  var cur  = document.getElementById('currentPassword').value;
  var pw   = document.getElementById('newPassword').value;
  var pw2  = document.getElementById('newPassword2').value;
  var ok   = true;

  if (!cur) ok = false;

  if (!pw || pw.length < 8) {
    showErr(document.getElementById('err-newPw'), '비밀번호는 8자 이상이어야 합니다.');
    ok = false;
  }
  if (!pw2 || pw !== pw2) {
    showErr(document.getElementById('err-newPw2'), '새 비밀번호가 일치하지 않습니다.');
    ok = false;
  }
  return ok;
}

function showErr(el, msg) { if(el){ el.textContent = msg; el.className = 'field-feedback error'; } }
function showOk(el, msg)  { if(el){ el.textContent = msg; el.className = 'field-feedback ok'; } }
function clearFb(el)      { if(el){ el.textContent = ''; el.className = 'field-feedback'; } }
</script>
</body>
