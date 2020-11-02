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
			 	if((String)session.getAttribute("adminNowPage") == "플랫폼 관리자 관리"){ %>  
			 		<a href="#newAdmin" class="adminTop_btn adminTop_btnBlue">관리자 추가</a>
			 	<% }
  			}	%>
  		</div>
  	</div>
</body>
</html>