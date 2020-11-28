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
  	function admin_siteDetail_moveTap(tap){
  		$("#detailTap01").css("display", "none");
  		/* $("#detailTap02").css("display", "none");
  		$("#detailTap03").css("display", "none"); */
  		
  		$("#detailTap0"+tap).css("display", "block");
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
		  			<a id="adminDeliveryman_tap01" class="adminProduct_tapMenus on" onclick="admin_siteDetail_moveTap(1)"><span>기본정보</span></a>
		  			<span class="adminProduct_tapBar"></span>
		  		</div>
		  		
				<div id="adminProduct_content" class="adminProduct_content adminProduct_contentShow">
					<div id="detailTap01" class="adminProduct_productContainer">
						<jsp:include page="./adminSiteContentTap01.jsp"></jsp:include>
					</div>
	  			</div>
		  	</div>
		 </div>
	</div>
</body>
</html>