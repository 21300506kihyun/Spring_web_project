<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" />
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/common.js"></script>
</head>

<body>
  <a href="faq" class="popup-btn">FAQ</a>
  <p>|</p>
  <c:choose>
  	<c:when test="${login == 'success'}">
  	  <a href="#mypage">${userVO.userName} 님</a>
  	  <p>|</p>
	  <a href="#login" class="popup-btn">로그아웃</a>
  	</c:when>
  	<c:otherwise>
	  <a href="#login" class="popup-btn">로그인</a>
  	</c:otherwise>
  </c:choose>
  <p>|</p>
  <a href="#form-mail-popup" class="popup-btn">회원가입</a>
  <p>|</p>
  <a href="#form-mail-popup" class="popup-btn">리셀러 회원신청</a>
</body>

</html>
