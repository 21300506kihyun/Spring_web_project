<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
</head>
<body>
	<div class="adminTop_container adminTop_card">
  		<p class="adminTop_currentPage"><% out.println(session.getAttribute("adminNowPage")); %></p>
  		<div class="adminTop_btnContainer">
  			<% if(session.getAttribute("adminNowPage") != null){
			 	if((String)session.getAttribute("adminNowPage") == "상품관리"){ %>  
			 		<a href="adminProductNew" class="adminTop_btn adminTop_btnBlue">상품등록</a>
			 	<% } %>
			 	<% if((String)session.getAttribute("adminNowPage") == "상품추가"){ %>  
			 		<a href="adminProduct" class="adminTop_btn adminTop_btnWhite">취소</a>
			 		<a href="#addNewProduct" class="adminTop_btn adminTop_btnBlue" onclick="adminProductNewSubmit()">저장</a>
			 	<% } %>
			 	<% if((String)session.getAttribute("adminNowPage") == "상품 상세정보"){ %>  
			 		<a href="adminProduct" class="adminTop_btn adminTop_btnWhite">취소</a>
			 		<a href="#addNewProduct" class="adminTop_btn adminTop_btnBlue" onclick="adminProduct_ModifyDetailSubmit()">저장</a>
			 	<% } %>
			 	<% if((String)session.getAttribute("adminNowPage") == "주문관리"){ %>  
			 		
			 	<% } %>
			 	<% if((String)session.getAttribute("adminNowPage") == "배송관리"){ %>  
		 		
			 	<% } %>
			 	<% if((String)session.getAttribute("adminNowPage") == "배송자관리"){ %>  
		 			<a href="adminDeliverymanNew" class="adminTop_btn adminTop_btnBlue">배송자 추가하기</a>
			 	<% } %>
			 	<% if((String)session.getAttribute("adminNowPage") == "배송자 추가하기"){ %>  
		 			<a href="adminDeliveryman" class="adminTop_btn adminTop_btnWhite">취소</a>
		 			<a id="superAdmin_submit01" class="adminTop_btn adminTop_btnGrey superAdminSubmitButton">저장</a>
			 	<% } %>
			 	<% if((String)session.getAttribute("adminNowPage") == "배송자 상세정보"){ %>  
		 			<a href="adminDeliveryman" class="adminTop_btn adminTop_btnWhite">취소</a>
		 			<a id="superAdmin_submit01" class="adminTop_btn adminTop_btnBlue superAdminSubmitButton" onclick="">저장</a>
		 	<% }
			 	
  			}	%>
  		</div>
  	</div>
</body>
</html>