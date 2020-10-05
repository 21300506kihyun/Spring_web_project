<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="Omeran: adminPage" content="오메란 몰의 관리자 페이지입니다.">
  <%@ include file="./adminHeader.jsp" %>
  <title>Omeranmall: Admin</title>
  <style>
  	/* Tap Controller */
  	.adminProduct_tapContainer{
  		display: flex;
  		padding: 10px 0;
  		border-bottom: 1px solid #ddd;
  		height: 50px;
  		margin-bottom: 10px;
  	}
  	.adminProduct_tapMenus{
  		width: 125px;
  		text-align: center;
  		cursor: pointer;
  		font-size: 17px;
  	}
  	.adminProduct_menuCnt{
  		color: #1a6dff;
  		display: inline-block;
  	}
  	.adminProduct_tapBar{
  		position: absolute;
  		margin-left: 0;
  		background: #1a6dff;
  		height: 2px;
  		width: 125px;
  		margin-top: 38px;
  		
  		transition: all 0.2s ease-in-out;
		-webkit-transition: all 0.2s ease-in-out;
		-moz-transition: all 0.2s ease-in-out;
		-o-transition: all 0.2s ease-in-out;
  	}
  	.adminProduct_tapMenus.on{
  		color: #1a6dff;
  		font-weight: 500;
  	}
  	.adminProduct_tapContainer a:nth-child(1).on ~ span {margin-left: 0; opacity: 1;}
  	.adminProduct_tapContainer a:nth-child(2).on ~ span {margin-left: 125px; opacity: 1;}
  	.adminProduct_tapContainer a:nth-child(3).on ~ span {margin-left: 250px; opacity: 1;}
  	.adminProduct_tapContainer a:nth-child(4).on ~ span {margin-left: 375px; opacity: 1;}
  	.adminProduct_tapContainer a:nth-child(5).on ~ span {margin-left: 500px; opacity: 1;}
  	
  	
  	.adminProduct_content{
  		display: none; 
  		/* border: 1px solid black; */
  	}
  	.adminProduct_contentShow{display: block;}
  	
  	/* NEW */
  	input[type="submit"]{
  		font-family:  FontAwesome;
  	}
  	input:focus{
  		outline: none;
  	}
  	input[type="checkbox"]{
  	  /* Double-sized Checkboxes */
	  -ms-transform: scale(1.1); /* IE */
	  -moz-transform: scale(1.1); /* FF */
	  -webkit-transform: scale(1.1); /* Safari and Chrome */
	  -o-transform: scale(1.1); /* Opera */
  	}
  	
  	.adminProduct_cardContainer{
  		box-sizing: border-box;
		box-shadow:0 1px 1px 0 rgba(0,0,0,0.16),0 1px 5px 0 rgba(0,0,0,0.12);
		border-radius: 1px;
		/* padding: 10px; */
		background-color: #fff;
		margin-bottom: 10px;
  	}
  	.adminProduct_searchContainer{  		
  		padding: 10px;
  	}
	.adminProduct_searchInput{
		padding: 3px;
		border: none;
		width: 85%;
		margin-right: -20px;
	}
	.adminProduct_searchSubmit{
		float: right;
		padding: 0;
		margin-top: 3px;
		width: 5%;
		border: none;
		background-color: #fff;
		cursor: pointer;
		
		background-image: url('img/searchIcon.png');
		background-position: center;
		background-repeat: no-repeat;
		background-size: contain;
	}
  	.adminProduct_productContainer{
		padding: 0;
  	}
  	.adminProduct_table{
  		width: 100%;
  		text-align: center;
  		border-collapse: collapse;
  	}
  	.adminProduct_table tr{
  	
  	}
  		.adminProduct_table tbody tr:hover{
  			background-color: #f7f7f7;
  		}
  	.adminProduct_table th{
  		padding: 15px 5px;
  		border-bottom: 1px solid #ddd;
  		font-weight: 400;
  	}
  	.adminProduct_table td{
  		padding: 15px 5px;
  		font-size: 14px;
  	}
  	.adminProduct_itemCheckbox{
  	
  	}
  	.productStatus_basic{
  	}
  	.productStatus_extend{
  		display: flex;
  		overflow: hidden;
  		padding: 0;
  		height: 0px;
  		

  		
  		transition: all 0.2s ease-in-out;
		-webkit-transition: all 0.2s ease-in-out;
		-moz-transition: all 0.2s ease-in-out;
		-o-transition: all 0.2s ease-in-out;
  	}
  	.adminProduct_checkAll{
  	}
  	.adminProduct_statusText{
  		padding: 5px;
  		margin-right: 10px;
  	}
  	.adminProduct_statusBtn{
  		padding: 5px 10px;
  		border: 1px solid #bbb;
  		border-radius: 1px;
  		margin-right: 10px;
  		curosr: pointer;
  		
  		
  		transition: all 0.2s ease-in-out;
		-webkit-transition: all 0.2s ease-in-out;
		-moz-transition: all 0.2s ease-in-out;
		-o-transition: all 0.2s ease-in-out;
  	}
  		.adminProduct_statusBtn:hover{
  			background-color: #eee;
  		}
  	.adminProduct_btnDelete:hover{
  		background-color: #ff3b1f;
  		color: #fff;
  	}
  	
  	
  	
  	
  	@media screen and (max-width:768px) {
  		/* Tap Controller */
	  	.adminProduct_tapContainer{
	  		height: 40px;
	  		margin-bottom: 5px;
	  	}
	  	.adminProduct_tapMenus{
	  		width: 50px;
	  		font-size: 14px;
	  	}
	  	.adminProduct_menuCnt{
	  		display: none;
	  	}
	  	.adminProduct_tapBar{
	  		width: 50px;
	  		margin-top: 28px;
	  	}
	  	.adminProduct_tapMenus.on{
	  	}
	  	.adminProduct_tapContainer a:nth-child(1).on ~ span { }
	  	.adminProduct_tapContainer a:nth-child(2).on ~ span {margin-left: 50px; opacity: 1;}
	  	.adminProduct_tapContainer a:nth-child(3).on ~ span {margin-left: 100px; opacity: 1;}
	  	.adminProduct_tapContainer a:nth-child(4).on ~ span {margin-left: 150px; opacity: 1;}
	  	.adminProduct_tapContainer a:nth-child(5).on ~ span {margin-left: 200px; opacity: 1;}
	  	
	  	.adminProduct_contentShow{}
	  	
	  	
  	}
  </style>
