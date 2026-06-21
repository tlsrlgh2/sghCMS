<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"    uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<head>
  <title>회원가입 | SGH 청년공간</title>
  <link href="${ctx}/css/user/join.css" rel="stylesheet">
</head>

<body>
<section class="join-section">
  <div class="container">
    <div class="join-card">
      <div class="join-card-title">회원가입</div>
      <div class="join-card-desc">SGH 청년공간의 다양한 서비스를 이용하세요.</div>

      <form:form modelAttribute="joinVO" action="${ctx}/user/joinAction.do" method="post" id="joinForm">

        <!-- 아이디 -->
        <div class="join-field">
          <label for="mberId">아이디 <span class="req">*</span></label>
          <div class="input-row">
            <form:input path="mberId" id="mberId" maxlength="20"
                        placeholder="4~20자, 영문·숫자·밑줄(_)"/>
            <button type="button" class="btn-check-id" onclick="checkId()">중복 확인</button>
          </div>
          <div id="idFeedback" class="field-feedback" aria-live="polite"></div>
          <form:errors path="mberId" element="ul" cssClass="field-error-list" itemElement="li"/>
        </div>

        <!-- 이름 -->
        <div class="join-field">
          <label for="mberNm">이름 <span class="req">*</span></label>
          <form:input path="mberNm" id="mberNm" maxlength="50" placeholder="실명을 입력해 주세요"/>
          <div id="err-mberNm" class="field-feedback" aria-live="polite"></div>
          <form:errors path="mberNm" element="ul" cssClass="field-error-list" itemElement="li"/>
        </div>

        <!-- 비밀번호 -->
        <div class="join-field">
          <label for="password">비밀번호 <span class="req">*</span></label>
          <form:password path="password" id="password" maxlength="20" placeholder="8~20자"/>
          <div id="err-password" class="field-feedback" aria-live="polite"></div>
          <form:errors path="password" element="ul" cssClass="field-error-list" itemElement="li"/>
        </div>

        <!-- 비밀번호 확인 -->
        <div class="join-field">
          <label for="password2">비밀번호 확인 <span class="req">*</span></label>
          <form:password path="password2" id="password2" maxlength="20"
                         placeholder="비밀번호를 다시 입력해 주세요"/>
          <div id="pwFeedback" class="field-feedback" aria-live="polite"></div>
          <form:errors path="password2" element="ul" cssClass="field-error-list" itemElement="li"/>
        </div>

        <hr class="join-divider">

        <!-- 이메일 -->
        <div class="join-field">
          <label for="mberEmailAdres">이메일 <span class="req">*</span></label>
          <form:input path="mberEmailAdres" id="mberEmailAdres" maxlength="50"
                      placeholder="example@email.com"/>
          <div id="err-email" class="field-feedback" aria-live="polite"></div>
          <form:errors path="mberEmailAdres" element="ul" cssClass="field-error-list" itemElement="li"/>
        </div>

        <!-- 휴대폰 -->
        <div class="join-field">
          <label for="moblphonNo">휴대폰 번호 <span class="req">*</span></label>
          <form:input path="moblphonNo" id="moblphonNo" maxlength="15"
                      placeholder="'-' 없이 숫자만 입력"/>
          <div id="err-phone" class="field-feedback" aria-live="polite"></div>
          <form:errors path="moblphonNo" element="ul" cssClass="field-error-list" itemElement="li"/>
        </div>

        <button type="submit" class="btn-join-submit" onclick="return beforeSubmit()">가입하기</button>
      </form:form>

      <div class="join-login-link">
        이미 계정이 있으신가요? <a href="${ctx}/user/login.do">로그인</a>
      </div>
    </div>
  </div>
</section>

<script>
var idChecked = ${idAlreadyChecked == true ? 'true' : 'false'};

