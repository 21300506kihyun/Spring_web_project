<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>

<head>
  <title>고용량 오메가3 함요 : 자연방사유정란 오메란</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <!--<link href="css/common.css" rel="stylesheet" type="text/css">-->
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" />
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/common.js"></script>
  <style>
	input[id*="faq-answer"] {display:none;}
	input[id*="faq-answer"] + label {border-radius: 5px; margin-top: 2%; display:block; padding:20px; border-bottom: 1px solid #bbb; color:#fff; 
	background:#f5b11f; cursor:pointer; position:relative; text-align: left; font-size: 20px}
	input[id*="faq-answer"] + label + div {border-radius: 5px; max-height:0; transition: all .35s; overflow:hidden; background:#eee; }
	input[id*="faq-answer"] + label + div p {display:inline-block; padding: 25px;}
	input[id*="faq-answer"]:checked + label + div {max-height:1000px;} 
  </style>
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
        <p class="faq-title">FAQ: 자주 묻는 질문</p>
        <div class="faq-mid-line"></div>
        
	    <div class="faq-div">
	      <form id="faqSearch" action="">
  	        <input type="text" id="find_input" class="faq-input" placeholder="제목을 검색해주세요.">
	        <input type="submit" class="faq-submit" value="검색하기">
	        
	        <% String userName = (String)session.getAttribute("userName");
  			if(session.getAttribute("status") != null){ 
  				if((int)session.getAttribute("status") == -1){%>
		        <input type="button" class="faq-submit" value="글쓰기" onclick="moveAjax('faqWrite')">
		        <% } 
  			} %>
	      </form>
	    </div>
        
        <div class="faq-table">
        	<div class="accordion">
				<input type="checkbox" name="accordion" id="faq-answer01">
        		<label for="faq-answer01">Q. FAQ 1번 질문입니다.</label>
				<div><p>여기에 추가되는 부분이 자주묻는 질문의 답변 내용이 들어갑니다.여기에 추가되는 부분이 자주묻는 질문의 답변 내용이 들어갑니다.여기에 추가되는 부분이 자주묻는 질문의 답변 내용이 들어갑니다.</p></div>
				
				<input type="checkbox" name="accordion" id="faq-answer02">
				<label for="faq-answer02">ex) Q. 오메란 사이트가 개발중인 현재, 오메란에 관심이 있는 경우에는 어떻게 연락해야 하나요?</label>
				<div><p>여기에 추가되는 부분이 자주묻는 질문의 답변 내용이 들어갑니다.여기에 추가되는 부분이 자주묻는 질문의 답변 내용이 들어갑니다.여기에 추가되는 부분이 자주묻는 질문의 답변 내용이 들어갑니다.</p></div>
				
				<input type="checkbox" name="accordion" id="faq-answer03">
				<label for="faq-answer03">Q. FAQ 3번 질문입니다.</label>
				<div><p>여기에 추가되는 부분이 자주묻는 질문의 답변 내용이 들어갑니다.여기에 추가되는 부분이 자주묻는 질문의 답변 내용이 들어갑니다.여기에 추가되는 부분이 자주묻는 질문의 답변 내용이 들어갑니다.</p></div>
				
				<input type="checkbox" name="accordion" id="faq-answer04">
				<label for="faq-answer04">Q. FAQ 4번 질문입니다.</label>
				<div><p>여기에 추가되는 부분이 자주묻는 질문의 답변 내용이 들어갑니다.여기에 추가되는 부분이 자주묻는 질문의 답변 내용이 들어갑니다.여기에 추가되는 부분이 자주묻는 질문의 답변 내용이 들어갑니다.</p></div>
			</div>
          <div>
	         <ul>
		         <li class="page-num"><a class="page-num-selected" href="#"> 1 </a></li>
		         <li class="page-num"><a href="#"> 2 </a></li>
		         <li class="page-num"><a href="#"> 3 </a></li>
		         <li class="page-num"><a href="#"> 4 </a></li>
		         <li class="page-num"><a href="#"> 5 </a></li>
		         <li class="page-num"><a href="#"> 6 </a></li>
		         <li class="page-num"><a href="#"> 7 </a></li>
		         <li class="page-num"><a href="#"> 8 </a></li>
		         <li class="page-num"><a href="#"> 9 </a></li>
		         <li class="page-num"><a href="#"> 10 </a></li>
		         <li class="page-num"><a href="#"> 다음 </a></li>
	         </ul>
          </div>
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
