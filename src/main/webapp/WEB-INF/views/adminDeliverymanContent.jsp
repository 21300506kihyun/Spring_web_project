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
		function adminDeliveryman_simpleUpdateTest(){
			if($("#admin_isDelete").val() == 1){
				if(!confirm("해당 관리자를 삭제하시겠습니까?")){
					return false;
				}
			}
			else{
				if(!confirm("해당 관리자의 정보를 수정하시겠습니까?")){
					return false;
				}
			}
			return true;
		}
		
		function adminDeliveryman_simpleUpdate(){
			if(!adminDeliveryman_simpleUpdateTest()){
				return false;
			}
			
			// formID, postURL, replaceArea
			simpleUpdate(
					"adminDeliveryman_simpleUpdateForm", 
					"adminDeliveryman_simpleUpdate",
					"html");
		}
	</script>
</head>
<body>
	<form id="adminDeliveryman_simpleUpdateForm" onsubmit="return adminDeliveryman_simpleUpdate()">
	<div class="adminProduct_cardContainer productStatus_extend">
		<p class="adminProduct_statusText">선택 배송자를 </p>
		
		<input name="admin_memo" id="adminProduct_change_originPrice_input" 
				class="adminProduct_statusInput" type="text" placeholder="메모를 입력해주세요." autocomplete="off">
		<a id="adminProduct_closeInputBtn01" class="adminProduct_closeInputBtn" onclick="resetInput('adminProduct_change_originPrice_input');">x</a>
		<a id="adminProduct_change_originPrice" class="adminProduct_statusBtn">메모</a>
		
		<!-- 삭제? or 수정? -->
		<input id="admin_isDelete" type="hidden" name="admin_isDelete" value="0"/>
		
		<input type="hidden" name="adminDelivery_deliverymanIDs[]" value="-1"/>
		
		<input type="submit" class="adminProduct_statusBtn adminProduct_btnSubmit" value="수정"/>
		<input type="submit" class="adminProduct_statusBtn adminProduct_btnDelete" onclick="setValueAs_1_byId('admin_isDelete')" value="삭제"/>
	</div>
	<!-- </form> -->
	<div class="adminProduct_cardContainer adminProduct_productContainer">
		<table id="OrderList" class="adminOrder_table">
			<thead>
				<tr class="productStatus_basic">
					<th><input type="checkbox" name="" class="adminProduct_checkAll"></th>
					<th>이름</th>
					<th>아이디</th>
					<th>연락처</th>
					<th>현재 담당 배송수</th>
					<th>총 배송 횟수</th>
					<th>이메일</th>
					<th>메모</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${DeliverymanList}" var="row" varStatus="idx">
					<c:set var="gender" value="${row.gender}" />
					<tr class="adminProduct_listItem">
						<td>
							<input type="checkbox" name="adminDelivery_deliverymanIDs[]" 
								value="${row.u_id}" 
								class="adminProduct_itemCheckbox">
						</td>
						<td class="adminProduct_itemName" onclick="location.href='adminDeliverymanDetail?u_id=${row.u_id}'">
							${row.user_name}
							<c:choose>
								<c:when test="${gender == 0}">
									(남)
								</c:when>
								<c:when test="${gender == 1}">
									(여)
								</c:when>
							</c:choose>
						</td>
						<td>${row.user_id}</td>
						<td>${row.telephone}</td>
						<td>TODO</td>
						<td>TODO</td>
						<td>${row.email}</td>
						<td>${row.user_memo}</td>
					</tr>
				</c:forEach>
				<c:set var="listCnt" value="${DeliverymanList.size()}"/>
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
           <li class="page-num"><a onclick="admin_search('1', 'adminDeliverymanContent')"> [처음] </a></li>
         </c:if>
         <c:if test="${pagination.curPage != 1}">
           <li class="page-num"><a onclick="admin_search('${pagination.prevPage}', 'adminDeliverymanContent')"> [이전] </a></li>
         </c:if>
         <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
           <c:choose>
             <c:when test="${pageNum == pagination.curPage}">
               <li class="page-num"><a class="page-num-selected" onclick="admin_search('${pageNum}', 'adminDeliverymanContent')"> ${pageNum} </a></li>
             </c:when>
             <c:otherwise>
               <li class="page-num"><a onclick="admin_search('${pageNum}', 'adminDeliverymanContent')"> ${pageNum} </a></li>
             </c:otherwise>
           </c:choose>
         </c:forEach>
         <c:if test="${pagination.curPage != pagination.pageCnt && pagination.pageCnt > 0}">
           <li class="page-num"><a onclick="admin_search('${pagination.nextPage}', 'adminDeliverymanContent')"> [다음] </a></li>
         </c:if>
         <c:if test="${pagination.curRange != pagination.rangeCnt && pagination.rangeCnt > 0}">
           <li class="page-num"><a onclick="admin_search('${pagination.pageCnt}', 'adminDeliveryContent')"> [끝] </a></li>
         </c:if>
       </ul>
     </div>
     <%-- [FOR DEBUG] 총 게시글 수 : ${pagination.listCnt} / 총 페이지수 : ${pagination.pageCnt} / 현재 페이지 : ${pagination.curPage } / 현재 블럭 : ${pagination.curRange } / 총 블럭 수 : ${pagination.rangeCnt } --%>
	</form>
</body>
</html>