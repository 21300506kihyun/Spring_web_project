<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

	<nav class="w3-sidebar w3-collapse w3-animate-right mob-nav" style="z-index:3;" id="sidebar"><br>
	  <div class="w3-bar-block mob-nav-container">
	  	<div class="mob-nav-close">
	  	  <span onclick="closeSidebar()" class="mob-nav-closeIcon w3-left w3-xlarge w3-padding" title="close menu"><i class="fa fa-remove"></i></span>
	  	</div>
	  	<div class="mob-nav-first-container">
	  	  <%if(session.getAttribute("userName") != null){ %>
	  	  	<a href="#mypage"><% out.println(session.getAttribute("userName")); %>님 환영합니다.</a>
	  	  <% }else{ %>
	  	  	<a href="#login" class="popup-btn mob-nav-first-content" onclick="closeSidebar();">로그인하기</a>
	  	  <% } %>
	  		<hr>
	  		
	  	</div>
	  	<div class="w3-bar-block mob-nav-second-container">
	  	  <a href="faq" class="w3-button w3-padding mob-nav-second-content" onclick="closeSidebar();">FAQ</a>
	  	  <a href="#form-mail-popup" class="w3-button w3-padding mob-nav-second-content" onclick="closeSidebar();">회원가입</a>
	  	  <a href="#form-mail-popup" class="w3-button w3-padding mob-nav-second-content" onclick="closeSidebar();">리셀러 회원신청</a>
	  	  <%if(session.getAttribute("userName") != null){ %>
	  	  	<a onclick="moveAjax('logout.do')" class="w3-button w3-padding mob-nav-second-content" onclick="closeSidebar();">로그아웃</a>
	  	  <% }%>
	  	</div>
	  </div>
	  <!-- <hr>
	  <div class="w3-panel">
	    
	  </div> -->
	</nav>
	
	<!-- Overlay effect when opening sidebar on small screens -->
	<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="closeSidebar()" style="cursor:pointer" title="close side menu" id="overlay"></div>
	
</body>
</html>