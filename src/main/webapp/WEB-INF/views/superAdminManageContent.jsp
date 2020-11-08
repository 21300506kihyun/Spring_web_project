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
	// Simple Delete
	function superAdminMain_simpleDelete_formCheck(){
		if(!confirm("쇼핑몰을 삭제하면 관련된 상품, 주문 등의 모든 기록도 함께 삭제되며\n다시 되돌릴 수 없습니다.\n해당 쇼핑몰을 정말로 삭제하시겠습니까?")){
			if(!confirm("쇼핑몰 삭제시 관련 상품, 주문, 관리자, 배송, 배송기록, 포인트 기록 등이 모두 소실됩니다.\n정말로 삭제하시겠습니까?")){
				return false;
			}
		}
		return true;
	}
	
	function superAdminMain_simpleDelete(){
		if(!superAdminMain_simpleDelete_formCheck()){
			return false;
		}
		var formData = $("#superAdminMain_simpleDeleteForm").serialize();
		
		console.log(formData);
		
		$.ajax({
			type: "POST",
			url: "superAdmin.delete",
			data: formData,
			dataType: "html",
			async: false,
			cache: false,
			success: function(result){
				// Contents 영역 삭제
				$('#adminProduct_content').children().remove();
				// Contents 영역 교체
				$('#adminProduct_content').html(result);
			},
			error: function(error){
				console.log(error)
			}
		});
	}
	</script>
</head>
<body>
	<form id="superAdminMain_simpleDeleteForm" onsubmit="return superAdminMain_simpleDelete()">
	<div class="adminProduct_cardContainer productStatus_extend">
		<p class="adminProduct_statusText">선택 쇼핑몰을 </p>
		
		<!-- adminProduct_productItem[]이 어레이로 나오기 위해서 -->
		<input type="hidden" name="superAdminMain_mallList[]" value="-1"/>
		
		<input type="submit" class="adminProduct_statusBtn adminProduct_btnDelete" value="삭제하기"/>
	</div>
	<div class="adminProduct_cardContainer adminProduct_productContainer">
		<table id="productList_all" class="superAdminProduct_table">
			<thead>
				<tr class="productStatus_basic">
					<th><input type="checkbox" name="" class="adminProduct_checkAll"></th>
					<!-- <th>No.</th> -->
					<th>쇼핑몰 ID</th>
					<th>쇼핑몰 관리</th>
					<th>농장 이름</th>
					<th>대표 연락처</th>
					<th>쇼핑몰 바로가기</th>
					<th>쇼핑몰 생성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${mallList}" var="row" varStatus="idx">
					<tr class="adminProduct_listItem">
						<td>
							<input type="checkbox" name="superAdminMain_mallList[]" 
								value="${row.mall_id}" 
								class="adminProduct_itemCheckbox">
						</td>
						<%-- <td>${idx.count}</td> --%>
						<td>${row.mall_id}</td>
						<td class="adminProduct_itemName" onclick="location.href='#TODO: GoToDetail?withParameter'">${row.mall_name}</td>
						<td>${row.farm_name}</td>
						<td>${row.tel}</td>
						<td style="cursor: pointer" onclick="location.href='<%= request.getContextPath() %>/${row.mall_name}'">/${row.mall_name}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${row.create_date}"/></td>
					</tr>
				</c:forEach>
				<c:set var="listCnt" value="${mallList.size()}"/>
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
	<input type="hidden" name="currentPage" value="${pagination.curPage}"/>
	<div class="paging-container">
       <ul>
         <c:if test="${pagination.curRange != 1}">
           <li class="page-num"><a onclick="superAdminMain_search('1')"> [처음] </a></li>
         </c:if>
         <c:if test="${pagination.curPage != 1}">
           <li class="page-num"><a onclick="superAdminMain_search('${pagination.prevPage}')"> [이전] </a></li>
         </c:if>
         <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
           <c:choose>
             <c:when test="${pageNum == pagination.curPage}">
               <li class="page-num"><a class="page-num-selected" onclick="superAdminMain_search('${pageNum}')"> ${pageNum} </a></li>
             </c:when>
             <c:otherwise>
               <li class="page-num"><a onclick="superAdminMain_search('${pageNum}')"> ${pageNum} </a></li>
             </c:otherwise>
           </c:choose>
         </c:forEach>
         <c:if test="${pagination.curPage != pagination.pageCnt && pagination.pageCnt > 0}">
           <li class="page-num"><a onclick="superAdminMain_search('${pagination.nextPage}')"> [다음] </a></li>
         </c:if>
         <c:if test="${pagination.curRange != pagination.rangeCnt && pagination.rangeCnt > 0}">
           <li class="page-num"><a onclick="superAdminMain_search('${pagination.pageCnt}')"> [끝] </a></li>
         </c:if>
       </ul>
     </div>
     <%-- [FOR DEBUG] 총 게시글 수 : ${pagination.listCnt} / 총 페이지수 : ${pagination.pageCnt} / 현재 페이지 : ${pagination.curPage } / 현재 블럭 : ${pagination.curRange } / 총 블럭 수 : ${pagination.rangeCnt } --%>
	</form>
</body>
</html>