<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
  <title><sitemesh:write property="title"/> | SGHCMS Admin</title>
  <link rel="stylesheet" href="${ctx}/coreui/vendors/simplebar/css/simplebar.css">
  <link rel="stylesheet" href="${ctx}/coreui/css/style.css">
  <script src="${ctx}/coreui/js/config.js"></script>
  <script src="${ctx}/coreui/js/color-modes.js"></script>
  <sitemesh:write property="head"/>
</head>
<body>
  <div class="sidebar sidebar-dark sidebar-fixed border-end" id="sidebar">
    <div class="sidebar-header border-bottom">
      <div class="sidebar-brand me-auto">
        <span class="sidebar-brand-full fw-bold fs-5">SGHCMS</span>
        <span class="sidebar-brand-narrow fw-bold">S</span>
      </div>
      <button class="btn-close d-lg-none" type="button" data-coreui-theme="dark" aria-label="Close"
        onclick="coreui.Sidebar.getInstance(document.querySelector('#sidebar')).toggle()"></button>
    </div>
    <%@ include file="sidebar.jsp" %>
    <div class="sidebar-footer border-top d-none d-md-flex">
      <button class="sidebar-toggler" type="button" data-coreui-toggle="unfoldable"></button>
    </div>
  </div>

  <div class="wrapper d-flex flex-column min-vh-100">
    <%@ include file="header.jsp" %>
    <div class="body flex-grow-1">
      <div class="container-lg px-4">
        <sitemesh:write property="body"/>
      </div>
    </div>
    <%@ include file="footer.jsp" %>
  </div>

  <script src="${ctx}/coreui/vendors/@coreui/coreui/js/coreui.bundle.min.js"></script>
  <script src="${ctx}/coreui/vendors/simplebar/js/simplebar.min.js"></script>
  <script>
    const header = document.querySelector("header.header");
    document.addEventListener("scroll", () => {
      if (header) {
        header.classList.toggle("shadow-sm", document.documentElement.scrollTop > 0);
      }
    });
  </script>
</body>
</html>
