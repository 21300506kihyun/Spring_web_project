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
			 	if((String)session.getAttribute("adminNowPage") == "가입 쇼핑몰 관리"){ %>  
			 		<a href="superAdminNewMall" class="adminTop_btn adminTop_btnBlue">쇼핑몰 추가</a>
			 	<% } %>
			 	<% if((String)session.getAttribute("adminNowPage") == "신규 쇼핑몰 생성"){ %>  
			 		<a href="superAdmin" class="adminTop_btn adminTop_btnWhite">취소</a>
			 		<a class="adminTop_btn adminTop_btnBlue" onclick="superAdmin_createNewMall();">저장</a>
		 		<% } %>
			 	<% if((String)session.getAttribute("adminNowPage") == "쇼핑몰 관리하기"){ %>  
			 		<a href="superAdmin" class="adminTop_btn adminTop_btnWhite">취소</a>
			 		<a class="adminTop_btn adminTop_btnBlue" onclick="superAdmin_modifyMall();">저장</a>
		 		<% } %>
			 	<% if((String)session.getAttribute("adminNowPage") == "신규 쇼핑몰 관리자 생성"){ %>  
			 		<a href="superAdminMallManager" class="adminTop_btn adminTop_btnWhite">취소</a>
			 		<a id="superAdmin_submit02" class="adminTop_btn adminTop_btnGrey superAdminSubmitButton">저장</a>
		 		<% } %>
			 	<% if((String)session.getAttribute("adminNowPage") == "쇼핑몰 관리자 관리"){ %>  
			 		<a href="superAdminNewAdmin" class="adminTop_btn adminTop_btnBlue">쇼핑몰 관리자 추가</a>
			 	<% } %>
			 	<% if((String)session.getAttribute("adminNowPage") == "관리자 관리하기"){ %>  
			 		<a href="superAdminMallManager" class="adminTop_btn adminTop_btnWhite">취소</a>
					<a id="superAdmin_submit01" class="adminTop_btn adminTop_btnBlue superAdminSubmitButton" onclick="superAdmin_modifyDetailAdmin();">저장</a>
			 	<% } %>
			 	<% if((String)session.getAttribute("adminNowPage") == "플랫폼 유저 관리"){ %>  
		 		<% } %>
		 		<% if((String)session.getAttribute("adminNowPage") == "플랫폼 유저 상세정보"){ %>
					<a href="superAdminCustomer" class="adminTop_btn adminTop_btnWhite">취소</a>
					<a id="superAdmin_submit01" class="adminTop_btn adminTop_btnBlue superAdminSubmitButton" onclick="superAdmin_modifyDetailCustomer()">저장</a>
		 		<% } 
  			}	%>
  			
  		</div>
  	</div>
</body>
</html>