<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
  <title>자연방사유정란 오메란: 로그인 페이지 </title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" />
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/common.js"></script>
</head>

<body>
  <!-- 로그인 -->
  <!-- <div class="login-mid">
      <div class="login-mid-menu">
        <p class="login-title">로그인 </p>
        <div class="login-mid-line"></div>
        <form action="">
	      <div class="login-div">
  	        <input type="text" id="input_id" class="login-input" placeholder="아이디를 입력해주세요">
	      </div>
	      <div class="login-div">
	        <input type="password" id="input_pw" class="login-input" placeholder="비밀번호를 입력해주세요">
	      </div>
	      <div class="login-div">
	        <input type="submit" class="login-submit" value="로그인">
	      </div>
        </form>
      </div>
    </div> -->

  <div class="login-dim-layer">
    <div class="login-dimBg" style="cursor: pointer" onclick="$('.login-dim-layer').fadeOut()"></div>
    <div id=login class="pop-layer">
      <div class="pop-container">
        <div class="pop-conts">
          <!--content //-->
          <div class="popup-container">
            <div class="login-mid">
              <p class="login-title">로그인 </p>
              <p class="login-font">*해당 사이트는 개발중에 있습니다.<br>현재는 관리자만 로그인 할 수 있습니다.</p>
              <div class="login-mid-line"></div>
              <form id="loginForm" action="" onsubmit="return loginCheck('loginForm')" >
                <div class="login-div">
                  <input name="id" type="text" id="input_id" class="login-input" placeholder="아이디를 입력해주세요">
                </div>
                <div class="login-div">
                  <input name="pw" type="password" id="input_pw" class="login-input" placeholder="비밀번호를 입력해주세요">
                </div>
                <div class="login-div">
                  <input type="submit" class="login-submit" value="로그인">
                  <input type="button" class="btn-login-submit login-submit" value="닫기">
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <script>
	  function loginCheck(formName){
	  	var valid = true;
	  	var form = $('#' + formName);
	  	form.find('input').each(function(key){
	  		var obj = $(this);
	  		var type = obj.prop("name");
	  		if(isEmpty(obj.val())){
	  			if(type == "id"){
	  				text = "아이디를 입력해주세요";
	  				alert(text);
	  				valid = false;
	  			}
	  			else if(type == "pw"){
	  				text = "비밀번호를 입력해주세요";
	  				alert(text);
	  				valid = false;

	  			}
	  			return false;
	  		}
	  	});
	  	if(valid){
	  		return true;
	  	}
	  	return false;
	  }

	  function isEmpty(val){
	  	if(val == null || typeof val == "undefind" || val.trim().length < 1){
	  		return true;
	  	}
	  	return false;
	  }
  </script>

</body>

</html>
