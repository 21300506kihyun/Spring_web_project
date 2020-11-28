
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<title>고용량 오메가3 함요 : 자연방사유정란 오메란</title>
	<%@ include file="./header.jsp" %>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

</head>

<body>
    <jsp:include page="./popupMail.jsp"></jsp:include>
    <jsp:include page="./mobSidebar.jsp"></jsp:include>
    <jsp:include page="./login.jsp"></jsp:include>
    <jsp:include page="./mobOpenSidebar.jsp"></jsp:include>

    <!-- Header Section Begin -->
    <header class="header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-3 col-lg-2">
                    <div class="header__logo">
                        <h1><a href="index">Omeran</a></h1>
                    </div>
                </div>
                <div class="col-xl-6 col-lg-7">
                    <nav class="header__menu">
                        <ul>
                            <li class="active"><a href="index">Home</a></li>
                            <li><a href="p2">오메란은?</a></li>
                            <li><a href="p3">오메란 제품 소개</a></li>
                            <li><a href=".p4">오메란의 효능</a></li>
                            <li><a href="mall">오메란 쇼핑몰</a>
                            </li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-3">
                    <div class="header__right">
                        <div class="header__right__auth">
					      <div id="top_right" class="p2_util p1_util only-pc">
					        <a href="faq" class="popup-btn">FAQ</a>
							  <% String userName = (String)session.getAttribute("user_name");
  							if(userName != null){ %>
							  	<a href="#mypage"><% out.println(session.getAttribute("user_name")); %> 님</a>
								<a onclick="moveAjax('logout.do')" class="popup-btn">로그아웃</a>
							  <% }else{ %>
							   	<a href="#login" class="popup-btn">로그인</a>
							  <% } %>
							  <a href="register" class="popup-btn">회원가입</a>
							  <a href="#form-mail-popup" class="popup-btn">리셀러 회원신청</a>
					      </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="canvas__open">
                <i class="fa fa-bars"></i>
            </div>
        </div>
    </header>
    <!-- Header Section End -->
    

<div class="container">
	<br>  <h1 class="text-center">회원가입</h1>
	<hr>
	<div class="row justify-content-center">
		<div class="col-md-6">
			<div class="card">
				<header class="card-header">
					<a href="" class="float-right btn btn-outline-primary mt-1">로그인</a>
				</header>
				<article class="card-body">
					<form action="register" method="POST">
						<div class="form-row">
							<div class="col form-group">
								<label>아이디</label>   
							  	<input name = "user_id" id = "u_id" type="text" class="form-control" placeholder="">
							</div> 
					    	<div class="form-group">
					    		<label>   </label> 
					        	<button id="ckbt" type="button" class="btn btn-primary btn-block" onclick="idCheck()" value="N"> 중복체크 </button>
					    	</div>
						</div> 
						<div class="form-row">
							<div class="col form-group">
								<label>비밀번호</label>   
							  	<input name = "password" id = "pw" type="password" class="form-control" placeholder="">
							</div> 
						</div> 
						<div class="form-row">
							<div class="col form-group">
								<label>비밀번호 확인</label>   
							  	<input id = "pw_ck" type="password" class="form-control" placeholder="" required>
							</div> 
						</div> 
						<div class="form-row">
							<div class="col form-group">
								<label>이름</label>   
							  	<input name = "user_name" id = "name" type="text" class="form-control" placeholder="">
							</div> 
						</div> 
						<div class="form-group">
							<label>이메일</label>
							<input name = "email" id = "email" type="email" class="form-control" placeholder="omeran@egg.com">
						</div> 
						<div class="form-group">
							<label>휴대폰번호</label>
							<input name = "telephone" id = "tel" type="tel" class="form-control" placeholder="000-0000-0000" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">
						</div> 
						<div class="form-group">
								<label class="form-check form-check-inline">
							  <input id = "male" class="form-check-input" type="radio" name="gender" value=1 required>
							  <span class="form-check-label"> 남자 </span>
							</label>
							<label class="form-check form-check-inline">
							  <input id = "femail" class="form-check-input" type="radio" name="gender" value=0 required>
							  <span class="form-check-label"> 여자 </span>
							</label>
						</div> <!-- form-group end.// -->
						<div class="form-row">
							<div class="form-group">
								<input type="text" class="form-control" style="width:200px;" id="postcode" name="postcode" placeholder="우편번호">
							</div>
							<div class="form-group">
								<button type="button" style="margin-left:20px;" class="btn btn-primary btn-block"  onclick="sample6_execDaumPostcode()"> 우편번호 찾기 </button>
							</div>
						</div> <!-- form-row.// -->
						<div class="form-row">
							<div class="form-group">
								<input type="text" style="width:500px;" class="form-control" id="address" name="address" placeholder="주소"><br>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group">
								<input type="text"  style="width:500px; margin-top:-20px;" class="form-control" id="detailAddress" name="detailAddress" placeholder="상세주소">
							</div>
						</div>
						<input type="text" style="display:none" id="sample6_extraAddress" placeholder="참고항목">
						
						
						<div class="form-group">
							<label>추천인 아이디(선택)</label>
						    <input name ="recommander_id" id="regi_recommander" class="form-control" type="text">
						</div> <!-- form-group end.// -->  
					    <div class="form-group">
					        <button id = "submit" type="submit" class="btn btn-primary btn-block"> 회원가입  </button>
					    </div> <!-- form-group// -->      
					    <small class="text-muted">By clicking the 'Sign Up' button, you confirm that you accept our <br> Terms of use and Privacy Policy.</small>                                          
					</form>
				</article> <!-- card-body end .// -->
			</div> <!-- card.// -->
		</div> <!-- col.//-->
	</div> <!-- row.//-->
</div> 



<!--  *********** 다음 주소 API ***********  -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("address").value = extraAddr;
                
                } else {
                    document.getElementById("address").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
<script>
	
		function idCheck(){
			 $.ajax({
				 async : false,
				 url : "register_idCheck",
				 type : "post",
				 dataType : "json",
				 data : {"user_id" : $("#u_id").val()},
				 success : function(data){
					 if(data == 1)
						 alert("중복된 아이디 입니다");
					 else{
						 $("#ckbt").attr("value","Y");
						 alert("사용가능한 아이디 입니다");
					 	}
				 },
				 error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				 }
				 })
		 }
		
		$("#submit").on("click", function(){
			if($("#u_id").val()==""){
				alert("아이디를 입력해주세요.");
				$("#u_id").focus();
				return false;
			}
			if($("#pw").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#pw").focus();
				return false;
			}
			if($("#name").val()==""){
				alert("성명을 입력해주세요.");
				$("#name").focus();
				return false;
			}
			if($("#email").val()==""){
				alert("이메일을 입력해주세요.");
				$("#email").focus();
				return false;
			}
			if($("#tel").val()==""){
				alert("핸드폰번호를 입력해주세요.");
				$("#tel").focus();
				return false;
			}
			if($("#pw").val() != $("#pw_ck").val() ){
				alert("비밀번호가 서로 같지 않습니다");
				return false;
			}
		});
 
</script>

</body>

</html>