<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script>
		function adminSide_hide(){
			$("#adminSide").removeClass("adminSide_openWidth");
			$("#adminSide").addClass("adminSide_closeWidth");
			$("#adminSide_logoDiv").css("display", "none");
			$("#adminSide_symlink").css("display", "none");
			$(".adminSide_menuText").css("display", "none");
			$(".adminSide_openBtn").css("display", "block");
			
			$.ajax({
				url: "adminSidebar.toggle",
				data: "isSideOpen=sideOff",
				type: "POST",
				success: function(data){
					
				},
				error: function(){
					
				}
			});
			
		}
		function adminSide_show(){
			$("#adminSide").removeClass("adminSide_closeWidth");
			$("#adminSide").addClass("adminSide_openWidth");
			$("#adminSide_logoDiv").css("display", "block");
			$("#adminSide_symlink").css("display", "block");
			$(".adminSide_menuText").css("display", "inline-block");
			$(".adminSide_openBtn").css("display", "none");
			
			$.ajax({
				url: "adminSidebar.toggle",
				data: "isSideOpen=sideOn",
				type: "POST",
				success: function(data){
					
				},
				error: function(){
					
				}
			});
		}
	</script>
</head>
<body>
	<c:set var="isSideOpen" value="${isOpen}" />

	<div id="adminSide" class="adminSide_container <c:if test="${isSideOpen eq 'sideOff'}">adminSide_container_hide</c:if>">
		<!-- LOGO -->
		<div id="adminSide_logoDiv" class="adminSide_logoDiv <c:if test="${isSideOpen eq 'sideOff'}">adminSide_logoDiv_hide</c:if>">
	 		<img src="img/p1_top_logo.png" class="adminSide_logo" onclick="location.href='admin'">
	 		<span class="adminSide_closeBtn" onclick="adminSide_hide()">
	 			<a><i class="fas fa-angle-double-left fa-2x"></i></a>
	 		</span>
	 	</div>
	 	
	 	<!-- 관리자 사이트 바로가기 -->
	 	<div id="adminSide_symlink" class="adminSide_symlink <c:if test="${isSideOpen eq 'sideOff'}">adminSide_symlnk_hide</c:if>">
	 		<a href="/omeran">Omeranmall.com</a>
	 	</div>
	 	
	 	<!-- 사이드바 열기버튼 -->
	 	<a onclick="adminSide_show()" class="adminSide_menus adminSide_openBtn <c:if test="${isSideOpen eq 'sideOff'}">adminSide_openBtn_hide</c:if>">
	 		<i class="fas fa-angle-double-right fa-fw adminSide_menu_icons"></i>
	 	</a>
	 	
	 	<!-- 메인(대시보드) -->
	 	<a href="./adminDashboard" class="
		 	<% if((String)session.getAttribute("adminSideState") == "대시보드"){ %>  
		 		adminSide_menuActive
		 	<% }else{ %>
		 		adminSide_menus
		 	<% } %>">
		 	<i class="fas fa-th-large fa-fw adminSide_menu_icons"></i>
		 	<div class="adminSide_menuText <c:if test="${isSideOpen eq 'sideOff'}">adminSide_menuText_hide</c:if>">대시보드</div>
		 </a>

	 	<!-- 상품관리 -->
	 	<a href="./adminProduct" class="
		 	<% if((String)session.getAttribute("adminSideState") == "상품관리"){ %>  
		 		adminSide_menuActive
		 	<% }else{ %>
		 		adminSide_menus
		 	<% } %>">
		 	<i class="fas fa-desktop fa-fw adminSide_menu_icons"></i>
		 	<div class="adminSide_menuText <c:if test="${isSideOpen eq 'sideOff'}">adminSide_menuText_hide</c:if>">상품관리</div>
		 </a>

	 	<!-- 주문관리 -->
	 	<a href="./adminOrder" class="
		 	<% if((String)session.getAttribute("adminSideState") == "주문관리"){ %>  
		 		adminSide_menuActive
		 	<% }else{ %>
		 		adminSide_menus
		 	<% } %>">
		 	<i class="fas fa-truck-loading fa-fw adminSide_menu_icons"></i>
		 	<div class="adminSide_menuText <c:if test="${isSideOpen eq 'sideOff'}">adminSide_menuText_hide</c:if>">주문관리</div>
		 </a>

	 	<!-- 배송관리 -->
	 	<a href="./adminDelivery" class="
		 	<% if((String)session.getAttribute("adminSideState") == "배송관리"){ %>  
		 		adminSide_menuActive
		 	<% }else{ %>
		 		adminSide_menus
		 	<% } %>">
		 	<i class="fas fa-shipping-fast fa-fw adminSide_menu_icons"></i>
		 	<div class="adminSide_menuText <c:if test="${isSideOpen eq 'sideOff'}">adminSide_menuText_hide</c:if>">배송관리</div>
		</a>

	 	<!-- 고객관리 -->
	 	<a href="./adminConsumer" class="
		 	<% if((String)session.getAttribute("adminSideState") == "고객관리"){ %>  
		 		adminSide_menuActive
		 	<% }else{ %>
		 		adminSide_menus
		 	<% } %>">
			<i class="fas fa-user-cog fa-fw adminSide_menu_icons"></i>
			<div class="adminSide_menuText <c:if test="${isSideOpen eq 'sideOff'}">adminSide_menuText_hide</c:if>">고객관리</div>
		</a>
	 	
	 	<!-- 배송자관리 -->
	 	<a href="./adminDeliveryman" class="
		 	<% if((String)session.getAttribute("adminSideState") == "배송자관리"){ %>  
		 		adminSide_menuActive
		 	<% }else{ %>
		 		adminSide_menus
		 	<% } %>">
		 	<i class="fas fa-people-carry fa-fw adminSide_menu_icons"></i>
		 	<div class="adminSide_menuText <c:if test="${isSideOpen eq 'sideOff'}">adminSide_menuText_hide</c:if>">배송자관리</div>
		 	</a>
	 	
	 	<!-- 사이트관리 -->
	 	<a href="./adminSite" class="
		 	<% if((String)session.getAttribute("adminSideState") == "사이트관리"){ %>  
		 		adminSide_menuActive
		 	<% }else{ %>
		 		adminSide_menus
		 	<% } %>">
		 	<i class="fas fa-cogs fa-fw adminSide_menu_icons"></i>
		 	<div class="adminSide_menuText <c:if test="${isSideOpen eq 'sideOff'}">adminSide_menuText_hide</c:if>">사이트관리</div>
		 </a>
	 </div>
</body>
</html>