/* ── 아이디 중복 확인 ── */
function checkId() {
  var id = document.getElementById('mberId').value.trim();
  var fb = document.getElementById('idFeedback');
  if (!id) {
    showErr(fb, '아이디를 먼저 입력해 주세요.');
    return;
  }
  fetch('${ctx}/user/checkId.do?mberId=' + encodeURIComponent(id))
    .then(function(r) { return r.json(); })
    .then(function(exists) {
      if (exists) {
        showErr(fb, '이미 사용 중인 아이디입니다.');
        idChecked = false;
      } else {
        showOk(fb, '사용 가능한 아이디입니다.');
        idChecked = true;
      }
    })
    .catch(function() { showErr(fb, '확인 중 오류가 발생했습니다.'); });
}

document.getElementById('mberId').addEventListener('input', function() {
  idChecked = false;
  clearFb(document.getElementById('idFeedback'));
});

/* ── 비밀번호 확인 실시간 피드백 ── */
document.getElementById('password2').addEventListener('input', function() {
  var pw  = document.getElementById('password').value;
  var pw2 = this.value;
  var fb  = document.getElementById('pwFeedback');
  if (!pw2) { clearFb(fb); return; }
  if (pw === pw2) { showOk(fb, '비밀번호가 일치합니다.'); }
  else            { showErr(fb, '비밀번호가 일치하지 않습니다.'); }
});

/* ── 제출 전 클라이언트 validation ── */
function beforeSubmit() {
  clearAllErrors();

  var id    = document.getElementById('mberId').value.trim();
  var nm    = document.getElementById('mberNm').value.trim();
  var pw    = document.getElementById('password').value;
  var pw2   = document.getElementById('password2').value;
  var email = document.getElementById('mberEmailAdres').value.trim();
  var phone = document.getElementById('moblphonNo').value.trim();

  var ok = true;
  var firstErrEl = null;

  function fail(inputId, feedbackId, msg) {
    showErr(document.getElementById(feedbackId), msg);
    if (!firstErrEl) firstErrEl = document.getElementById(inputId);
    ok = false;
  }

  // 아이디
  if (!id) {
    fail('mberId', 'idFeedback', '아이디를 입력해 주세요.');
    idChecked = false;
  } else if (!idChecked) {
    fail('mberId', 'idFeedback', '아이디 중복 확인을 해 주세요.');
  }

  // 이름
  if (!nm) {
    fail('mberNm', 'err-mberNm', '이름을 입력해 주세요.');
  }

  // 비밀번호
  if (!pw) {
    fail('password', 'err-password', '비밀번호를 입력해 주세요.');
  } else if (pw.length < 8) {
    fail('password', 'err-password', '비밀번호는 8자 이상이어야 합니다.');
  }

  // 비밀번호 확인
  if (!pw2) {
    fail('password2', 'pwFeedback', '비밀번호 확인을 입력해 주세요.');
  } else if (pw && pw !== pw2) {
    fail('password2', 'pwFeedback', '비밀번호가 일치하지 않습니다.');
  }

  // 이메일
  if (!email) {
    fail('mberEmailAdres', 'err-email', '이메일을 입력해 주세요.');
  } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
    fail('mberEmailAdres', 'err-email', '올바른 이메일 형식이 아닙니다.');
  }

  // 휴대폰
  if (!phone) {
    fail('moblphonNo', 'err-phone', '휴대폰 번호를 입력해 주세요.');
  } else if (!/^\d{10,11}$/.test(phone)) {
    fail('moblphonNo', 'err-phone', '10~11자리 숫자만 입력해 주세요.');
  }

  if (firstErrEl) {
    firstErrEl.scrollIntoView({ behavior: 'smooth', block: 'center' });
    firstErrEl.focus();
  }

  return ok;
}

/* ── 유틸 ── */
function showErr(el, msg) { el.textContent = msg; el.className = 'field-feedback error'; }
function showOk(el, msg)  { el.textContent = msg; el.className = 'field-feedback ok'; }
function clearFb(el)      { el.textContent = ''; el.className = 'field-feedback'; }

function clearAllErrors() {
  ['idFeedback','err-mberNm','err-password','pwFeedback','err-email','err-phone']
    .forEach(function(id) { clearFb(document.getElementById(id)); });
}
</script>
</body>
