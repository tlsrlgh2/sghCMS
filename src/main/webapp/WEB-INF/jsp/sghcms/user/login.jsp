<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인 | SGH 청년공간</title>
  <link href="${ctx}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="${ctx}/bootstrap/icons/bootstrap-icons.min.css" rel="stylesheet">
  <link href="${ctx}/css/user/login.css" rel="stylesheet">
</head>
<body>

<!-- 상단 바 -->
<div class="login-top-bar">
  <a href="${ctx}/" class="login-logo-link">
    <span class="login-logo-symbol" aria-hidden="true">
      <span></span><span></span><span></span>
    </span>
    <span class="login-logo-text">
      <strong>SGH 청년공간</strong>
      <small>YOUTH COMMUNITY SPACE</small>
    </span>
  </a>
</div>

<!-- 본문 -->
<div class="login-body">
  <div class="login-card">

    <div class="login-card-header">
      <div class="login-card-icon">
        <i class="bi bi-person-fill"></i>
      </div>
      <div class="login-card-title">로그인</div>
      <div class="login-card-desc">SGH 청년공간 회원 서비스를 이용하세요</div>
    </div>

    <c:if test="${not empty joinSuccess}">
      <div class="login-success">
        <i class="bi bi-check-circle-fill"></i>
        회원가입이 완료되었습니다. 로그인해 주세요.
      </div>
    </c:if>

    <c:if test="${not empty loginError}">
      <div class="login-error">
        <i class="bi bi-exclamation-circle-fill"></i>
        <c:out value="${loginError}"/>
      </div>
    </c:if>

    <form id="userLoginForm" action="${ctx}/user/loginAction.do" method="post"
          onsubmit="return validateUserLogin()">

      <div class="login-field">
        <label for="userId">아이디</label>
        <div class="input-wrap">
          <i class="bi bi-person"></i>
          <input type="text" id="userId" name="id" maxlength="20"
                 placeholder="아이디를 입력하세요" autocomplete="username">
        </div>
      </div>

      <div class="login-field">
        <label for="userPw">비밀번호</label>
        <div class="input-wrap">
          <i class="bi bi-lock"></i>
          <input type="password" id="userPw" name="password" maxlength="20"
                 placeholder="비밀번호를 입력하세요" autocomplete="current-password">
        </div>
      </div>

      <button type="submit" class="btn-user-login">로그인</button>
    </form>

    <div class="login-links">
      <a href="${ctx}/user/join.do">회원가입</a>
      <span>|</span>
      <a href="${ctx}/user/findAccount.do">아이디 / 비밀번호 찾기</a>
    </div>

    <div class="login-footer-note">
      아직 회원이 아니신가요?
      <a href="${ctx}/user/join.do">지금 가입하기</a>
    </div>

  </div>
</div>

<script>
function validateUserLogin() {
  var id = document.getElementById('userId').value.trim();
  var pw = document.getElementById('userPw').value;
  if (!id) { alert('아이디를 입력하세요.'); return false; }
  if (!pw)  { alert('비밀번호를 입력하세요.'); return false; }
  return true;
}
</script>

</body>
</html>
