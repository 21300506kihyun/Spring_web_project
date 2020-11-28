<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="Omeran: adminPage" content="오메란 몰의 관리자 페이지입니다.">
  <title>Omeranmall: Admin</title>
  <%@ include file="./adminHeader.jsp" %>
  <script>
  	function admin_deliverymanDetail_moveTap(tap){
  		$("#detailTap01").css("display", "none");
  		$("#detailTap02").css("display", "none");
  		$("#detailTap03").css("display", "none");
  		
  		$("#detailTap0"+tap).css("display", "block");
  		
  		if(tap > 1){
  			$(".adminDeliveryman-search-input").css("display", "block");
  			$("#admin_search").focus();
  		}else{
  			$(".adminDeliveryman-search-input").css("display", "none");
  		}
  	}
  </script>
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
		  		<div class="adminProduct_tapContainer">
		  			<a id="adminDeliveryman_tap01" class="adminProduct_tapMenus on" onclick="admin_deliverymanDetail_moveTap(1)"><span>기본정보</span></a>
		  			<a id="adminDeliveryman_tap02" class="adminProduct_tapMenus" onclick="admin_deliverymanDetail_moveTap(2)"><span>배송기록 <div class="adminProduct_menuCnt"> ${allDeliveryLogs.size()}</div></span></a>
		  			<a id="adminDeliveryman_tap03" class="adminProduct_tapMenus" onclick="admin_deliverymanDetail_moveTap(3)"><span>현재 담당배송 <div class="adminProduct_menuCnt"> ${currDeliveryLogs.size()}</div></span></a>
		  			<span class="adminProduct_tapBar"></span>
		  		</div>
		  		
				<div id="adminProduct_content" class="adminProduct_content adminProduct_contentShow">
					<div id="detailTap01" class="adminProduct_productContainer">
						<jsp:include page="./adminDeliverymanDetailTap01.jsp"></jsp:include>
					</div>
					<!-- 검색: 자바스크립트 -->
					<div class="adminProduct_cardContainer adminProduct_searchContainer adminDeliveryman-search-input">
						<input id="admin_search" class="adminProduct_searchInput" type="text" placeholder="상품명을 검색해주세요"
							autocomplete="off" spellcheck="false" onkeyup="admin_filter('admin_search')">
						<input class="adminProduct_searchSubmit" type="button" value="" onclick="admin_filter()">
					</div>
					<div id="detailTap02" class="adminProduct_productContainer display-none">
						<jsp:include page="./adminDeliverymanDetailTap02.jsp"></jsp:include>
					</div>
					<div id="detailTap03" class="adminProduct_productContainer display-none">
						<jsp:include page="./adminDeliverymanDetailTap03.jsp"></jsp:include>
					</div>
	  			</div>
		  	</div>
		 </div>
	</div>
</body>
</html>