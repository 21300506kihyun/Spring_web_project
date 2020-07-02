<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<title>고용량 오메가3 함요 : 자연방사유정란 오메란</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width">
<link href="css/common.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/common.js"></script>
</head>
<body>
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
					      <input type="hidden" name="tomail" placeholder="보낼 사람의 이메일을 입력해 주세요" value="21300506@handong.edu" class="form-control" >
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
</body>
</html>