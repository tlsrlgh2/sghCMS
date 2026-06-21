<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%
    /* 사용자 로그인 폼에서 실패 시 이 페이지로 forward됨.
       loginType=user 이면 사용자 로그인 페이지로 redirect. */
    String loginType = request.getParameter("loginType");
    Object loginMsg  = request.getAttribute("loginMessage");
    if ("user".equals(loginType) && loginMsg != null) {
        response.sendRedirect(request.getContextPath()
            + "/user/login.do?error=true");
        return;
    }
    if ("user".equals(loginType)) {
        response.sendRedirect(request.getContextPath() + "/user/login.do");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>관리자 로그인 | SGHCMS</title>
  <link rel="stylesheet" href="${ctx}/coreui/css/style.css">
  <link rel="stylesheet" href="${ctx}/css/admin/login.css">
</head>
<body>

<noscript><p style="color:#fff;text-align:center">JavaScript를 활성화해 주세요.</p></noscript>

<div class="admin-login-wrap">

  <div class="admin-login-brand">
    <div class="brand-icon">S</div>
    <div class="brand-title">SGHCMS</div>
    <div class="brand-sub">SGH 청년공간<br>콘텐츠 관리 시스템</div>
    <div class="brand-badge">ADMIN</div>
  </div>

  <div class="admin-login-form-panel">
    <p class="form-heading">관리자 로그인</p>
    <p class="form-desc">업무 담당자 계정으로 로그인하세요.</p>

    <c:if test="${not empty loginMessage}">
      <div class="error-msg"><c:out value="${loginMessage}"/></div>
    </c:if>

    <form name="adminLoginForm" id="adminLoginForm"
          action="${ctx}/uat/uia/actionLogin.do" method="post">
      <input type="hidden" name="userSe" value="USR"/>
      <input type="hidden" name="message" value="<c:out value='${message}'/>"/>

      <div class="form-field">
        <label for="adminId">아이디</label>
        <input type="text" id="adminId" name="id" maxlength="20"
               placeholder="아이디를 입력하세요" autocomplete="username">
      </div>
      <div class="form-field">
        <label for="adminPw">비밀번호</label>
        <input type="password" id="adminPw" name="password" maxlength="20"
               placeholder="비밀번호를 입력하세요" autocomplete="current-password">
      </div>

      <button type="submit" class="btn-admin-login"
              onclick="return validateAdminLogin()">로그인</button>
    </form>
  </div>

</div>

<script>
function validateAdminLogin() {
  var id = document.getElementById('adminId').value.trim();
  var pw = document.getElementById('adminPw').value;
  if (!id) { alert('아이디를 입력하세요.'); return false; }
  if (!pw)  { alert('비밀번호를 입력하세요.'); return false; }
  return true;
}
document.getElementById('adminLoginForm').addEventListener('keydown', function(e){
  if (e.key === 'Enter') { validateAdminLogin() && this.submit(); }
});
</script>

</body>
</html>
