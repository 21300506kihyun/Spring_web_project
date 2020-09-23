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
  		<p class="adminTop_currentPage">${isOpen}</p>
  		<div class="adminTop_btnContainer">
		 	<% if((String)session.getAttribute("adminNowPage") == "상품관리"){ %>  
		 		<a href="#addProduct" class="adminTop_btn adminTop_btnBlue">상품등록</a>
		 	<% } %>
		 	<!-- TODO: 보여주기용으로 표시한 것. 나중에는 상품추가나 수정란에서 표시되도록 하기. -->
		 	<% if((String)session.getAttribute("adminNowPage") == "주문관리"){ %>  
		 		<a href="#cancel" class="adminTop_btn adminTop_btnWhite">취소</a>
		 		<a href="#addProduct" class="adminTop_btn adminTop_btnBlue">저장</a>
		 	<% } %>
  		</div>
  	</div>
</body>
</html>