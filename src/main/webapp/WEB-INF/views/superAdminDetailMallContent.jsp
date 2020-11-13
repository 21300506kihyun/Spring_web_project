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
	</style>
	<script>
		function superAdmin_createNewMallTest(){
			if($("#superAdmin_mallName").val().length == 0){
				alert("쇼핌몰 이름 정해주세요.");
				$("#superAdmin_mallName").focus();
				return false;
			}
			if($("#superAdmin_farmName").val().length == 0){
				alert("농장이름을 입력해주세요.");
				$("#superAdmin_farmName").focus();
				return false;
			}
			if($("#superAdmin_farmAddress").val().length == 0){
				alert("농장 주소를 입력해주세요.");
				$("#superAdmin_farmAddress").focus();
				return false;
			}
			if($("#superAdmin_farmDetail").val().length == 0 || 
					$("#superAdmin_farmDetail").val() == "<br>"){
				alert("농장 상세설명을 기입해주세요.");
				$("#superAdmin_farmDetail").focus();
				return false;
			}
			if($("#superAdmin_mallPhone").val().length == 0){
				alert("쇼핌몰 연락처를 입력해주세요.");
				$("#superAdmin_mallPhone").focus();
				return false;
			}
			if($("#superAdmin_mallFax").val().length == 0){
				alert("쇼핌몰 FAX번호를 입력주세요.");
				$("#superAdmin_mallFax").focus();
				return false;
			}
			if($("#superAdmin_mallRegistNum").val().length == 0){
				alert("쇼핌몰 사업자등록번호를 입력해주세요.");
				$("#superAdmin_mallRegistNum").focus();
				return false;
			}
			if($("#superAdmin_mallBusinessNum").val().length == 0){
				alert("쇼핌몰 통신판매업 신고번호를 입력해주세요.");
				$("#superAdmin_mallBusinessNum").focus();
				return false;
			}
			if($("#superAdmin_mallAccountNum").val().length == 0){
				alert("쇼핌몰 계좌번호를 입력해주세요.");
				$("#superAdmin_mallAccountNum").focus();
				return false;
			}
			return true;
		}
		function superAdmin_modifyMall(){
			editorToTextarea();
			if(superAdmin_createNewMallTest()){
				$("#superAdminModifyMall_form").submit();
			}
		}
	</script>
	<!-- Smart Editor -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
</head>
<body>
  	<form id="superAdminModifyMall_form" action="superAdminModifyMall" method="post">
  		<input type="hidden" name="superAdmin_mall_id" value="${mallInfo.mall_id}"/>
  		<div class="adminProductDetail_content">
	  		<div class="adminProductDetail_productTitle">
	  			<span>01. 쇼핑몰 이름</span>
	  			<span class="superAdmin_idCheck" 
	  				onclick="superAdmin_mallNameheck('superAdmin_mallName', 'superAdmin_mallNameCheck')">중복체크</span>
  			</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_mallName" name="superAdmin_mallName" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="쇼핑몰 이름을 정해주세요." value="${mallInfo.mall_name}"/>
			</div>
  		</div>
  		
  		<div class="adminProductDetail_content">
	  		<div class="adminProductDetail_productTitle">02. 농장 이름</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_farmName" name="superAdmin_farmName" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="농장 이름을 입력해주세요." value="${mallInfo.farm_name}"/>
			</div>
  		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">03. 농장 주소</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_farmAddress"
	  					name="superAdmin_farmAddress" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="농장 주소를 입력해주세요." value="${mallInfo.farm_address}" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">04. 농장 설명</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<textarea id="superAdmin_farmDetail" name="superAdmin_farmDetail"
						style="width: 100%; min-width: 200px;">${mallInfo.farm_detail}</textarea>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">05. 쇼핑몰 대표 연락처</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_mallPhone"
	  					name="superAdmin_mallPhone" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="쇼핑몰의 대표 연락처를 입력해주세요. ex) 010-1234-1234/ 054-123-1234" 
	  					value="${mallInfo.tel}" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">06. 쇼핑몰 FAX 주소</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_mallFax"
	  					name="superAdmin_mallFax" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="쇼핑몰 FAX번호를 입력해주세요. ex)054-123-1234, 없으면 (-) 입력." 
	  					value="${mallInfo.fax}" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">07. 사업자 등록번호</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_mallRegistNum"
	  					name="superAdmin_mallRegistNum" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="쇼핑몰의 사업자 등록번호를 입력해주세요. ex) 000-00-0000" 
	  					value="${mallInfo.regist_num}" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">08. 통신판매업 신고번호</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_mallBusinessNum"
	  					name="superAdmin_mallBusinessNum" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="통신판매업 신고번호를 입력해주세요. ex) 2011-서울노원-0260 " 
	  					value="${mallInfo.business_num}" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<div class="adminProductDetail_productTitle">09. 쇼핑몰 계좌번호</div>
	  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
	  			<input id="superAdmin_mallAccountNum"
	  					name="superAdmin_mallAccountNum" 
	  					class="adminProductDetail_input adminProductDetail_inputText" 
	  					type="text" placeholder="쇼핑몰 계좌번호를 하이픈(-) 없이 입력해주세요" 
	  					value="${mallInfo.account_num}" required/>
			</div>
		</div>
		
		<div class="adminProductDetail_content">
			<a href="superAdmin" class="adminTop_btn adminTop_btnWhite">취소</a>
			<a class="adminTop_btn adminTop_btnBlue" onclick="superAdmin_modifyMall();">저장</a>
		</div>
	</form>
	
	<script type="text/javascript">
	   var oEditors = [];
	   nhn.husky.EZCreator.createInIFrame({
	     oAppRef: oEditors,
	     elPlaceHolder: "superAdmin_farmDetail",
	     sSkinURI: "<%=request.getContextPath()%>/se2/SmartEditor2Skin.html",
	     fCreator: "createSEditor2"
	   });
	</script>
	<script type="text/javascript">
	   function editorToTextarea() {
	     // 에디터의 내용이 textarea에 적용된다.
	     oEditors.getById["superAdmin_farmDetail"].exec("UPDATE_CONTENTS_FIELD", []);
	
	     return true;
	   }
	
	   //textArea에 이미지 첨부
	   function pasteHTML(filepath) {
	     var sHTML = '<img src="<%=request.getContextPath()%>/uploadFolder/' + filepath + '">';
	     oEditors.getById["superAdmin_farmDetail"].exec("PASTE_HTML", [sHTML]);
	   }
	</script>
</body>
</html>