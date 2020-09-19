<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="Omeran: adminPage" content="오메란 몰의 관리자 페이지입니다.">
  <title>Omeranmall: Admin</title>
  <%@ include file="./adminHeader.jsp" %>
  <style>
  	.admin_wrapper{
  		display: flex;
  		min-height: 100vh;
  		background-color: #f6f6f6;
  		color: #212121;
  	}
  	.admin_right{
  		float: left;
  		width: 100%;
  	}
  	.admin_content{
  		padding: 2em;
  	}
  </style>
</head>
<body>
  	<div id="body_wrapper" class="admin_wrapper">
  		<!-- 사이드 바 -->
		<jsp:include page="./adminSidebar.jsp"></jsp:include>
		 
		 <!-- right -->
		 <div class="admin_right">
		 	<!-- top -->
		  	<jsp:include page="./adminTop.jsp"></jsp:include>
		  	
		  	<!-- content -->
		  	<div class="admin_content">
			  	<jsp:include page="./adminDashboard.jsp"></jsp:include>
		  	</div>
		 </div>
	</div>
</body>
</html>