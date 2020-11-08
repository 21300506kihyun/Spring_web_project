<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="Omeran: adminPage" content="오메란 몰의 관리자 페이지입니다.">
<%@ include file="./adminHeader.jsp" %>
<title>omeranmall: Admin</title>
<style>
/* This page only */
input:not([type="file"]):focus{
	border-bottom: 2px solid #1a6dff;
}
</style>
<!-- Smart Editor -->
<script type="text/javascript" src="<%=request.getContextPath()%>/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
<script>
$(document).ready(function(){
	$("#adminProductDetail_productImage").change(function(){
		if(this.files && this.files[0]){
			var reader = new FileReader;
			reader.onload = function(data){
				$(".adminProductDetail_selectImage img").attr("src", data.target.result).width(400);
			}
			reader.readAsDataURL(this.files[0]);
			
			// 파일이 새로 업로드 되었을 때,
			$("#adminProductDetail_fileTest").val("afterNewUpload");
		}
		else{
			$(".adminProductDetail_selectImage img").attr("src", "").width(0);
			
			// 파일이 새로 업로드 되지 않았을 때,
			$("#adminProductDetail_fileTest").val("beforeNewUpload");
		}
	});
});

function adminProduct_ModifyDetailSubmitTest(){
	if($("#adminProductDetail_productName").val().length == 0){
		alert("상품명을 기입해주세요.");
		$("#adminProductDetail_productName").focus();
		return false;
	}
	/* if($("#adminProductDetail_productImage").val().length == 0){
		alert("상품의 썸네일을 등록해주세요.");
		$("#adminProductDetail_productImage").focus();
		return false;
	} */
	if($("#adminProductDetail_productSummary").val().length == 0){
		alert("상품 요약설명을 기입해주세요.");
		$("#adminProductDetail_productSummary").focus();
		return false;
	}if($("#adminProductDetail_productDetail").val().length == 0 || 
			$("#adminProductDetail_productDetail").val() == "<br>"){
		alert("상품 상세설명을 등록해주세요.");
		$("#adminProductDetail_productDetail").focus();
		return false;
	}
	if($("#adminProductDetail_productPrice").val().length == 0){
		alert("상품의 원가를 등록해주세요.");
		$("#adminProductDetail_productPrice").focus();
		return false;
	}
	if($("#adminProductDetail_productDiscountPrice").val().length == 0){
		alert("상품의 판매가를 등록해주세요.");
		$("#adminProductDetail_productDiscountPrice").focus();
		return false;
	}
	
	return true;
}
function adminProduct_ModifyDetailSubmit(){
	editorToTextarea();
	if(adminProduct_ModifyDetailSubmitTest()){
		$("#adminProductModifyDetail_form").submit();		
	}
}
</script>
</head>
<body>
	<div id="body_wrapper" class="admin_wrapper">
  		<!-- 사이드 바 -->
		<jsp:include page="./adminSidebar.jsp"></jsp:include>
		 
		 <!-- right -->
		 <div class="admin_right">
		 	<!-- top -->
		  	<jsp:include page="./adminTop.jsp"></jsp:include>
		  	
		  	<!-- content -->
		  	<div class="admin_content">
			  	<form id="adminProductModifyDetail_form" action="adminProductModifyDetail" method="post" enctype="multipart/form-data">
			  		<input name="adminProductDetail_contextPath" type="hidden" value='<%= request.getRealPath("/") %>'/>
			  		<input name="adminProductDetail_p_id" type="hidden" value="${productInfo.p_id}"/>
			  		<input name="adminProductDetail_state" type="hidden" value="${productInfo.state_id}"/>
			  		<div class="adminProductDetail_content">
				  		<div class="adminProductDetail_productTitle">01. 상품명</div>
				  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
				  			<input id="adminProductDetail_productName" name="adminProductDetail_productName" 
				  					class="adminProductDetail_input adminProductDetail_inputText" 
				  					type="text" placeholder="상품명을 입력해주세요." value="${productInfo.product_name}"/>
						</div>
			  		</div>
					
					<div class="adminProductDetail_content">
						<div class="adminProductDetail_productTitle">02. 썸네일 등록</div>
				  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
				  			<label class="adminProductDetail_inputLabel" 
				  					for="adminProductDetail_productImage">*새로운 파일을 등록하지 않으시면 자동으로 이전 썸네일을 사용합니다.</label>
				  			<div class="adminProductDetail_selectImage">
				  				<c:set var="img" value="${productInfo.product_img}"/>
								<c:choose>
									<c:when test="${img != null}">
										<img width="400" src="uploadFolder/${productInfo.product_img}"/>
									</c:when>
									<c:otherwise>
										<img width="400" src=""/>
									</c:otherwise>
								</c:choose> 
				  			</div>
				  			<input id="adminProductDetail_fileTest" type="hidden" name="adminProductDetail_fileTest" value="beforeNewUpload"/>
				  			<input type="hidden" name="adminProductDetail_productImageName" value="${productInfo.product_img}"/>
				  			<input id="adminProductDetail_productImage" name="adminProductDetail_productImage"
				  					class="adminProductDetail_input adminProductDetail_inputFile" type="file" required accept="image/*"/>
						</div>
					</div>
					
					<div class="adminProductDetail_content">
						<div class="adminProductDetail_productTitle">03. 상품 요약설명</div>
				  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
				  			<input id="adminProductDetail_productSummary"
				  					name="adminProductDetail_productSummary" 
				  					class="adminProductDetail_input adminProductDetail_inputText" 
				  					type="text" placeholder="상품을 요약하여 설명해주세요." value="${productInfo.summary}" required/>
						</div>
					</div>
					
					<div class="adminProductDetail_content">
						<div class="adminProductDetail_productTitle">04. 상품 상세설명</div>
				  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
				  			<textarea id="adminProductDetail_productDetail" name="adminProductDetail_productDetail"
									style="width: 100%; min-width: 200px;">${productInfo.detail}</textarea>
						</div>
					</div>
					
					<div class="adminProductDetail_content">
						<div class="adminProductDetail_productTitle">05. 원가 설정</div>
				  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
				  			<div class="adminProductDetail_priceContainer">
					  			<span class="adminProductDetail_priceLabel">KRW</span>
					  			<input id="adminProductDetail_productPrice" name="adminProductDetail_productPrice" 
					  					class="adminProductDetail_input adminProductDetail_inputText" value="${productInfo.price}"
					  					type="number" min="0" placeholder="상품의 원가를 입력해주세요." onwheel="this.blur()" required/>
				  			</div>
						</div>
					</div>
					
					<div class="adminProductDetail_content">
						<div class="adminProductDetail_productTitle">06. 판매가 등록</div>
				  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
							<div class="adminProductDetail_priceContainer">
								<span class="adminProductDetail_priceLabel">KRW</span>
					  			<input id="adminProductDetail_productDiscountPrice" 
					  					name="adminProductDetail_productDiscountPrice" 
					  					class="adminProductDetail_input adminProductDetail_inputText" value="${productInfo.discount_price}" 
					  					type="number" min="0" placeholder="상품의 판매가를 입력해주세요." onwheel="this.blur()" required/>
							</div>
						</div>
					</div>
					
					<div class="adminProductDetail_content">
						<a href="adminProduct" class="adminTop_btn adminTop_btnWhite">취소</a>
						<a class="adminTop_btn adminTop_btnBlue" onclick="adminProduct_ModifyDetailSubmit()">저장</a>
					</div>
				</form>
		  	</div>
		 </div>
	</div>
<script type="text/javascript">
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
      oAppRef: oEditors,
      elPlaceHolder: "adminProductDetail_productDetail",
      sSkinURI: "<%=request.getContextPath()%>/se2/SmartEditor2Skin.html",
      fCreator: "createSEditor2"
    });
</script>
<script type="text/javascript">
    function editorToTextarea() {
      // 에디터의 내용이 textarea에 적용된다.
      oEditors.getById["adminProductDetail_productDetail"].exec("UPDATE_CONTENTS_FIELD", []);

      return true;
    }

    //textArea에 이미지 첨부
    function pasteHTML(filepath) {
      var sHTML = '<img src="<%=request.getContextPath()%>/uploadFolder/' + filepath + '">';
      oEditors.getById["adminProductDetail_productDetail"].exec("PASTE_HTML", [sHTML]);
    }
</script>


</body>
</html>