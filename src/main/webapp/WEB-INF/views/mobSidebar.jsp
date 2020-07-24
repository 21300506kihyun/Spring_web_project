<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="./header.jsp" %>
</head>
<body>

	<nav class="w3-sidebar w3-collapse w3-animate-right" style="border-left: 2px solid #f3b646; z-index:3; width:200px; right:0;" id="sidebar"><br>
	  <div class="w3-bar-block" style="margin-top: -25px;">
	  	<div style="display: inline-block; width: 100%; background-color: #f3b646;">
	  	  <span style="display: inline-block;" onclick="closeSidebar()" class="w3-left w3-xlarge w3-padding" title="close menu"><i class="fa fa-remove"></i></span>
	  	</div>
	  	<div style="margin: 2px; padding: 1em; text-align: center;">
	  	  <%if(session.getAttribute("userName") != null){ %>
	  	  	<a href="#mypage"><% out.println(session.getAttribute("userName")); %>님 환영합니다.</a>
	  	  <% }else{ %>
	  	  	<a href="#login" class="popup-btn" style="padding: 0.5em; border: 1px solid #bbb;" onclick="closeSidebar();">로그인하기</a>
	  	  <% } %>
	  		<hr>
	  		
	  	</div>
	  	<div style="padding: 0.5em; text-align: center;" class="w3-bar-block;">
	  	  <a href="faq" class="w3-button w3-padding" style="width: 100%; border: 1px solid #bbb; margin-bottom: 1em;" onclick="closeSidebar();">FAQ</a>
	  	  <a href="#form-mail-popup" class="w3-button w3-padding popup-btn" style="width: 100%; border: 1px solid #bbb; margin-bottom: 1em;" onclick="closeSidebar();">회원가입</a>
	  	  <a href="#form-mail-popup" class="w3-button w3-padding popup-btn" style="width: 100%; border: 1px solid #bbb; margin-bottom: 1em;" onclick="closeSidebar();">리셀러 회원신청</a>
	  	  <%if(session.getAttribute("userName") != null){ %>
	  	  	<a onclick="moveAjax('logout.do')" class="w3-button w3-padding" style="width: 100%; border: 1px solid #bbb; margin-bottom: 1em;" onclick="closeSidebar();">로그아웃</a>
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