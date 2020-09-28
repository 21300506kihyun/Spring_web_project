<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="Omeran: adminPage" content="오메란 몰의 관리자 페이지입니다.">
  <title>Omeranmall: Admin</title>
  <%@ include file="./adminHeader.jsp" %>
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
		  		<!-- adminDashboard -->
			  	<div class="adminDashboard_card">
					<p class="adminDashboard_cardTitle">Test#1</p>
					<p>Administration Information</p>
					<p>관리자 및 관리 사이트의 정보를 간단히 조회할 수 있습니다.</p>
					<p>넣고 싶은 내용에 대해서 말씀주세요.</p>
				</div>
				
				<div class="adminDashboard_spacer"></div>
				
				<div class="adminDashboard_halfBox">
					<div class="adminDashboard_card adminDashboard_half">
						<p class="adminDashboard_cardTitle">Test#2</p>
						<p>Chart of Statistic<br>
						추후에 사이트 관리에 도움이 될 수 있는 그래프가 들어갈 수 있습니다.</p>
					</div>
					
					<div class="adminDashboard_card adminDashboard_half">
						<p class="adminDashboard_cardTitle">Test#3</p>
						<p>Chart of Statistic<br>
						추후에 사이트 관리에 도움이 될 수 있는 그래프가 들어갈 수 있습니다.</p>
					</div>
				</div>
		  	</div>
		 </div>
	</div>
</body>
</html>