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
  	
  	.adminProduct_searchContainer{  		
  		box-sizing: border-box;
		box-shadow:0 1px 1px 0 rgba(0,0,0,0.16),0 1px 5px 0 rgba(0,0,0,0.12);
		border-radius: 1px;
		padding: 10px;
		background-color: #fff;
		margin-bottom: 10px;
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
  		/* adminProduct_searchContainer와 padding 빼고 동일 */
  		box-sizing: border-box;
		box-shadow:0 1px 1px 0 rgba(0,0,0,0.16),0 1px 5px 0 rgba(0,0,0,0.12);
		border-radius: 1px;
		padding: 0;/* 10px; */
		background-color: #fff;
		margin-bottom: 10px;
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
  		font-size: 13px;
  	}
  	.adminProduct_itemCheckbox{
  	
  	}
  	.productStatus_extend{
  		display: none;
  	}
  	.adminProduct_checkAll{
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
  <script>
  	/* Tap Controller */
  	$(document).ready(function(){
  		$('.adminProduct_tapMenus').on('click', function(){
  			$(this).addClass('on');
  			$(this).siblings().removeClass('on');
  		});
  		
  		$("#adminProduct_tap01").click(function(){
  			$(".adminProduct_content").css("display", "none");
  			$("#adminProduct_content01").css("display", "block");
  	  	});
  		$("#adminProduct_tap02").click(function(){
  			$(".adminProduct_content").css("display", "none");
  			$("#adminProduct_content02").css("display", "block");
  	  	});	
  		
  		$("#adminProduct_tap03").click(function(){
  			$(".adminProduct_content").css("display", "none");
  			$("#adminProduct_content03").css("display", "block");
  	  	});	
  		
  		$("#adminProduct_tap04").click(function(){
  			$(".adminProduct_content").css("display", "none");
  			$("#adminProduct_content04").css("display", "block");
  	  	});	
  		
  		$("#adminProduct_tap05").click(function(){
  			$(".adminProduct_content").css("display", "none");
  			$("#adminProduct_content05").css("display", "block");
  	  	});	
  		
  		/* table > checkbox 리스트화 */
		$("#selectBtn").click(function(){
			var rowData = new Array();
			var tdArr = new Array();
			var checkbox = $("input[name=productItem]:checked");
			
			// 체크된 체크박스 값을 가져온다
			checkbox.each(function(i) {
	
				// checkbox.parent() : checkbox의 부모는 <td>이다.
				// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
				var tr = checkbox.parent().parent().eq(i);
				var td = tr.children();
				
				// 체크된 row의 모든 값을 배열에 담는다.
				rowData.push(tr.text());
				
				// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
				var no = td.eq(1).text()+"/ ";
				var productCode = td.eq(2).text()+"/ ";
				var productName = td.eq(3).text()+"/ ";
				var initialPrice = td.eq(4).text()+"/ ";
				var discountRate = td.eq(5).text()+"/ ";
				var finalPrice = td.eq(6).text()+"/ ";
				var modDate = td.eq(7).text()+"/ ";
				var state = td.eq(8).text()+"/ <br>";
				
				// 가져온 값을 배열에 담는다.
				tdArr.push(no);
				tdArr.push(productCode);
				tdArr.push(productName);
				tdArr.push(initialPrice);
				tdArr.push(discountRate);
				tdArr.push(finalPrice);
				tdArr.push(modDate);
				tdArr.push(state);
				
				//console.log("no : " + no);
			});
			
			$("#ex3_Result1").html(" * 체크된 Row의 모든 데이터 = <br>"+rowData);	
			$("#ex3_Result2").html(tdArr);	
		});
  		
  		/* 상품 체크박스들 클릭시 상단 메뉴 노출 */
  		$(".adminProduct_itemCheckbox").change(function(){
  			if($("input[name='productItem']:checked").length == 4){	//TODO: list의 개수만큼 length일 때,
  				$(".adminProduct_checkAll").prop("checked", true);
  			}
  			else{
  				$(".adminProduct_checkAll").prop("checked", false);
  			}
  			if($(".adminProduct_itemCheckbox").is(":checked")){
  				$("#productStatus_basic").css("display", "none");
  	  			$("#productStatus_extend").css("display", "table-row");
  			}
  			else{
  				$("#productStatus_basic").css("display", "table-row");
  	  			$("#productStatus_extend").css("display", "none");
  			}
  		});
  		
  		/* all checkbox 클릭시 전체 체크  */
  		$(".adminProduct_checkAll").change(function(){
  			if($(".adminProduct_checkAll").is(":checked")){
  				/* $(".adminProduct_itemCheckbox").attr("checked", true); */
  				$(".adminProduct_itemCheckbox").prop("checked", true);
  			}
  			else{
  				/* $(".adminProduct_itemCheckbox").attr("checked", false); */
  				$(".adminProduct_itemCheckbox").prop("checked", false);
  				$("#productStatus_basic").css("display", "table-row");
  	  			$("#productStatus_extend").css("display", "none");
  			}
  		});
  	});
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
		  			<a id="adminProduct_tap01" class="adminProduct_tapMenus on"><span>전체 <div class="adminProduct_menuCnt">4</div></span></a>
		  			<a id="adminProduct_tap02" class="adminProduct_tapMenus"><span>판매중 <div class="adminProduct_menuCnt">4</div></span></a>
		  			<a id="adminProduct_tap03" class="adminProduct_tapMenus"><span>판매대기 <div class="adminProduct_menuCnt">0</div></span></a>
		  			<a id="adminProduct_tap04" class="adminProduct_tapMenus"><span>품절 <div class="adminProduct_menuCnt">0</div></span></a>
		  			<a id="adminProduct_tap05" class="adminProduct_tapMenus"><span>휴지통 <div class="adminProduct_menuCnt">0</div></span></a>
		  			<span class="adminProduct_tapBar"></span>
		  		</div>
		  		
		  		<div id="adminProduct_content01" class="adminProduct_content adminProduct_contentShow">
	  				<div class="adminProduct_searchContainer">
	  					<form name="adminProduct_searchForm" action="" method="get">
		  					<input class="adminProduct_searchInput" type="text" name="adminProduct_search" placeholder="상품명을 검색해주세요"
		  						autocomplete="off" spellcheck="false">
		  					<input class="adminProduct_searchSubmit" type="submit" value="">
	  					</form>
	  				</div>
	  				<div class="adminProduct_productContainer">
						<table id="productList_all" class="adminProduct_table">
							<thead>
								<tr id="productStatus_basic">
									<th></th>
									<th>No.</th>
									<th>상품코드</th>
									<th>상품명</th>
									<th>원가</th>
									<th>할인율</th>
									<th>판매가</th>
									<th>수정일</th>
									<th>상태</th>
								</tr>
							</thead>
							<thead>
								<tr id="productStatus_extend" class="productStatus_extend">
									<th><input type="checkbox" name="" class="adminProduct_checkAll"></th>
									<th colspan="8" style="text-align: left;">
										체크박스 클릭시 나타날 메뉴들
									</th>
								</tr>
							</thead>
							<tbody>				
								<tr>
									<td><input type="checkbox" name="productItem" class="adminProduct_itemCheckbox"></td>
									<td>1</td>
									<td>OM1001</td>
									<td>오메란 A세트</td>
									<td>₩10,000</td>
									<td>10%</td>
									<td>₩9,000</td>
									<td>2020.08.13</td>
									<td>판매중</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="productItem" class="adminProduct_itemCheckbox"></td>
									<td>2</td>
									<td>OM1002</td>
									<td>오메란 B세트</td>
									<td>₩20,000</td>
									<td>10%</td>
									<td>₩18,000</td>
									<td>2020.08.15</td>
									<td>판매중</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="productItem" class="adminProduct_itemCheckbox"></td>
									<td>3</td>
									<td>OM1003</td>
									<td>오메란 C세트</td>
									<td>₩30,000</td>
									<td>10%</td>
									<td>₩27,000</td>
									<td>2020.08.13</td>
									<td>판매중</td>
								</tr>
								<tr>
									<td><input type="checkbox" name="productItem" class="adminProduct_itemCheckbox"></td>
									<td>4</td>
									<td>OM1004</td>
									<td>오메란 D세트</td>
									<td>₩40,000</td>
									<td>10%</td>
									<td>₩36,000</td>
									<td>2020.08.15</td>
									<td>판매중</td>
								</tr>
							</tbody>
						</table>
						<button type="button" class="btn btn-outline btn-primary pull-right" id="selectBtn">선택</button>
						<div class="col-lg-12" id="ex3_Result1" ></div> 
						<div class="col-lg-12" id="ex3_Result2" ></div> 
	  				</div>
	  			</div>
	  			<div id="adminProduct_content02" class="adminProduct_content">
	  				content: 2
	  			</div>
	  			<div id="adminProduct_content03" class="adminProduct_content">
	  				content: 3
	  			</div>
	  			<div id="adminProduct_content04" class="adminProduct_content">
	  				content: 4
	  			</div>
	  			<div id="adminProduct_content05" class="adminProduct_content">
	  				content: 5
	  			</div>
		  	</div>
		 </div>
	</div>
</body>
</html>