<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
</head>
<body>
	<div class="adminProduct_cardContainer adminProduct_productContainer">
		<table id="OrderList" class="adminOrder_table">
			<thead>
				<tr class="productStatus_basic">
					<th style="width: 10% !important;">배송번호</th>
					<th>주문번호</th>
					<th>주문자</th>
					<th>상품명</th>
					<th>현재 배송현황</th>
					<th>수정일</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${allDeliveryLogs}" var="row" varStatus="idx">
					<tr class="adminProduct_listItem" onclick="expandToggle(${row.delivery_id});" style="cursor: pointer">
						<td>${row.delivery_id}</td>
						<td>${row.order_id}</td>
						<td class="adminProduct_itemName">${row.user_name}</td>
						<td>${row.product_name}"</td>
						<td>${row.current_delivery_count} / 2</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${row.mod_date}"/></td>
						<td>${row.state_name}</td>
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
								<td><fmt:formatDate pattern="MM-dd HH:mm" value="${row.arrival_date}"/></td>
							</c:when>
							<c:otherwise>
								<td>-</td>
							</c:otherwise>
						</c:choose>
						<td>${row.telephone}</td>
						<td>${row.email}</td>
						<td colspan="3">${row.address01}<br>${row.address02}<br>${row.address03}</td>
					</tr>
				</c:forEach>
				<c:set var="listCnt" value="${allDeliveryLogs.size()}"/>
				<c:choose>
					<c:when test="${listCnt > 0}">
						<tr class="adminProduct_listNoData">
							<td colspan="7">자료가 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr class="adminProduct_listNoData" style="display: table-row">
							<td colspan="7">자료가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose> 
			</tbody>
		</table>
	</div>
</body>
</html>