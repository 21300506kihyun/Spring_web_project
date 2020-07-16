<%@ page pageEncoding="utf-8"%> 
<meta charset="utf-8"> 
<meta http-equiv="X-UA-Compatible" content="IE=edge"/> 
<title>first</title> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<link rel="stylesheet" type="text/css" href="<c:url value='/css/ui.css'/>" /> 
<!-- jQuery --> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> 
<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>

</head> 
<body> 
<h2>게시판 목록</h2> 
<table style="border:1px solid #ccc"> 
<colgroup> 
<col width="10%"/> 
<col width="*"/> 
<col width="15%"/> 
<col width="20%"/> 
</colgroup> 
<thead> <tr> <th scope="col">글번호</th> <th scope="col">제목</th> <th scope="col">조회수</th> 
<th scope="col">작성일</th> </tr> </thead> 
<tbody> 
<c:forEach items="${list}" var="row"> <tr> 
<c:out value="${row.title}" />
<c:out value="${row.content}" />
</tr> </c:forEach> 
</tbody> </table> </body> </html>
