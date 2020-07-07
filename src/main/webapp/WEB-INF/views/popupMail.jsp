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

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <!-- 여기에 스크립트 추가 -->
  <script src='https://www.google.com/recaptcha/api.js'></script>

  <script>
    $(document).ready(function() {
      $("#test_btn").click(function() {
        $.ajax({
          url: '/VerifyRecaptcha',
          type: 'post',
          data: {
            recaptcha: $("#g-recaptcha-response").val()
          },
          success: function(data) {
            switch (data) {
              case 0:
                alert("자동 가입 방지 봇 통과");
                document.getElementById("captcha").style.display = "";
                break;

              case 1:
                alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
                break;

              default:
                alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
                break;
            }
          }
        });
      });
    });
  </script>

</head>

<body>
  <div class="dim-layer">
    <div class="dimBg" style="cursor: pointer" onclick="$('.dim-layer').fadeOut()"></div>
    <div id="form-mail-popup" class="pop-layer">
      <div class="pop-container">
        <div class="pop-conts">
          <!--content //-->
          <div class="popup-container">
            <h4 class="popup-title">사이트 관리자에게 문의 바랍니다.</h4>
            <p>오메란 웹 사이트의 회원 신청이 비활성화 되었습니다. 관리자에게 문의 바랍니다.</p>

            <form action="${pageContext.request.contextPath}/mailSending" method="post">
              <div align="center">
                <!-- 받는 사람 이메일 -->
                <input type="hidden" name="tomail" placeholder="보낼 사람의 이메일을 입력해 주세요" value="21300506@handong.edu" class="form-control">
              </div>
              <div align="center">
                <!-- 제목 -->
                <input type="text" name="title" placeholder="제목을 입력해주세요" class="form-control">
              </div>
              <p>
              <div align="center">
                <!-- 내용 -->
                <textarea name="content" cols="12" rows="12" placeholder="보내시는 분 메일과, 번호 , 문의사항을 입력해주세요" class="form-control"></textarea>
              </div>
              <p>
                <!--recaptcha -->
              <div class="g-recaptcha" data-sitekey="6LcYU6wZAAAAAD3_mJDSd6KCwmAWIPSc5yeV9QGj"></div>
              <button id="test_btn">테스트 버튼</button>
              <div align="center">
                <div style="display:none" id="captcha">
                  <input type="submit" id="smbt" value="메일 보내기" class="popup-submit">
                </div>
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
