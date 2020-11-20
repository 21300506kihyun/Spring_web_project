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
	<script>
		function expandToggle(id){
			if($("#hiddenA"+id).css("display") == "table-row"){
				$("#hiddenA"+id).css("display", "none");
			}
			else{
				$("#hiddenA"+id).css("display", "table-row");
			}
			if($("#hiddenB"+id).css("display") == "table-row"){
				$("#hiddenB"+id).css("display", "none");
			}
			else{
				$("#hiddenB"+id).css("display", "table-row");
			}
		}
		
		function adminOrder_simpleUpdateTest(){
			return true;
		}
		
		function adminOrder_simpleUpdate(){
			if(!adminOrder_simpleUpdateTest()){
				return false;
			}
			
			// formID, postURL, replaceArea
			simpleUpdate(
					"adminOrder_simpleUpdateForm", 
					"adminOrder_simpleUpdate",
					"html");
		}
	</script>
</head>
<body>
	<form id="adminOrder_simpleUpdateForm" onsubmit="return adminOrder_simpleUpdate()">
	<div class="adminProduct_cardContainer productStatus_extend">
		<p class="adminProduct_statusText">선택 주문의 상태를</p>
		
		<select class="adminProduct_statusBtn" name="adminOrder_status">
			<option value="" selected>상태변경</option>
			<c:forEach items="${stateList}" var="row">
				<option value="${row.state_id}">${row.state_name}</option>
			</c:forEach>
		</select>
		
		<%-- <select class="adminProduct_statusBtn" name="adminOrder_status">
			<option value="" selected>배송자 할당</option>
			<c:forEach items="${deliverymanList}" var="row">
				<option value="${row.u_id}">${row.user_name}</option>
			</c:forEach>
		</select> --%>
		
		<input type="hidden" name="adminOrder_orderIDs[]" value="-1"/>
		
		<input type="submit" class="adminProduct_statusBtn adminProduct_btnSubmit" value="로 변경하기"/>
	</div>
	<!-- </form> -->
	<div class="adminProduct_cardContainer adminProduct_productContainer">
		<table id="OrderList" class="adminOrder_table">
			<thead>
				<tr class="productStatus_basic">
					<th><input type="checkbox" name="" class="adminProduct_checkAll"></th>
					<th>주문번호</th>
					<th>주문자</th>
					<th>상품명</th>
					<th>주문금액</th>
					<th>남은 배송횟수</th>
					<th>주문날짜</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${OrderList}" var="row" varStatus="idx">
					<tr class="adminProduct_listItem">
						<td>
							<input type="checkbox" name="adminOrder_orderIDs[]" 
								value="${row.order_id}" 
								class="adminProduct_itemCheckbox">
						</td>
						<td class="adminProduct_itemName" onclick="expandToggle(${row.order_id});">${row.order_id}</td>
						<td>${row.user_name}</td>
						<td>${row.product_name}</td>
						<td>₩<fmt:formatNumber type="number" maxFractionDigits="3" value="${row.pay_amount}" /></td>
						<td>TODO</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${row.order_date}"/></td>
						<td>${row.state_name}</td>
					</tr>
					<tr id="hiddenA${row.order_id}" class="adminOrder_additionalArea" style="font-weight: 700; border-top: 1px solid #bbb">
						<td>상품코드</td>
						<td>결제수단</td>
						<td>고객 연락처</td>
						<td>고객 이메일</td>
						<td colspan="3">배송주소</td>
						<td>유효기간</td>
					</tr>
					<tr id="hiddenB${row.order_id}" class="adminOrder_additionalArea" style="border-bottom: 1px solid #bbb;">
						<td>${row.product_id}</td>
						<td>${row.payment_way}</td>
						<td>${row.telephone}</td>
						<td>${row.email}</td>
						<td colspan="3">${row.address01} ${row.address02} ${row.address03}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${row.buy_end}"/></td>
					</tr>
				</c:forEach>
				<c:set var="listCnt" value="${OrderList.size()}"/>
				<c:choose>
					<c:when test="${listCnt > 0}">
						<tr class="adminProduct_listNoData">
							<td colspan="8">자료가 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr class="adminProduct_listNoData" style="display: table-row">
							<td colspan="8">자료가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose> 
			</tbody>
		</table>
	</div>
	<div class="paging-container">
       <ul>
         <c:if test="${pagination.curRange != 1}">
           <li class="page-num"><a onclick="adminOrder_search('1')"> [처음] </a></li>
         </c:if>
         <c:if test="${pagination.curPage != 1}">
           <li class="page-num"><a onclick="adminOrder_search('${pagination.prevPage}')"> [이전] </a></li>
         </c:if>
         <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
           <c:choose>
             <c:when test="${pageNum == pagination.curPage}">
               <li class="page-num"><a class="page-num-selected" onclick="adminOrder_search('${pageNum}')"> ${pageNum} </a></li>
             </c:when>
             <c:otherwise>
               <li class="page-num"><a onclick="adminOrder_search('${pageNum}')"> ${pageNum} </a></li>
             </c:otherwise>
           </c:choose>
         </c:forEach>
         <c:if test="${pagination.curPage != pagination.pageCnt && pagination.pageCnt > 0}">
           <li class="page-num"><a onclick="adminOrder_search('${pagination.nextPage}')"> [다음] </a></li>
         </c:if>
         <c:if test="${pagination.curRange != pagination.rangeCnt && pagination.rangeCnt > 0}">
           <li class="page-num"><a onclick="adminOrder_search('${pagination.pageCnt}')"> [끝] </a></li>
         </c:if>
       </ul>
     </div>
     <%-- [FOR DEBUG] 총 게시글 수 : ${pagination.listCnt} / 총 페이지수 : ${pagination.pageCnt} / 현재 페이지 : ${pagination.curPage } / 현재 블럭 : ${pagination.curRange } / 총 블럭 수 : ${pagination.rangeCnt } --%>
	</form>
</body>
</html>