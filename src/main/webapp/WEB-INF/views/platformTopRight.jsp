<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
</head>

<body>
  <ul class="navbar-nav ml-auto">
    <li class="nav-item active">
      <a class="nav-link" href="${pageContext.request.contextPath}/">메인
        <span class="sr-only">(current)</span>
      </a>
    </li>

    <% String userName = (String)session.getAttribute("user_name");
    int status = -9;
    if(session.getAttribute("user_category") != null){
  	  status = (int)session.getAttribute("user_category");
    }
    if(userName != null){ %>
  	  <li class="nav-item">
  	    <% if(status == -2){ %>
  	    	<a href="<%= request.getContextPath() %>/superAdmin" class="nav-link"><% out.println(session.getAttribute("user_name")); %> 님</a>
  	    <% }else if (status == -1){  %>
  	    	<a href="<%= request.getContextPath() %>/<% out.println(session.getAttribute("adminSiteName")); %>/admin" class="nav-link"><% out.println(session.getAttribute("user_name")); %> 관리자님</a>
  	    <% }else if (status == 0){  %>
  	    	<a href="<%= request.getContextPath() %>/#delivery" class="nav-link"><% out.println(session.getAttribute("user_name")); %> 배송기사님</a>
  	    <% }else{  %>
  	    	<a href="#mypage" class="nav-link"><% out.println(session.getAttribute("user_name")); %> 고객님</a>
  	    <% } %>
  	  </li>
  	  <li class="nav-item">
  	    <a class="nav-link popup-btn" onclick="moveAjax('logout.do')">로그아웃</a>
  	  </li>
    <% }else{ %>
  	  <li class="nav-item">
  	    <a class="nav-link popup-btn" href="#login">로그인</a>
  	  </li>
  	  <li class="nav-item">
  	    <a class="nav-link" href="register">회원가입</a>
  	  </li>
    <% } %>
    <li class="nav-item">
      <a class="nav-link popup-btn" href="#form-mail-popup">문의하기</a>
    </li>
  </ul>
</body>

</html>
