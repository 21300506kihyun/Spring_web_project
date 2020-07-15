<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!DOCTYPE html> 
<html> 
<head> 
<title>first</title> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
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
