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
	
	<div class="dim-layer">
	    <div class="dimBg" style="cursor: pointer" onclick="$('.dim-layer').fadeOut()"></div>
	    <div id="form-mail-popup" class="pop-layer">
	        <div class="pop-container">
	            <div class="pop-conts">
	                <!--content //-->
	                <div class="popup-container">
					  <h4>메일 보내기</h4>
					  <form action="${pageContext.request.contextPath}/mailSending" method="post">
					    <div align="center"><!-- 받는 사람 이메일 -->
					      <input type="text" name="tomail" value="21300506@handong.edu" class="form-control" >
					    </div>
					    <div align="center"><!-- 제목 -->
					      <input type="text" name="title" placeholder="제목을 입력해주세요" class="form-control" >
					    </div>
					    <p>
					    <div align="center"><!-- 내용 --> 
					      <textarea name="content" cols="12" rows="12" placeholder="보내시는 분 메일과, 번호 , 문의사항을 입력해주세요" class="form-control"></textarea>
					    </div>
					    <p>
					    <div align="center">
					      <input type="submit" value="메일 보내기" class="popup-submit">
					      <a href="#" class="btn-layerClose">닫기</a>
					    </div>
					  </form>
					</div>
	            </div>
	        </div>
	    </div>
	</div>




    <img src="img/p1_top_banner.png" class="p2_top_banner">
    <a href="index" class="p2_top_logo" id="p1_top_logoc"><img src="img/p1_top_logo.png" alt=""></a>
    <div class="p2_util p1_util">
        <a href="#">로그인</a>
        <p>|</p>
        <a href="#">회원가입</a>
        <p>|</p>
        <a href="mailForm" class="btn-example">리셀러 회원신청</a>
    </div>
    <div class="p2_menu01" id="p1_menu01">
        <p>고용량 오메가3</p>
        <ul>
            <li><a href="p2">오메란은?</a></li>
            <li><a href="p4">오메란 제품소개</a></li>
        </ul>
    </div>
    <div class="p2_menu02" id="p1_menu02">
        <p>오메가3 계란</p>
        <ul>
            <li><a href="p3">오메가의 효능</a></li>
            <li><a href="p5">오메란 쇼핑몰</a></li>
        </ul>
    </div>
</header>

<div id="p1_mid">
    <div class="p1_thro_line"></div>
    <div class="p1_mid_menu">
        <a href="#">오메란의 특별한 생산환경</a>
        <p>|</p>
        <a href="#">오메란의 오메가 함유</a>
        <p>|</p>
        <a href="#">오메가3의 장점</a>
    </div>
</div>

<footer id="p2_footer">
    <ul>
        <li>
            <img src="img/p2_footer_logo.png" alt="">
        </li>
        <li>
            <ul>
                <li><a href="#">리셀러 회원안내</a></li>
                <li><p>|</p></li>
                <li><a href="#">개인정보처리방침</a></li>
                <li><p>|</p></li>
                <li><a href="#">개인정보 제공내역 공지</a></li>
                <li><p>|</p></li>
                <li><a href="#">정고공개안내</a></li>
                <li><p>|</p></li>
                <li><a href="#">이메일무단수집거부</a></li>
            </ul>
            <p class="p1_fo_p1">Copyright (C) <span>OMERANMALL</span> All right reserved.</p>
            <p class="p1_fo_p2">엠투테크(주)</p>
            <p class="p1_fo_p3">광주광역시 북구 추암로 249, 3D 융합상용화지원센터 303호</p>
            <p class="p1_fo_p4">Tel. 062-955-262 Fax.062-955-2623</p>
        </li>
    </ul>
</footer>
</div>

<!— 모바일 시작 —>
<div id="omeran_mob_all">
<div id="m_index">
<img src="img/m_index.png" id="m_main_img">
<a href="p1.html" id="m_logo_area"></a>

<div id="m_p1_header">
    <a href="p2.html">오메란은? </a>
    <a href="p4.html">오메란 제품소개 </a>
    <a href="p3.html">오메가의 효능 </a>
    <a href="p5.html">오메란 쇼핑몰</a>
</div>

<div id="m_p1_foo_menu">
    <ul>
        <li><a href="#">오메란의 특별한 생산환경</a></li>
        <li><p>|</p></li>
        <li><a href="#">오메란의 오메가 함유</a></li>
        <li><p>|</p></li>
        <li><a href="#">오메가3의 장점</a></li>
    </ul>
</div>

</div>

<div id="m_p1_footer">
    <ul>
        <li>
            <img src="img/m_logo.png" alt="">
        </li>
        <li>
            <p class="p1_fo_p0">
                리셀러 회원안내 | 개인정보처리방침<br>
                개인정보 제공내역 공지 | 정보공개안내<br>
                이메일무단수집거부
            </p>
            <p class="p1_fo_p1">Copyright (C) <span>OMERANMALL</span> All right reserved.</p>
            <p class="p1_fo_p2">엠투테크(주)</p>
            <p class="p1_fo_p3">광주광역시 북구 추암로 249, 3D 융합상용화지원센터 302호</p>
            <p class="p1_fo_p4">Tel. 062-955-262 Fax.062-955-2623</p>
        </li>
    </ul>
</div>
</div>

</body>
</html>