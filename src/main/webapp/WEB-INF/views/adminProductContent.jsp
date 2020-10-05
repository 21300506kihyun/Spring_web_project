<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Contents</title>
<%@ include file="./adminHeader.jsp" %>
</head>
<body>
	<h1>${testData}</h1>
	<div class="adminProduct_cardContainer adminProduct_searchContainer">
		<form name="adminProduct_searchForm" action="" method="get">
			<input class="adminProduct_searchInput" type="text" name="adminProduct_search" placeholder="상품명을 검색해주세요"
				autocomplete="off" spellcheck="false">
			<input class="adminProduct_searchSubmit" type="submit" value="">
		</form>
	</div>
	<div class="adminProduct_cardContainer productStatus_extend">
		<p class="adminProduct_statusText">선택상품을 </p>
		<a class="adminProduct_statusBtn" href="#dropdown">원가 변경</a>
		<a class="adminProduct_statusBtn" href="#dropdown">판매가 변경</a>
		<a class="adminProduct_statusBtn" href="#dropdown">상태변경</a>
		<a class="adminProduct_statusBtn adminProduct_btnDelete" href="#delete">삭제</a>
	</div>
	<div class="adminProduct_cardContainer adminProduct_productContainer">
		<table id="productList_all" class="adminProduct_table">
			<thead>
				<tr class="productStatus_basic">
					<th><input type="checkbox" name="" class="adminProduct_checkAll"></th>
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
			<!-- <thead>
				<tr class="productStatus_extend">
					<th><input type="checkbox" name="" class="adminProduct_checkAll"></th>
					<th colspan="8" style="text-align: left; padding: 0;">
						<div style="display: flex;">
							<a style="border: 1px solid black; padding: 1px; margin-right: 3px;" href="#delete">삭제</a>
							<a style="border: 1px solid black; padding: 1px; margin-right: 3px;" href="#delete">삭제</a>
						</div>
					</th>
				</tr>
			</thead> -->
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
		<button type="button" class="btn btn-outline btn-primary pull-right selectBtn" id="">선택</button>
		<div class="col-lg-12 ex3_Result1"></div> 
		<div class="col-lg-12 ex3_Result2"></div> 
	</div>
</body>
</html>