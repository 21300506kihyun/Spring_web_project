<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="js/adminProduct.js"></script>
</head>
<body>
	<!-- <div class="adminProduct_cardContainer adminProduct_searchContainer">
		<input id="adminProduct_searchInput" class="adminProduct_searchInput" type="text" placeholder="상품명을 검색해주세요"
			autocomplete="off" spellcheck="false" onkeyup="adminProduct_filter()">
		<input class="adminProduct_searchSubmit" type="button" value="" onclick="adminProduct_filter()">
	</div> -->
	<h1>${testData}</h1>
	<div class="adminProduct_cardContainer productStatus_extend">
		<p class="adminProduct_statusText">선택상품을 </p>
		
		<input name="adminProduct_originPrice" id="adminProduct_change_originPrice_input" 
				class="adminProduct_statusInput" type="text" placeholder="원가를 입력해주세요">
		<a id="adminProduct_closeInputBtn01" class="adminProduct_closeInputBtn" onclick="adminProduct_closeInputs();">x</a>
		<a id="adminProduct_change_originPrice" class="adminProduct_statusBtn">원가 변경</a>
		
		<input name="adminProduct_sellingPrice" id="adminProduct_change_sellingPrice_input" 
				class="adminProduct_statusInput" type="text" placeholder="판매가를 입력해주세요">
		<a id="adminProduct_closeInputBtn02" class="adminProduct_closeInputBtn" onclick="adminProduct_closeInputs();">x</a>
		<a id="adminProduct_change_sellingPrice" class="adminProduct_statusBtn">판매가 변경</a>
		
		<select class="adminProduct_statusBtn" name="adminProduct_status">
			<option selected>상태변경</option>
			<option value="${testData}">${testData}+1</option>
			<option value="${testData}">${testData}+2</option>
		</select>
		
		<a class="adminProduct_statusBtn adminProduct_btnSubmit" href="#modify">수정</a>
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
			<tbody>				
				<tr class="adminProduct_listItem">
					<td><input type="checkbox" name="productItem" class="adminProduct_itemCheckbox"></td>
					<td>1</td>
					<td>OM1001</td>
					<td class="adminProduct_itemName" onclick="location.href='#productDetail'">오메란 Ab세트</td>
					<td>₩10,000</td>
					<td>10%</td>
					<td>₩9,000</td>
					<td>2020.08.13</td>
					<td>판매중</td>
				</tr>
				<tr class="adminProduct_listItem">
					<td><input type="checkbox" name="productItem" class="adminProduct_itemCheckbox"></td>
					<td>2</td>
					<td>OM1002</td>
					<td class="adminProduct_itemName" onclick="location.href='#productDetail'">오메란 Bc세트</td>
					<td>₩20,000</td>
					<td>10%</td>
					<td>₩18,000</td>
					<td>2020.08.15</td>
					<td>판매중</td>
				</tr>
				<tr class="adminProduct_listItem">
					<td><input type="checkbox" name="productItem" class="adminProduct_itemCheckbox"></td>
					<td>3</td>
					<td>OM1003</td>
					<td class="adminProduct_itemName" onclick="location.href='#productDetail'">오메란 Cd세트</td>
					<td>₩30,000</td>
					<td>10%</td>
					<td>₩27,000</td>
					<td>2020.08.13</td>
					<td>판매중</td>
				</tr>
				<tr class="adminProduct_listItem">
					<td><input type="checkbox" name="productItem" class="adminProduct_itemCheckbox"></td>
					<td>4</td>
					<td>OM1004</td>
					<td class="adminProduct_itemName" onclick="location.href='#productDetail'">오메란 Da세트</td>
					<td>₩40,000</td>
					<td>10%</td>
					<td>₩36,000</td>
					<td>2020.08.15</td>
					<td>판매중</td>
				</tr>
				<tr class="adminProduct_listNoData">
					<td colspan="9">자료가 없습니다.</td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="btn btn-outline btn-primary pull-right selectBtn" id="">선택</button>
		<div class="col-lg-12 ex3_Result1"></div> 
		<div class="col-lg-12 ex3_Result2"></div> 
	</div>
</body>
</html>