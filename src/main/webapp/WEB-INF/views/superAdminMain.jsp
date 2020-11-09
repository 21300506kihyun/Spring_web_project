<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="Omeran: Super adminPage" content="오메란 몰의 플랫폼 관리 메뉴입니다.">
	<title>Omeranmall: Super Admin</title>
	<%@ include file="./adminHeader.jsp" %>
	<script>
	function superAdminMain_search(curPage){
		var searchInput = "superAdmin_searchText="+$("#adminProduct_searchInput").val();
		var goPage = "currentPage=" + curPage;
		var GET_url = searchInput + "&" + goPage;
		$.ajax({
			type: "POST",
			url: "superAdmin.search",
			data: GET_url,
			dataType: "html",
			async: false,
			cache: false,
			success: function(result){
				// Contents 영역 삭제
				$('#adminProduct_content').children().remove();
				// Contents 영역 교체
				$('#adminProduct_content').html(result);
				/* alert("수정이 완료되었습니다."); */
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
		<jsp:include page="./superAdminSidebar.jsp"></jsp:include>
		 
		 <!-- right -->
		 <div class="admin_right">
		 	<!-- top -->
		  	<jsp:include page="./superAdminTop.jsp"></jsp:include>
		  	
		  	<!-- content -->
		  	<div class="admin_content">
		  		<div class="adminProduct_cardContainer adminProduct_searchContainer">
		  			<form action="index" onsubmit="superAdminMain_search(${pagination.curPage}); return false;">
						<input id="adminProduct_searchInput" class="adminProduct_searchInput" type="text" placeholder="관리 쇼핑몰을 검색해주세요"
							autocomplete="off" spellcheck="false">
						<input class="adminProduct_searchSubmit" type="submit" value="">		  			
		  			</form>  			
				</div>
		  		<div id="adminProduct_content" class="adminProduct_content adminProduct_contentShow">
	  				<jsp:include page="./superAdminManageContent.jsp"></jsp:include>
	  			</div>
		  	</div>
		 </div>
	</div>
</body>
</html>