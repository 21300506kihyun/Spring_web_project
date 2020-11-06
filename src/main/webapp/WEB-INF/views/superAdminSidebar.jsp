<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
</head>
<body>
	<c:set var="isSideOpen" value="${isOpen}" />

	<div id="adminSide" class="adminSide_container <c:if test="${isSideOpen eq 'sideOff'}">adminSide_container_hide</c:if>">
		<!-- LOGO -->
		<div id="adminSide_logoDiv" class="adminSide_logoDiv <c:if test="${isSideOpen eq 'sideOff'}">adminSide_logoDiv_hide</c:if>">
	 		<img src="<%= request.getContextPath() %>/img/p1_top_logo.png" class="adminSide_logo" onclick='location.href="<%= request.getContextPath() %>"'>
	 		<span class="adminSide_closeBtn" onclick="adminSide_hide()">
	 			<a><i class="fas fa-angle-double-left fa-2x"></i></a>
	 		</span>
	 	</div>
	 	
	 	<!-- 관리자 사이트 바로가기 -->
	 	<div id="adminSide_symlink" class="adminSide_symlink <c:if test="${isSideOpen eq 'sideOff'}">adminSide_symlnk_hide</c:if>">
	 		<a href="<%= request.getContextPath() %>/">Return To Platform</a>
	 	</div>
	 	
	 	<!-- 사이드바 열기버튼 -->
	 	<a onclick="adminSide_show()" class="adminSide_menus adminSide_openBtn <c:if test="${isSideOpen eq 'sideOff'}">adminSide_openBtn_hide</c:if>">
	 		<i class="fas fa-angle-double-right fa-fw adminSide_menu_icons"></i>
	 	</a>
	 	
	 	<!-- 플랫폼 관리 -->
	 	<a href="./superAdmin" class="
		 	<% if((String)session.getAttribute("adminSideState") == "가입 쇼핑몰 관리"){ %>  
		 		adminSide_menuActive
		 	<% }else{ %>
		 		adminSide_menus
		 	<% } %>">
		 	<i class="fas fa-store fa-fw adminSide_menu_icons"></i>
		 	<div class="adminSide_menuText <c:if test="${isSideOpen eq 'sideOff'}">adminSide_menuText_hide</c:if>">가입 쇼핑몰 관리</div>
		 </a>
	 </div>
</body>
</html>