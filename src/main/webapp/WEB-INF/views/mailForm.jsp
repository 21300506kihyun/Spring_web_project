<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">

  <!-- Bootstrap -->
  <link href='<c:url value="/css/bootstrap.min.css" />' rel="stylesheet">
  <link href='<c:url value="/css/kfonts2.css" />' rel="stylesheet">

  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
  <script src='<c:url value="/jquery/jquery-1.11.3.min.js" />'></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src='<c:url value="/js/bootstrap.min.js"  />'></script>

  <title>메일 보내기</title>
</head>

<body>
  <header id="p2_header">
    <img src="img/p1_top_banner.png" class="p1_top_banner">
    <a href="index" class="p2_top_logo" id="p1_top_logoc"><img src="img/p1_top_logo.png" alt=""></a>
  </header>
  <div class="container">
    <h4>문의하기</h4>
    <form action="${pageContext.request.contextPath}/mailSending" method="post">
      <div align="center">
        <!-- 받는 사람 이메일 -->
        <input type="text" name="tomail" size="120" style="width:100%" value="21300506@handong.edu" class="form-control">
      </div>
      <div align="center">
        <!-- 제목 -->
        <input type="text" name="title" size="120" style="width:100%" placeholder="제목을 입력해주세요" class="form-control">
      </div>
      <p>
      <div align="center">
        <!-- 내용 -->
        <textarea name="content" cols="120" rows="12" style="width:100%; resize:none" placeholder="보내시는 분 메일과, 번호 , 문의사항을 입력해주세요" class="form-control"></textarea>
      </div>
      <p>
      <div align="center">
        <input type="submit" value="메일 보내기" class="btn btn-warning">
      </div>
    </form>
  </div>
</body>

</html>
