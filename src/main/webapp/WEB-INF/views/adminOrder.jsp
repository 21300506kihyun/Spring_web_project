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
  	function adminOrder_search(curPage){
  		var searchKeyword = "search_keyword="+$("#adminOrder_searchInput").val();
  		var goPage = "currentPage="+curPage;
  		var URL = searchKeyword + "&" + goPage;
  		$.ajax({
  			type: "POST",
  			url: "adminOrderContent",
  			data: URL,
  			dataType: "html",
  			async: false,
  			cache: false,
  			success: function(result){
  				// Contents 영역 삭제
				$('#adminProduct_content').children().remove();
				// Contents 영역 교체
				$('#adminProduct_content').html(result);
  			},
  			error: function(error){
  				console.log(error)
  			}
  		});
  		return false;
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
		  	<c:set var="currentTap" value="${currentTap}" />
		  	<div class="admin_content">
		  		<div class="adminProduct_tapContainer">
		  			<a id="adminOrder_tap01" class="adminProduct_tapMenus <c:if test="${currentTap == 1}">on</c:if>" 
		  				onclick="admin_moveTap('adminOrder_tap', '01')"><span>입금전 <div class="adminProduct_menuCnt">${orderCnt[0]}</div></span></a>
		  			<a id="adminOrder_tap02" class="adminProduct_tapMenus <c:if test="${currentTap == 2}">on</c:if>" 
		  				onclick="admin_moveTap('adminOrder_tap', '02')"><span>구독중 <div class="adminProduct_menuCnt">${orderCnt[1]}</div></span></a>
		  			<a id="adminOrder_tap03" class="adminProduct_tapMenus <c:if test="${currentTap == 3}">on</c:if>" 
		  				onclick="admin_moveTap('adminOrder_tap', '03')"><span>구독만료 <div class="adminProduct_menuCnt">${orderCnt[2]}</div></span></a>
		  			<a id="adminOrder_tap04" class="adminProduct_tapMenus <c:if test="${currentTap == 4}">on</c:if>" 
		  				onclick="admin_moveTap('adminOrder_tap', '04')"><span>구매자취소 <div class="adminProduct_menuCnt">${orderCnt[3]}</div></span></a>
	  				<a id="adminOrder_tap05" class="adminProduct_tapMenus <c:if test="${currentTap == 5}">on</c:if>" 
		  				onclick="admin_moveTap('adminOrder_tap', '05')"><span>판매자취소 <div class="adminProduct_menuCnt">${orderCnt[4]}</div></span></a>
		  			<span class="adminProduct_tapBar"></span>
		  		</div>
		  		
		  		<div class="adminProduct_cardContainer adminProduct_searchContainer">
		  			<form onsubmit="adminOrder_search(${pagination.curPage}); return false;">
			  			<input id="adminOrder_searchInput" class="adminProduct_searchInput" type="text" placeholder="주문자를 검색해주세요."
			  				autocomplete="off" spellcheck="false">
		  				<input class="adminProduct_searchSubmit" type="submit" value="">
		  			</form>
				</div>
				<div id="adminProduct_content" class="adminProduct_content adminProduct_contentShow">
	  				<jsp:include page="./adminOrderContent.jsp"></jsp:include>
	  			</div>
			  	
		  	</div>
		 </div>
	</div>
</body>
</html>