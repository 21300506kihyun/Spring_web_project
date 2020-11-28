<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
</head>

<body>
  <a href="faq" class="popup-btn">FAQ</a>
  <p>|</p>
  <% String userName = (String)session.getAttribute("user_name");
  int status = -9;
  if(session.getAttribute("user_category") != null){
	  status = (int)session.getAttribute("user_category");
  }
  if(userName != null){ 
  	if(status == -2){ %>
  		<a href="<%= request.getContextPath() %>/superAdmin"><% out.println(session.getAttribute("user_name")); %> 님</a>
  	<% }else if (status == -1){  %>
  		<a href="<%= request.getContextPath() %>/<% out.println(session.getAttribute("adminSiteName")); %>/admin"><% out.println(session.getAttribute("user_name")); %> 관리자님</a>
  	<% }else if (status == 0){  %>
		<a href="<%= request.getContextPath() %>/#delivery"><% out.println(session.getAttribute("user_name")); %> 배송기사님</a>
	<% }else{  %>
  		<a href="#mypage"><% out.println(session.getAttribute("user_name")); %> 고객님</a>
  	<% } %>
	<p>|</p>
	<a onclick="moveAjax('logout.do')" class="popup-btn">로그아웃</a>
  <% }else{ %>
   	<a href="#login" class="popup-btn">로그인</a>
  <% } %>
  <p>|</p>
  <a href="#form-mail-popup" class="popup-btn">회원가입</a>
  <p>|</p>
  <a href="#form-mail-popup" class="popup-btn">리셀러 회원신청</a>
</body>

</html>
