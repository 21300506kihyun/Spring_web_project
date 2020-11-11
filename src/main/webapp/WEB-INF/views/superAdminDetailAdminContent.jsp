<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style>
	/* This page only */
	input:not([type="file"]):focus{
		border-bottom: 2px solid #1a6dff;
	}
	</style>
	<script>
		$(document).ready(function(){
			$("#superAdmin_gender").val(${userInfo.gender});
			$("#superAdmin_mall_id").val(${userInfo.mall_id});
		});
		
		function superAdmin_modifyDetailAdminTest(){
			if($("#superAdmin_id").val().length == 0){
				alert("관리자 아이디를 입력해주세요.");
				$("#superAdmin_id").focus();
				return false;
			}
			/* if($("#superAdmin_password").val().length == 0){
				alert("관리자 비밀번호를 입력해주세요.");
				$("#superAdmin_password").focus();
				return false;
			}
			if($("#superAdmin_passwordCheck").val().length == 0){
				alert("관리자 비밀번호 확인을 해주세요.");
				$("#superAdmin_passwordCheck").focus();
				return false;
			} */
			if($("#superAdmin_name").val().length == 0){
				alert("관리자 이름을 입력해주세요.");
				$("#superAdmin_name").focus();
				return false;
			}
			if($("#superAdmin_tel").val().length == 0){
				alert("관리자 연락처를 입력해주세요.");
				$("#superAdmin_tel").focus();
				return false;
			}
			if($("#superAdmin_gender").val() == -1){
				alert("관리자 성별을 입력해주세요.");
				$("#superAdmin_gender").focus();
				return false;
			}
			if($("#superAdmin_email").val().length == 0){
				alert("관리자 이메일을 입력해주세요.");
				$("#superAdmin_email").focus();
				return false;
			}
			if(!emailFormatCheck($("#superAdmin_email").val())){
				alert("이메일 형식을 맞춰주세요.");
				$("#superAdmin_email").focus();
				return false;
			}
				
			if($("#superAdmin_mall_id").val() == -1){
				alert("관리할 쇼핑몰을 할당해주세요.");
				$("#superAdmin_mall_id").focus();
				return false;
			}
			return true;
		}
		function superAdmin_modifyDetailAdmin(){
			if(superAdmin_modifyDetailAdminTest()){
				$("#superAdmin_modifyDetailAdmin_form").submit();
			}
		}
		
		$(function(){
			$("#alert-success").hide();
			$("#alert-danger").hide();
			
			$(".passwordCheck").change(function(){
				var pwd1 = $("#superAdmin_password").val();
				var pwd2 = $("#superAdmin_passwordCheck").val();
				if(pwd1 != "" || pwd2 != ""){
					if(pwd1 == pwd2){
						$("#alert-success").show();
						$("#alert-danger").hide();
						$(".superAdminSubmitButton").attr("onclick", "superAdmin_modifyDetailAdmin()");
						
						$("#superAdmin_submit01").removeClass("adminTop_btnGrey");
						$("#superAdmin_submit02").removeClass("adminTop_btnGrey");
						$("#superAdmin_submit01").addClass("adminTop_btnBlue");
						$("#superAdmin_submit02").addClass("adminTop_btnBlue");
					}
					else{
						$("#alert-danger").show();
						$("#alert-success").hide();
						$(".superAdminSubmitButton").removeAttr("onclick");
						
						$("#superAdmin_submit01").addClass("adminTop_btnGrey");
						$("#superAdmin_submit02").addClass("adminTop_btnGrey");
						$("#superAdmin_submit01").removeClass("adminTop_btnBlue");
						$("#superAdmin_submit02").removeClass("adminTop_btnBlue");
					}
				}
				else{
					$("#alert-success").hide();
					$("#alert-danger").hide();
					$(".superAdminSubmitButton").attr("onclick", "superAdmin_modifyDetailAdmin()");
					
					$("#superAdmin_submit01").removeClass("adminTop_btnGrey");
					$("#superAdmin_submit02").removeClass("adminTop_btnGrey");
					$("#superAdmin_submit01").addClass("adminTop_btnBlue");
					$("#superAdmin_submit02").addClass("adminTop_btnBlue");
				}
			})
		})
	</script>
</head>
<body>
  	<form id="superAdmin_modifyDetailAdmin_form" action="superAdmin_modifyDetailAdmin" method="post">
  		<input type="hidden" name="superAdmin_u_id" id="superAdmin_u_id" value="${userInfo.u_id}" />
  		TODO: 아이디 중복체크하기
  		<div class="adminProductDetail_content">
	  		<div class="adminProductDetail_productTitle">쇼핑몰 관리자 아이디</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_id" name="superAdmin_id" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="ID를 입력해주세요." value="${userInfo.user_id}" required autocomplete="user-name"/>
			</div>
  		</div>
  		
  		<div class="adminProductDetail_content">
	  		<div class="adminProductDetail_productTitle">쇼핑몰 관리자 비밀번호</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_password" name="superAdmin_password" 
	  					class="adminProductDetail_input adminProductDetail_inputText passwordCheck" 
	  					type="password" placeholder="비밀번호를 새로 입력하지 않는다면 이전 비밀번호를 사용합니다." required autocomplete="new-password"/>
			</div>
  		</div>
  		
  		<div class="adminProductDetail_content">
	  		<div class="adminProductDetail_productTitle">비밀번호 확인</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_passwordCheck" name="superAdmin_passwordCheck" 
	  					class="adminProductDetail_input adminProductDetail_inputText passwordCheck" 
	  					type="password" placeholder="비밀번호를 확인해주세요." value="" required autocomplete="new-password"/>
			</div>
  		</div>

		<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div>
		<div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">관리자 이름</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_name"
	  					name="superAdmin_name" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="관리자 이름을 입력해주세요." value="${userInfo.user_name}" required/>
			</div>
		</div>

		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">관리자 연락처</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_tel"
	  					name="superAdmin_tel" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="관리자의 연락처를 입력해주세요. ex) 010-1234-1234" value="${userInfo.telephone}" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">성별</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<select class="adminProduct_statusBtn" id="superAdmin_gender" 
	  					name="superAdmin_gender">
	  				<option selected value="-1">성별을 선택해주세요.</option>
	  				<option value="0">남자</option>
	  				<option value="1">여자</option>
	  			</select>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">관리자 이메일 주소</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_email"
	  					name="superAdmin_email" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="email" placeholder="관리자의 이메일 주소를 입력해주세요. ex) m2@daum.co.kr"
	  					value="${userInfo.email}" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">관리자 메모</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_memo"
	  					name="superAdmin_memo" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="해당 쇼핑몰 관리자의 메모를 입력해주세요. 쇼핑몰 관리자에게는 보이지 않습니다." 
	  					value="${userInfo.user_memo}" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">관리할 쇼핑몰</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<select class="adminProduct_statusBtn" id="superAdmin_mall_id" name="superAdmin_mall_id">
	  				<option selected value="-1">사이트를 선택해주세요.</option>
					<c:forEach items="${mallList}" var="row">
						<option value="${row.mall_id}">${row.mall_name}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		
		
		<div class="adminProductDetail_content">
			<a href="superAdminMallManager" class="adminTop_btn adminTop_btnWhite">취소</a>
			<a id="superAdmin_submit02" class="adminTop_btn adminTop_btnBlue superAdminSubmitButton" onclick="superAdmin_modifyDetailAdmin();">저장</a>
		</div>
	</form>
</body>
</html>