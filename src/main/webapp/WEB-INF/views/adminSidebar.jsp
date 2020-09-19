<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		}
		function adminSide_show(){
			$("#adminSide").removeClass("adminSide_closeWidth");
			$("#adminSide").addClass("adminSide_openWidth");
			$("#adminSide_logoDiv").css("display", "block");
			$("#adminSide_symlink").css("display", "block");
			$(".adminSide_menuText").css("display", "inline-block");
			$(".adminSide_openBtn").css("display", "none");
		}
	</script>
</head>
<body>
	<div id="adminSide" class="adminSide_container">
		<!-- LOGO -->
		<div id="adminSide_logoDiv" class="adminSide_logoDiv">
	 		<img src="img/p1_top_logo.png" class="adminSide_logo" onclick="location.href='admin'">
	 		<span class="adminSide_closeBtn" onclick="adminSide_hide()">
	 			<a href="#close"><i class="fas fa-angle-double-left fa-2x"></i></a>
	 		</span>
	 	</div>
	 	
	 	<!-- 관리자 사이트 바로가기 -->
	 	<div id="adminSide_symlink" class="adminSide_symlink">
	 		<a href="/omeran">Omeranmall.com</a>
	 	</div>
	 	
	 	<!-- 사이드바 열기버튼 -->
	 	<a onclick="adminSide_show()" class="adminSide_menus adminSide_openBtn"><i class="fas fa-angle-double-right fa-fw adminSide_menu_icons"></i></a>
	 	
	 	<!-- 메인(대시보드) -->
	 	<a href="#dashboard" class="adminSide_menuActive"><i class="fas fa-th-large fa-fw adminSide_menu_icons"></i><div class="adminSide_menuText">대시보드</div></a>
	 	
	 	<!-- 상품관리 -->
	 	<a href="#product" class="adminSide_menus"><i class="fas fa-desktop fa-fw adminSide_menu_icons"></i><div class="adminSide_menuText">상품관리</div></a>
	 	
	 	<!-- 주문관리 -->
	 	<a href="#order" class="adminSide_menus"><i class="fas fa-truck-loading fa-fw adminSide_menu_icons"></i><div class="adminSide_menuText">주문관리</div></a>
	 	
	 	<!-- 배송관리 -->
	 	<a href="#delivery" class="adminSide_menus"><i class="fas fa-shipping-fast fa-fw adminSide_menu_icons"></i><div class="adminSide_menuText">배송관리</div></a>
	 	
	 	<!-- 고객관리 -->
	 	<a href="#consumer" class="adminSide_menus"><i class="fas fa-user-cog fa-fw adminSide_menu_icons"></i><div class="adminSide_menuText">고객관리</div></a>
	 	
	 	<!-- 배송자관리 -->
	 	<a href="#deliveryman" class="adminSide_menus"><i class="fas fa-people-carry fa-fw adminSide_menu_icons"></i><div class="adminSide_menuText">배송자관리</div></a>
	 	
	 	<!-- 사이트관리 -->
	 	<a href="#site" class="adminSide_menus"><i class="fas fa-cogs fa-fw adminSide_menu_icons"></i><div class="adminSide_menuText">사이트관리</div></a>
	 </div>
</body>
</html>