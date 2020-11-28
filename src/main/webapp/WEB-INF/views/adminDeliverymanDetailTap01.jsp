<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script>
		function adminDeliverymanModifyDetailTest(){
			if($("#admin_id").val().length == 0){
				alert("배송자 아이디를 입력해주세요.");
				$("#admin_id").focus();
				return false;
			}
			/* if($("#admin_idCheck").val().length == 0){
				alert("아이디 중복확인을 해주세요.");
				return false;
			}
			if($("#admin_password").val().length == 0){
				alert("배송자 비밀번호를 입력해주세요.");
				$("#admin_password").focus();
				return false;
			}
			if($("#admin_passwordCheck").val().length == 0){
				alert("비밀번호 확인을 해주세요.");
				$("#admin_passwordCheck").focus();
				return false;
			} */
			if($("#admin_name").val().length == 0){
				alert("배송자 이름을 입력해주세요.");
				$("#admin_name").focus();
				return false;
			}
			if($("#admin_tel").val().length == 0){
				alert("배송자 연락처를 입력해주세요.");
				$("#admin_tel").focus();
				return false;
			}
			if($("#admin_gender").val() == -1){
				alert("성별을 입력해주세요.");
				$("#admin_gender").focus();
				return false;
			}
			if($("#admin_email").val().length == 0){
				alert("이메일을 입력해주세요.");
				$("#admin_email").focus();
				return false;
			}
			if(!emailFormatCheck($("#admin_email").val())){
				alert("이메일 형식을 맞춰주세요.");
				$("#admin_email").focus();
				return false;
			}
			
			return true;
		}
		function adminDeliverymanModifyDetail(){
			if(adminDeliverymanModifyDetailTest()){
				$("#adminDeliverymanModifyDetail_form").submit();
			}
		}
		
		$(function(){
			$("#alert-success").hide();
			$("#alert-danger").hide();
			
			$(".passwordCheck").change(function(){
				var pwd1 = $("#admin_password").val();
				var pwd2 = $("#admin_passwordCheck").val();
				if(pwd1 != "" || pwd2 != ""){
					if(pwd1 == pwd2){
						$("#alert-success").show();
						$("#alert-danger").hide();
						$(".superAdminSubmitButton").attr("onclick", "adminDeliverymanModifyDetail()");
						
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
					$(".superAdminSubmitButton").attr("onclick", "adminDeliverymanModifyDetail()");
					
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
  	<form id="adminDeliverymanModifyDetail_form" action="adminDeliverymanModifyDetail" method="post">
  		<input type="hidden" name="admin_u_id" id="admin_u_id" value="${DeliverymanInfo.u_id}"/>
  		<div class="adminProductDetail_content">
	  		<div class="adminProductDetail_productTitle">
	  			<span>배송자 아이디</span>
	  			<span class="superAdmin_idCheck" 
	  				onclick="admin_idCheck('admin_id', 'admin_idCheck')">중복체크</span>
  			</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="admin_id" name="admin_id" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="아이디를 입력해주세요." value="${DeliverymanInfo.user_id}" required autocomplete="user-name"/>
			</div>
  		</div>
  		
  		<div class="adminProductDetail_content">
	  		<div class="adminProductDetail_productTitle">배송자 비밀번호</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="admin_password" name="admin_password" 
	  					class="adminProductDetail_input adminProductDetail_inputText passwordCheck" 
	  					type="password" placeholder="비밀번호를 새로 입력하지 않는다면 이전 비밀번호를 사용합니다." required autocomplete="new-password"/>
			</div>
  		</div>
  		
  		<div class="adminProductDetail_content">
	  		<div class="adminProductDetail_productTitle">비밀번호 확인</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="admin_passwordCheck" name="admin_passwordCheck" 
	  					class="adminProductDetail_input adminProductDetail_inputText passwordCheck" 
	  					type="password" placeholder="비밀번호를 확인해주세요." value="" required autocomplete="new-password"/>
			</div>
  		</div>

		<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div>
		<div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">배송자 이름</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="admin_name"
	  					name="admin_name" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="배송자 이름을 입력해주세요." value="${DeliverymanInfo.user_name}" required/>
			</div>
		</div>

		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">배송자 연락처</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="admin_tel"
	  					name="admin_tel" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="배송자의 연락처를 입력해주세요. ex) 010-1234-1234" value="${DeliverymanInfo.telephone}" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">성별</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<select class="adminProduct_statusBtn" id="admin_gender" name="admin_gender">
	  				<c:set var="gender" value="${DeliverymanInfo.gender}" />
	  				<option disabled>성별을 선택해주세요.</option>
	  				<option value="0" <c:if test="${gender == 0}">selected</c:if>>남자</option>
	  				<option value="1" <c:if test="${gender == 1}">selected</c:if>>여자</option>
	  			</select>
			</div>
		</div>
		
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">배송자 이메일 주소</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="admin_email"
	  					name="admin_email" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="email" placeholder="관리자의 이메일 주소를 입력해주세요. ex) m2@daum.co.kr" value="${DeliverymanInfo.email}" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">배송자 메모</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="admin_memo"
	  					name="admin_memo" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="배송자의 메모를 입력해주세요. 해당 배송자에게는 보이지 않습니다." value="${DeliverymanInfo.user_memo}" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<a href="adminDeliveryman" class="adminTop_btn adminTop_btnWhite">취소</a>
			<a id="superAdmin_submit02" class="adminTop_btn adminTop_btnBlue superAdminSubmitButton" onclick="adminDeliverymanModifyDetail()">저장</a>
		</div>
	</form>
</body>
</html>