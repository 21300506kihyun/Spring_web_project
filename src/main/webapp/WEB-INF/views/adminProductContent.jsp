<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="${pageContext.request.contextPath}/resources/js/adminProduct.js"></script>
</head>
<body>
	<form id="adminProduct_simpleUpdateForm" onsubmit="return adminProduct_simpleUpdate()">
	<div class="adminProduct_cardContainer productStatus_extend">
		<p class="adminProduct_statusText">선택상품을 </p>
		
		<input name="adminProduct_originPrice" id="adminProduct_change_originPrice_input" 
				class="adminProduct_statusInput" type="number" min="0" placeholder="원가를 입력해주세요">
		<a id="adminProduct_closeInputBtn01" class="adminProduct_closeInputBtn" onclick="resetPrice();">x</a>
		<a id="adminProduct_change_originPrice" class="adminProduct_statusBtn">원가 변경</a>
		
		<input name="adminProduct_sellingPrice" id="adminProduct_change_sellingPrice_input" 
				class="adminProduct_statusInput" type="number" min="0" placeholder="판매가를 입력해주세요">
		<a id="adminProduct_closeInputBtn02" class="adminProduct_closeInputBtn" onclick="resetDiscountPrice();">x</a>
		<a id="adminProduct_change_sellingPrice" class="adminProduct_statusBtn">판매가 변경</a>
		
		<select class="adminProduct_statusBtn" name="adminProduct_status">
			<option value="" selected>상태변경</option>
			<c:forEach items="${stateListP}" var="row">
				<option value="${row.state_id}">${row.state_name}</option>
			</c:forEach>
		</select>
		
		<input id="adminProduct_isDelete" type="hidden" name="adminProduct_isDelete" value="0"/>
		<input type="hidden" name="adminProduct_productItem[]" value="-1,-1,-1,-1"/>
		
		<input type="submit" class="adminProduct_statusBtn adminProduct_btnSubmit" value="수정"/>
		<!-- 삭제하기 클릭시 isDelete = 1로 바꾸고 폼 제출하기 -->
		<input type="submit" class="adminProduct_statusBtn adminProduct_btnDelete" onclick="setUpdateAsDelete()" value="삭제"/>
	</div>
	<!-- </form> -->
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
				<c:forEach items="${productList}" var="row" varStatus="idx">
					<tr class="adminProduct_listItem">
						<td>
							<input type="checkbox" name="adminProduct_productItem[]" 
								value="${row.p_id},${row.price},${row.discount_price},${row.state_id}" 
								class="adminProduct_itemCheckbox">
						</td>
						<td>${idx.count}</td>
						<td>${row.p_id}</td>
						<td class="adminProduct_itemName" onclick="location.href='adminProductDetail?p_id=${row.p_id}'">${row.product_name}</td>
						<td>₩${row.commaPrice}</td>
						<td>${row.discountRate}%</td>
						<td>₩${row.commaDiscountPrice}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${row.mod_date}"/></td>
						<td>${row.state_name}</td>
					</tr>
				</c:forEach>
				<c:set var="listCnt" value="${productList.size()}"/>
				<c:choose>
					<c:when test="${listCnt > 0}">
						<tr class="adminProduct_listNoData">
							<td colspan="9">자료가 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr class="adminProduct_listNoData" style="display: table-row">
							<td colspan="9">자료가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose> 
			</tbody>
		</table>
	</div>
	</form>
</body>
</html>