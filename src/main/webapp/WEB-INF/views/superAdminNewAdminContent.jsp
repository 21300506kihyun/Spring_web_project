<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style>
	/* This page only */
	input:not([type="file"]):focus{
		border-bottom: 2px solid #1a6dff;
	}
	/* from bootstrap */
	.alert{
		padding: 15px; 
		margin-bottom: 20px;
		border: 1px solid transparent;
  		border-radius: 4px;
	}
	.alert-success {
	  background-color: #dff0d8;
	  border-color: #d6e9c6;
	  color: #3c763d;
	}
	.alert-danger {
	  background-color: #f2dede;
	  border-color: #ebccd1;
	  color: #a94442;
	}
	.disable-color{
		background-color: #bbb;
		color: black;
	}
	</style>
	<script>
		function superAdmin_createNewAdminTest(){
			// TODO: 관리자 정보에 맞게 수정. : 폼체크: 
			return true;
		}
		function superAdmin_createNewAdmin(){
			if(superAdmin_createNewAdminTest()){
				$("#superAdminCreateNewAdmin_form").submit();
			}
		}
		
		$(function(){
			$("#alert-success").hide();
			$("#alert-danger").hide();
			
			$("#superAdmin_passwordCheck").keyup(function(){
				var pwd1 = $("#superAdmin_password").val();
				var pwd2 = $("#superAdmin_passwordCheck").val();
				if(pwd1 != "" || pwd2 != ""){
					if(pwd1 == pwd2){
						$("#alert-success").show();
						$("#alert-danger").hide();
						$(".superAdminSubmitButton").attr("onclick", "superAdmin_createNewAdmin()");
						
						$("#superAdmin_submit01").removeClass("adminTop_btnGrey");
						$("#superAdmin_submit02").removeClass("adminTop_btnGrey");
						$("#superAdmin_submit01").addClass("adminTop_btnBlue");
						$("#superAdmin_submit02").addClass("adminTop_btnBlue");
					}
					else{
						$("#alert-danger").show();
						$("#alert-success").hide();
						$("#superAdmin_submit01").addClass("adminTop_btnGrey");
						$("#superAdmin_submit02").addClass("adminTop_btnGrey");
						$("#superAdmin_submit01").removeClass("adminTop_btnBlue");
						$("#superAdmin_submit02").removeClass("adminTop_btnBlue");
					}
				}
			})
		})
	</script>
</head>
<body>
  	<form id="superAdminCreateNewAdmin_form" action="superAdminCreateNewAdmin" method="post">
  		TODO: 아이디 중복체크하기
  		<div class="adminProductDetail_content">
	  		<div class="adminProductDetail_productTitle">쇼핑몰 관리자 아이디</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_id" name="superAdmin_id" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="ID를 입력해주세요." value="" required autocomplete="user-name"/>
			</div>
  		</div>
  		
  		TODO: 비밀번호 암호화 작업, 비밀번호 글자수 제한: regex
  		<div class="adminProductDetail_content">
	  		<div class="adminProductDetail_productTitle">쇼핑몰 관리자 비밀번호</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_password" name="superAdmin_password" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="password" placeholder="관리자 비밀번호를 입력해주세요." required autocomplete="new-password"/>
			</div>
  		</div>
  		
  		<div class="adminProductDetail_content">
	  		<div class="adminProductDetail_productTitle">비밀번호 확인</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_passwordCheck" name="superAdmin_passwordCheck" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
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
	  					type="text" placeholder="관리자 이름을 입력해주세요." value="" required/>
			</div>
		</div>

		TODO: 연락처 포멧 regex로 테스트.
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">관리자 연락처</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_tel"
	  					name="superAdmin_tel" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="관리자의 연락처를 입력해주세요. ex) 010-1234-1234" value="" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">성별</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<select class="adminProduct_statusBtn" id="superAdmin_gender" name="superAdmin_gender">
	  				<option selected value="-1">성별을 선택해주세요.</option>
	  				<option value="0">남자</option>
	  				<option value="1">여자</option>
	  			</select>
			</div>
		</div>
		
		TODO: 이메일 포멧 regex로 테스트.
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">관리자 이메일 주소</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_email"
	  					name="superAdmin_email" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="email" placeholder="관리자의 이메일 주소를 입력해주세요. ex) m2@daum.co.kr" value="" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">관리자 메모</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_memo"
	  					name="superAdmin_memo" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="해당 쇼핑몰 관리자의 메모를 입력해주세요. 쇼핑몰 관리자에게는 보이지 않습니다." value="" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">관리할 쇼핑몰</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<select class="adminProduct_statusBtn" name="superAdmin_mall_id">
	  				<option selected value="0">사이트를 선택해주세요.</option>
					<c:forEach items="${mallList}" var="row">
						<option value="${row.mall_id}">${row.mall_name}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		
		
		<div class="adminProductDetail_content">
			<a href="superAdmin" class="adminTop_btn adminTop_btnWhite">취소</a>
			<a id="superAdmin_submit01" class="adminTop_btn adminTop_btnGrey superAdminSubmitButton">저장</a>
		</div>
	</form>
</body>
</html>