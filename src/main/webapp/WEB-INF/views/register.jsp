
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
							  <% String userName = (String)session.getAttribute("userName");
  							if(userName != null){ %>
							  	<a href="#mypage"><% out.println(session.getAttribute("userName")); %> 님</a>
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
<form>
	<div class="form-row">
		<div class="col form-group">
			<label>아이디</label>   
		  	<input id = "u_id" type="text" class="form-control" placeholder="">
		</div> 
    	<div class="form-group">
    		<label>   </label> 
        	<button id="ckbt" type="submit" class="btn btn-primary btn-block" onclick="idCheck()" value="N"> 중복체크 </button>
    	</div>
	</div> 
	<div class="form-row">
		<div class="col form-group">
			<label>비밀번호</label>   
		  	<input id = "pw" type="text" class="form-control" placeholder="">
		</div> 
	</div> 
	<div class="form-row">
		<div class="col form-group">
			<label>비밀번호 확인</label>   
		  	<input type="text" class="form-control" placeholder="">
		</div> 
	</div> 
	<div class="form-row">
		<div class="col form-group">
			<label>이름</label>   
		  	<input id = "name" type="text" class="form-control" placeholder="">
		</div> 
	</div> 
	<div class="form-group">
		<label>이메일</label>
		<input id = "email" type="email" class="form-control" placeholder="omeran@egg.com">
	</div> 
	<div class="form-group">
		<label>휴대폰번호</label>
		<input id = "tel" type="tel" class="form-control" placeholder="숫자만 입력하세요">
	</div> 
	<div class="form-group">
			<label class="form-check form-check-inline">
		  <input id = "male" class="form-check-input" type="radio" name="gender" value="option1">
		  <span class="form-check-label"> 남자 </span>
		</label>
		<label class="form-check form-check-inline">
		  <input id = "femail" class="form-check-input" type="radio" name="gender" value="option2">
		  <span class="form-check-label"> 여자 </span>
		</label>
	</div> <!-- form-group end.// -->
	<div class="form-row">
		<div class="form-group col-md-6">
		  <label>City</label>
		  <input type="text" class="form-control">
		</div> <!-- form-group end.// -->
		<div class="form-group col-md-6">
		  <label>Country</label>
		  <select id="inputState" class="form-control">
		    <option> Choose...</option>
		      <option>Uzbekistan</option>
		      <option>Russia</option>
		      <option selected="">United States</option>
		      <option>India</option>
		      <option>Afganistan</option>
		  </select>
		</div> <!-- form-group end.// -->
	</div> <!-- form-row.// -->
	<div class="form-group">
		<label>Create password</label>
	    <input class="form-control" type="password">
	</div> <!-- form-group end.// -->  
    <div class="form-group">
        <button id = "submit" type="submit" class="btn btn-primary btn-block"> Register  </button>
    </div> <!-- form-group// -->      
    <small class="text-muted">By clicking the 'Sign Up' button, you confirm that you accept our <br> Terms of use and Privacy Policy.</small>                                          
</form>
</article> <!-- card-body end .// -->
<div class="border-top card-body text-center">Have an account? <a href="">Log In</a></div>
</div> <!-- card.// -->
</div> <!-- col.//-->
</div> <!-- row.//-->
</div> 

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

 
</script>

</body>

</html>