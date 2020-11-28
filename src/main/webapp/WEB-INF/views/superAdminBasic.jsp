<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="Omeran: Super adminPage" content="오메란 몰의 플랫폼 관리 메뉴입니다.">
	<title>Omeranmall: Super Admin</title>
	<%@ include file="./adminHeader.jsp" %>
</head>
<body>
	<div id="body_wrapper" class="admin_wrapper">
  		<!-- 사이드 바 -->
		<jsp:include page="./superAdminSidebar.jsp"></jsp:include>
		 
		 <!-- right -->
		 <div class="admin_right">
		 	<!-- top -->
		  	<jsp:include page="./superAdminTop.jsp"></jsp:include>
		  	
		  	<!-- content -->
		  	<div class="admin_content">
  				<jsp:include page="./${pageContent}.jsp"></jsp:include>
		  	</div>
		 </div>
	</div>
</body>
</html>