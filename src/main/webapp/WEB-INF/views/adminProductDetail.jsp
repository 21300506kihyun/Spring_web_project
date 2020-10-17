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


.adminProductDetail_content{
	margin-bottom: 10px;
}
.adminProductDetail_productTitle{
	font-size: 18px;
	padding: 5px 0;
	color: #414141;
}
.adminProductDetail_inputContainer{
	padding: 10px;
}
.adminProductDetail_input{
	padding: 3px;
	border: none;
	width: 100%;
}

.adminProductDetail_inputText{
	border-bottom: 2px solid #fff;
	
	transition: all 0.2s ease-in-out;
	-webkit-transition: all 0..2s ease-in-out;
	-moz-transition: all 0.2s ease-in-out;
	-o-transition: all 0.2s ease-in-out;
}
.adminProductDetail_inputLabel{
	color: #515151;
}
.adminProductDetail_selectImage{

}
.adminProductDetail_priceContainer{
	display: flex;
}
.adminProductDetail_priceLabel{
	padding: 3px;
	padding-right: 10px;
	color: #515151;
}
</style>
<!-- Smart Editor -->
<script type="text/javascript" src="<%=request.getContextPath()%>/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
<script>
$(document).ready(function(){
	$("#adminProductDetail_productImage").change(function(){
		console.log("change");
		if(this.files && this.files[0]){
			console.log("if");
			var reader = new FileReader;
			reader.onload = function(data){
				console.log(data);
				console.log(data.target);
				$(".adminProductDetail_selectImage img").attr("src", data.target.result).width(400);
			}
			reader.readAsDataURL(this.files[0]);
		}
	});
});
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
			  	<form action="#formSubmit" method="post">
			  		<div class="adminProductDetail_content">
				  		<div class="adminProductDetail_productTitle">01. 상품명</div>
				  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
				  			<input id="adminProductDetail_productName" name="adminProductDetail_productName" 
				  					class="adminProductDetail_input adminProductDetail_inputText" 
				  					type="text" placeholder="상품명을 입력해주세요." value=""/>
						</div>
			  		</div>
					
					<div class="adminProductDetail_content">
						<div class="adminProductDetail_productTitle">02. 썸네일 등록</div>
				  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
				  			<label class="adminProductDetail_inputLabel" 
				  					for="adminProductDetail_productImage">*썸네일 등록에 필요한 정보를 알려줍니다.</label>
				  			<div class="adminProductDetail_selectImage"><img src=""/></div>
				  			<input id="adminProductDetail_productImage" name="adminProductDetail_productImage" 
				  					class="adminProductDetail_input" type="file"/>
						</div>
					</div>
					
					<div class="adminProductDetail_content">
						<div class="adminProductDetail_productTitle">03. 상품 요약설명</div>
				  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
				  			<input name="adminProductDetail_productSummary" 
				  					class="adminProductDetail_input adminProductDetail_inputText" 
				  					type="text" placeholder="상품을 요약하여 설명해주세요." value=""/>
						</div>
					</div>
					
					<div class="adminProductDetail_content">
						<div class="adminProductDetail_productTitle">04. 상품 상세설명</div>
				  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
				  			<textarea id="adminProductDetail_productDetail" name="adminProductDetail_productDetail"
									style="width: 100%; min-width: 200px;"></textarea>
						</div>
					</div>
					
					<div class="adminProductDetail_content">
						<div class="adminProductDetail_productTitle">05. 원가 설정</div>
				  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
				  			<div class="adminProductDetail_priceContainer">
					  			<span class="adminProductDetail_priceLabel">KRW</span>
					  			<input name="adminProductDetail_productPrice" class="adminProductDetail_input adminProductDetail_inputText" 
					  					type="number" min="0" placeholder="상품의 원가를 입력해주세요." onwheel="this.blur()"/>
				  			</div>
						</div>
					</div>
					
					<div class="adminProductDetail_content">
						<div class="adminProductDetail_productTitle">06. 판매가 등록</div>
				  		<div class="adminProduct_cardContainer adminProductDetail_inputContainer">
							<div class="adminProductDetail_priceContainer">
								<span class="adminProductDetail_priceLabel">KRW</span>
					  			<input name="adminProductDetail_productDiscountPrice" 
					  					class="adminProductDetail_input adminProductDetail_inputText" 
					  					type="number" min="0" placeholder="상품의 판매가를 입력해주세요." onwheel="this.blur()"/>
							</div>
						</div>
					</div>
					
					<div class="adminProductDetail_content">
						<a href="adminProduct" class="adminTop_btn adminTop_btnWhite">취소</a>
						<a href="#addProduct" class="adminTop_btn adminTop_btnBlue">저장</a>
						<input type="submit" value="HI">
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