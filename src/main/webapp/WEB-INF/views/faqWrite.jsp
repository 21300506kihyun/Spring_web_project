<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
  <title>고용량 오메가3 함요 : 자연방사유정란 오메란</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <!--<link href="css/common.css" rel="stylesheet" type="text/css">-->
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" />
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/common.js"></script>
</head>

<body>
  <div id="omeran_pc_all">

    <header id="p2_header">

      <jsp:include page="./popupMail.jsp"></jsp:include>

      <img src="img/p1_top_banner.png" class="p2_top_banner">
      <a href="index" class="p2_top_logo" id="p1_top_logoc"><img src="img/p1_top_logo.png" alt=""></a>
      <div class="p2_util p1_util">
        <jsp:include page="./topRight.jsp"></jsp:include>
      </div>
      <div class="p2_menu01" id="p1_menu01">
        <jsp:include page="./menuLeft.jsp"></jsp:include>
      </div>
      <div class="p2_menu02" id="p1_menu02">
        <jsp:include page="./menuRight.jsp"></jsp:include>
      </div>
    </header>
    
    <jsp:include page="./login.jsp"></jsp:include>

    <div class="faq-mid">
      <div class="faq-mid-menu">
        <p class="faq-title">FAQ 글쓰기 (관리자 전용)</p>
        <div class="faq-mid-line"></div>

		<div class="faq-write-container">
		  <form name="faq-write" action="" method="post">
		  	<input type="hidden" name="writer" value="관리자">
			<div class="faq-input-container">
				<p class="faq-label">제목</p>
				<input name="title" type="text" class="faq-form-input" placeholder="FAQ 게시판에 노출될 질문의 제목을 입력해주세요. ex) [결제관련] 결제는 어떻게 진행되나요?">
			</div>
			<div class="faq-input-container">
				<p class="faq-label">FAQ 답변</p>
				<textarea name="content" rows="6" cols="50" placeholder="ex)
Q. '[결제관련] 결제는 어떻게 진행되나요?' 의 답변입니다.
A. 질문에 대한 답변을 달아주세요." class="faq-form-input"></textarea>
			</div>
			<div class="faq-btn-container">
				<input type="button" class="faq-submit" value="뒤로가기" onclick="location.href='faq'">
				<input type="submit" class="faq-submit" value="글쓰기">
			</div>
		  </form>
		</div>
        
      </div>
    </div>

    <jsp:include page="./footer.jsp"></jsp:include>
  </div>

  <!-- 모바일 시작 -->
  <div id="omeran_mob_all">  
    <div id="m_index">
      <img src="img/m_index.png" id="m_main_img">
      <a href="p1.html" id="m_logo_area"></a>

      <div id="m_p1_header">
        <jsp:include page="./mobMenu.jsp"></jsp:include>
      </div>

      <div id="m_p1_foo_menu">
        <ul>
          <li><a href="#" class="m_index_main">오메란의 특별한 생산환경</a></li>
          <li><p>|</p></li>
          <li><a href="#" class="m_index_main">오메란의 오메가 함유</a></li>
          <li><p>|</p></li>
          <li><a href="#" class="m_index_main">오메가3의 장점</a></li>
        </ul>
      </div>

    </div>

    <div id="m_p1_footer">
      <jsp:include page="./mobFooter.jsp"></jsp:include>
    </div>
  </div>

</body>

</html>
