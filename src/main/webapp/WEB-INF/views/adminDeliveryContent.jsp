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
		
		function adminDelivery_simpleUpdateTest(){
			var new_state = $("#admin_status").val();
			var new_deliveryman = $("#admin_deliveryman").val();
			var new_deliveryLocation = $("#admin_deliveryLocation").val();
			
			if(new_state == "default" && new_deliveryman == "default" && new_deliveryLocation == "default"){
				alert("아무런 변경 사항이 없습니다.");
				return false;
			}
					
			if(new_state == "D001"){
				if(new_deliveryLocation == "default"){
				}
				else if(new_deliveryLocation == ""){
				}
				else{
					alert("배송이 완료되지 않은 상태입니다.\n배송 완료 장소를 잘못 설정하셨습니다.");
					return false;
				}
			} 
			else if(new_state == "D002"){
				if(new_deliveryman == "default" || new_deliveryman == ""){
					alert("배송자가 할당되지 않았습니다.\n배송자를 할당해주세요.");
					return false;
				}
				if(new_deliveryLocation == "default"){
				}
				else if(new_deliveryLocation == ""){
				}
				else{
					alert("배송이 완료되지 않은 상태입니다.\n배송 완료 장소를 잘못 설정하셨습니다.");
					return false;
				}
			}
			else if(new_state == "D003"){
				if(new_deliveryman == ""){
					alert("배송이 진행중입니다. 배송자 초기화는 불가능합니다.\n배송자를 바꾸시려면 다른 배송자를 선택해주세요.");
					return false;
				}
				if(new_deliveryLocation == "default"){
				}
				else if(new_deliveryLocation == ""){
				}
				else{
					alert("배송이 완료되지 않은 상태입니다.\n배송 완료 장소를 잘못 설정하셨습니다.");
					return false;
				}
			}
			else if(new_state == "D004"){
				if(new_deliveryman != "default"){
					alert("배송이 완료되었습니다. 완료된 배송에 대해서 배송자 변경은 불가능합니다.");
					return false;
				}
				if(new_deliveryLocation == "default"){
					alert("배송이 완료되었습니다. 배송완료 장소를 선택해주세요.");
					return false;
				}
			}
			else if(new_state == "D005"){
				if(new_deliveryman != "default"){
					alert("취소된 배송에 대해서는 추가 변경할 수 없습니다.");
					return false;
				}
				if(new_deliveryLocation != "default"){
					alert("취소된 배송에 대해서는 추가 변경할 수 없습니다.");
					return false;
				}
			}
			
			return true;
		}
		
		function adminDelivery_simpleUpdate(){
			if(!adminDelivery_simpleUpdateTest()){
				return false;
			}
			
			// formID, postURL, replaceArea
			simpleUpdate(
					"adminDelivery_simpleUpdateForm", 
					"adminDelivery_simpleUpdate",
					"html");
		}
	</script>
