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
	function setUpdateAsDelete(id){
		setValueAs_1_byId(id);
	}
	
	function superAdmin_simpleUpdate_formCheck(){
		if($("#superAdmin_isDelete").val() == 1){
			if(!confirm("해당 유저를 삭제하시겠습니까?")){
				return false;
			}
		}
		else{
			if(!confirm("해당 유저의 정보를 수정하시겠습니까?")){
				return false;
			}
		}
		return true;
	}

	function superAdmin_simpleUpdate(){
		if(!superAdmin_simpleUpdate_formCheck()){
			return false;
		}
		
		// formID, postURL, replaceArea
		simpleUpdate(
				"superAdminCustomer_simpleUpdateForm", 
				"superAdminCustomer_simpleUpdate",
				"adminProduct_content");
	}
	</script>
</head>
<body>
	<form id="superAdminCustomer_simpleUpdateForm" onsubmit="return superAdmin_simpleUpdate()">
	<div class="adminProduct_cardContainer productStatus_extend">
		<p class="adminProduct_statusText">선택 사용자를 </p>
		<input type="hidden" name="currentPage" value="${pagination.curPage}" />
		<input name="superAdmin_memo" id="adminProduct_change_originPrice_input" 
				class="adminProduct_statusInput" type="text" placeholder="메모를 입력해주세요." autocomplete="off">
		<a id="adminProduct_closeInputBtn01" class="adminProduct_closeInputBtn" onclick="resetInput('adminProduct_change_originPrice_input');">x</a>
		<a id="adminProduct_change_originPrice" class="adminProduct_statusBtn">메모</a>
		
		<!-- adminProduct_productItem[]이 어레이로 나오기 위해서 -->
		<input type="hidden" name="superAdminCustomer_uids[]" value="-1"/>
		
		<!-- 삭제? or 수정? -->
		<input id="superAdmin_isDelete" type="hidden" name="superAdmin_isDelete" value="0"/>
		
		<input type="submit" class="adminProduct_statusBtn adminProduct_btnSubmit" value="수정"/>
		<input type="submit" class="adminProduct_statusBtn adminProduct_btnDelete" onclick="setUpdateAsDelete('superAdmin_isDelete')" value="삭제"/>
	</div>
	<div class="adminProduct_cardContainer adminProduct_productContainer">
		<table id="productList_all" class="superAdminProduct_table">
			<thead>
				<tr class="productStatus_basic">
					<th><input type="checkbox" name="" class="adminProduct_checkAll"></th>
					<th>ID</th>
					<th>이름</th>
					<th>이메일</th>
					<th>휴대전화</th>
					<th>메모</th>
					<th>생성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${userVOs}" var="row" varStatus="idx">
					<tr class="adminProduct_listItem">
						<td>
							<input type="checkbox" name="superAdminCustomer_uids[]" 
								value="${row.u_id}" 
								class="adminProduct_itemCheckbox">
						</td>
						<td>${row.user_id}</td>
						<td class="adminProduct_itemName" onclick="location.href='superAdminCustomerDetail?u_id=${row.u_id}'">${row.user_name}</td>
						<td style="width: 18%;">${row.email}</td>
						<td>${row.telephone}</td>
						<td>${row.user_memo}</td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${row.signin_date}"/></td>
					</tr>
				</c:forEach>
				<c:set var="listCnt" value="${userVOs.size()}"/>
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
           <li class="page-num"><a onclick="superAdminCustomer_search('1')"> [처음] </a></li>
         </c:if>
         <c:if test="${pagination.curPage != 1}">
           <li class="page-num"><a onclick="superAdminCustomer_search('${pagination.prevPage}')"> [이전] </a></li>
         </c:if>
         <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
           <c:choose>
             <c:when test="${pageNum == pagination.curPage}">
               <li class="page-num"><a class="page-num-selected" onclick="superAdminCustomer_search('${pageNum}')"> ${pageNum} </a></li>
             </c:when>
             <c:otherwise>
               <li class="page-num"><a onclick="superAdminCustomer_search('${pageNum}')"> ${pageNum} </a></li>
             </c:otherwise>
           </c:choose>
         </c:forEach>
         <c:if test="${pagination.curPage != pagination.pageCnt && pagination.pageCnt > 0}">
           <li class="page-num"><a onclick="superAdminCustomer_search('${pagination.nextPage}')"> [다음] </a></li>
         </c:if>
         <c:if test="${pagination.curRange != pagination.rangeCnt && pagination.rangeCnt > 0}">
           <li class="page-num"><a onclick="superAdminCustomer_search('${pagination.pageCnt}')"> [끝] </a></li>
         </c:if>
       </ul>
     </div>
     <%-- [FOR DEBUG] 총 게시글 수 : ${pagination.listCnt} / 총 페이지수 : ${pagination.pageCnt} / 현재 페이지 : ${pagination.curPage } / 현재 블럭 : ${pagination.curRange } / 총 블럭 수 : ${pagination.rangeCnt } --%>
	</form>
</body>
</html>