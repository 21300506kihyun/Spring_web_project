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
		  	<c:set var="currentTap" value="${currentTap}" />
		  	<div class="admin_content">
		  		<div class="adminProduct_tapContainer">
		  			<a id="adminOrder_tap01" class="adminProduct_tapMenus <c:if test="${currentTap == 1}">on</c:if>" 
		  				onclick="admin_moveTap('adminDelivery_tap', '01')"><span>상품재배중 <div class="adminProduct_menuCnt">${deliveryCnt[0]}</div></span></a>
		  			<a id="adminOrder_tap02" class="adminProduct_tapMenus <c:if test="${currentTap == 2}">on</c:if>" 
		  				onclick="admin_moveTap('adminDelivery_tap', '02')"><span>배송자 선정 <div class="adminProduct_menuCnt">${deliveryCnt[1]}</div></span></a>
		  			<a id="adminOrder_tap03" class="adminProduct_tapMenus <c:if test="${currentTap == 3}">on</c:if>" 
		  				onclick="admin_moveTap('adminDelivery_tap', '03')"><span>배송출발 <div class="adminProduct_menuCnt">${deliveryCnt[2]}</div></span></a>
		  			<a id="adminOrder_tap04" class="adminProduct_tapMenus <c:if test="${currentTap == 4}">on</c:if>" 
		  				onclick="admin_moveTap('adminDelivery_tap', '04')"><span>배송완료 <div class="adminProduct_menuCnt">${deliveryCnt[3]}</div></span></a>
	  				<a id="adminOrder_tap05" class="adminProduct_tapMenus <c:if test="${currentTap == 5}">on</c:if>" 
		  				onclick="admin_moveTap('adminDelivery_tap', '05')"><span>배송취소 <div class="adminProduct_menuCnt">${deliveryCnt[4]}</div></span></a>
		  			<span class="adminProduct_tapBar"></span>
		  		</div>
		  		
		  		<div class="adminProduct_cardContainer adminProduct_searchContainer">
		  			<form onsubmit="admin_search(${pagination.curPage}, 'adminDeliveryContent'); return false;">
			  			<input id="admin_searchInput" class="adminProduct_searchInput" type="text" placeholder="주문자를 검색해주세요."
			  				autocomplete="off" spellcheck="false">
		  				<input class="adminProduct_searchSubmit" type="submit" value="">
		  			</form>
				</div>
				<div id="adminProduct_content" class="adminProduct_content adminProduct_contentShow">
	  				<jsp:include page="./adminDeliveryContent.jsp"></jsp:include>
	  			</div>
		  	</div>
		 </div>
	</div>
</body>
</html>