</head>
<body>
	<form id="adminDelivery_simpleUpdateForm" onsubmit="return adminDelivery_simpleUpdate()">
	<div class="adminProduct_cardContainer productStatus_extend">
		<p class="adminProduct_statusText">선택 배송을 </p>
		
		<select class="adminProduct_statusBtn" name="admin_status" id="admin_status">
			<option value="default" selected>상태변경</option>
			<c:forEach items="${stateList}" var="row">
				<option value="${row.state_id}">${row.state_name}</option>
			</c:forEach>
		</select>
		
		<select class="adminProduct_statusBtn" name="admin_deliveryman" id="admin_deliveryman">
			<option value="default" selected>배송자 할당</option>
			<c:forEach items="${deliverymanList}" var="row">
				<option value="${row.u_id}">${row.user_name}</option>
			</c:forEach>
			<option value="null">초기화</option>
		</select>
		
		<select class="adminProduct_statusBtn" name="admin_deliveryLocation" id="admin_deliveryLocation">
			<option value="default" selected>배송완료 장소</option>
			<option value="직접전달">직접전달</option>
			<option value="문 앞">문 앞</option>
			<option value="경비실">경비실</option>
			<option value="-">초기화</option>
		</select>
		
		<input type="hidden" name="adminDelivery_deliveryIDs[]" value="-1"/>
		
		<input type="submit" class="adminProduct_statusBtn adminProduct_btnSubmit" value="로 변경하기"/>
	</div>
	<!-- </form> -->
	<div class="adminProduct_cardContainer adminProduct_productContainer">
		<table id="OrderList" class="adminOrder_table">
			<thead>
				<tr class="productStatus_basic">
					<th><input type="checkbox" name="" class="adminProduct_checkAll"></th>
					<th>배송번호</th>
					<th>주문번호</th>
					<th>주문자</th>
					<th>상품명</th>
					<th>현재 배송현황</th>
					<th>수정일</th>
					<th>담당배송자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${DeliveryList}" var="row" varStatus="idx">
					<c:set var="deliveryman" value="${row.delivery_name}" />
					<tr class="adminProduct_listItem">
						<td>
							<input type="checkbox" name="adminDelivery_deliveryIDs[]" 
								value="${row.delivery_id}" 
								class="adminProduct_itemCheckbox">
						</td>
						<td class="adminProduct_itemName" onclick="expandToggle(${row.delivery_id});">${row.delivery_id}</td>
						<td>${row.order_id}</td>
						<td>${row.user_name}</td>
						<td>${row.product_name}"</td>
						<td>${row.current_delivery_count} / 2</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${row.mod_date}"/></td>
						<c:choose>
							<c:when test="${deliveryman != null}">
								<td>${row.delivery_name}</td>
							</c:when>
							<c:otherwise>
								<td>-</td>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr id="hiddenA${row.delivery_id}" class="adminOrder_additionalArea" style="font-weight: 700; border-top: 1px solid #bbb">
						<td>배송 위치</td>
						<td>배송 출발일</td>
						<td>배송 완료일</td>
						<td>고객 연락처</td>
						<td>고객 이메일</td>
						<td colspan="3">배송주소</td>
					</tr>
					<tr id="hiddenB${row.delivery_id}" class="adminOrder_additionalArea" style="border-bottom: 1px solid #bbb;">
						<c:choose>
							<c:when test="${row.delivery_location != null}">
								<td>${row.delivery_location}</td>
							</c:when>
							<c:otherwise>
								<td>-</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${row.departure_date != null}">
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${row.departure_date}"/></td>
							</c:when>
							<c:otherwise>
								<td>-</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${row.arrival_date != null}">
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${row.arrival_date}"/></td>
							</c:when>
							<c:otherwise>
								<td>-</td>
							</c:otherwise>
						</c:choose>
						<td>${row.telephone}</td>
						<td>${row.email}</td>
						<td colspan="3">${row.address01} ${row.address02} ${row.address03}</td>
					</tr>
				</c:forEach>
				<c:set var="listCnt" value="${DeliveryList.size()}"/>
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
           <li class="page-num"><a onclick="admin_search('1', 'adminDeliveryContent')"> [처음] </a></li>
         </c:if>
         <c:if test="${pagination.curPage != 1}">
           <li class="page-num"><a onclick="admin_search('${pagination.prevPage}', 'adminDeliveryContent')"> [이전] </a></li>
         </c:if>
         <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
           <c:choose>
             <c:when test="${pageNum == pagination.curPage}">
               <li class="page-num"><a class="page-num-selected" onclick="admin_search('${pageNum}', 'adminDeliveryContent')"> ${pageNum} </a></li>
             </c:when>
             <c:otherwise>
               <li class="page-num"><a onclick="admin_search('${pageNum}', 'adminDeliveryContent')"> ${pageNum} </a></li>
             </c:otherwise>
           </c:choose>
         </c:forEach>
         <c:if test="${pagination.curPage != pagination.pageCnt && pagination.pageCnt > 0}">
           <li class="page-num"><a onclick="admin_search('${pagination.nextPage}', 'adminDeliveryContent')"> [다음] </a></li>
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