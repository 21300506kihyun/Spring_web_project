<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="Omeran: Super adminPage" content="오메란 몰의 관리자를 관리하는 페이지입니다.">
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
		  		<div class="adminProduct_cardContainer adminProduct_searchContainer">
					<input id="adminProduct_searchInput" class="adminProduct_searchInput" type="text" placeholder="관리 사이트을 검색해주세요"
						autocomplete="off" spellcheck="false" onkeyup="adminProduct_filter()">
					<input class="adminProduct_searchSubmit" type="button" value="" onclick="adminProduct_filter()">
				</div>
		  		<div id="adminProduct_content" class="adminProduct_content adminProduct_contentShow">
	  				<jsp:include page="./superAdminManageContent.jsp"></jsp:include>
	  			</div>
		  	</div>
		 </div>
	</div>
</body>
</html>