<!-- <script>
  	function adminProduct_moveTap(moveUrl){
  		var ajaxOption = {
			url: moveUrl,
			async: false,
 	        type: "POST",
 	        dataType: "html",
 	        cache: false
  		}
  		$.ajax(ajaxOption).done(function(data) {
	       // Contents 영역 삭제
	       $('#adminProduct_content').children().remove();
	       // Contents 영역 교체
	       $('#adminProduct_content').html(data);
	     });
  	}
  	$(document).ready(function(){
  		$('.adminProduct_tapMenus').on('click', function(){
  			$(this).addClass('on');
  			$(this).siblings().removeClass('on');
  		});
  		
  		$("#adminProduct_tap01").click(function(){
  			/* $(".adminProduct_content").css("display", "none");
  			$("#adminProduct_content01").css("display", "block"); */
  			
  			adminProduct_moveTap("adminProduct.tap01");
  	  	});
  		$("#adminProduct_tap02").click(function(){
  			/* $(".adminProduct_content").css("display", "none");
  			$("#adminProduct_content02").css("display", "block"); */
	  		
  			adminProduct_moveTap("adminProduct.tap02");
  	  	});	
  		
  		$("#adminProduct_tap03").click(function(){
  			/* $(".adminProduct_content").css("display", "none");
  			$("#adminProduct_content03").css("display", "block"); */
  			adminProduct_moveTap("adminProduct.tap03");
  	  	});	
  		
  		$("#adminProduct_tap04").click(function(){
  			/* $(".adminProduct_content").css("display", "none");
  			$("#adminProduct_content04").css("display", "block"); */
  			adminProduct_moveTap("adminProduct.tap04");
  	  	});	
  		
  		$("#adminProduct_tap05").click(function(){
  			/* $(".adminProduct_content").css("display", "none");
  			$("#adminProduct_content05").css("display", "block"); */
  			adminProduct_moveTap("adminProduct.tap05");
  	  	});	
  	});
</script> -->
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
		  			<a id="adminProduct_tap01" class="adminProduct_tapMenus on"><span>전체 <div class="adminProduct_menuCnt">4</div></span></a>
		  			<a id="adminProduct_tap02" class="adminProduct_tapMenus"><span>판매중 <div class="adminProduct_menuCnt">4</div></span></a>
		  			<a id="adminProduct_tap03" class="adminProduct_tapMenus"><span>판매대기 <div class="adminProduct_menuCnt">0</div></span></a>
		  			<a id="adminProduct_tap04" class="adminProduct_tapMenus"><span>품절 <div class="adminProduct_menuCnt">0</div></span></a>
		  			<a id="adminProduct_tap05" class="adminProduct_tapMenus"><span>휴지통 <div class="adminProduct_menuCnt">0</div></span></a>
		  			<span class="adminProduct_tapBar"></span>
		  		</div>
		  		
		  		<div id="adminProduct_content" class="adminProduct_content adminProduct_contentShow">
	  				<jsp:include page="./adminProductContent.jsp"></jsp:include>
	  			</div>
	  			<!-- <div id="adminProduct_content02" class="adminProduct_content">
	  				content 1 copy to ajax
	  			</div>
	  			<div id="adminProduct_content03" class="adminProduct_content">
	  				content: 3
	  			</div>
	  			<div id="adminProduct_content04" class="adminProduct_content">
	  				content: 4
	  			</div>
	  			<div id="adminProduct_content05" class="adminProduct_content">
	  				content: 5
	  			</div> -->
		  	</div>
		 </div>
	</div>
</body>
</html>