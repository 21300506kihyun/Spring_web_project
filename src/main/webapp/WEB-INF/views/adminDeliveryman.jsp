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
		  		<div class="adminProduct_cardContainer adminProduct_searchContainer">
		  			<form onsubmit="admin_search(${pagination.curPage}, 'adminDeliverymanContent'); return false;">
			  			<input id="admin_searchInput" class="adminProduct_searchInput" type="text" placeholder="배송자 이름을 검색해주세요."
			  				autocomplete="off" spellcheck="false">
		  				<input class="adminProduct_searchSubmit" type="submit" value="">
		  			</form>
				</div>
				<div id="adminProduct_content" class="adminProduct_content adminProduct_contentShow">
	  				<jsp:include page="./adminDeliverymanContent.jsp"></jsp:include>
	  			</div>
		  	</div>
		 </div>
	</div>
</body>
</html>