/** [ adminProductContent.jsp ] **/

// Simple update DB 연결부분
function setUpdateAsDelete(){
	$("#adminProduct_isDelete").val("1");
}
function isNumber(str){
	if(str == ""){
		return true;
	}
	else if(!isNaN(str)){
		return true;
	}
	return false;
}
function adminProduct_simpleUpdate_formCheck(){
	var price = $("#adminProduct_change_originPrice_input").val();
	var discount_price = $("#adminProduct_change_sellingPrice_input").val();
	if(!isNumber(price)){
		alert("원가에 숫자를 입력해주세요");
		adminProduct_closeInputs();
		adminProduct_openOriPrice()
		$("#adminProduct_change_originPrice_input").focus();
		return false;
	}
	if(!isNumber(discount_price)){
		alert("판매가에 숫자를 입력해주세요");
		adminProduct_closeInputs();
		adminProduct_openSellPrice();
		$("#adminProduct_change_sellingPrice_input").focus();
		return false;
	}
	console.log(price + " : "  + discount_price);
	if(price < 0 || discount_price < 0){
		return false;
	}
	if($("#adminProduct_isDelete").val() == 1){
		if(!confirm("해당 상품정보를 삭제하시겠습니까?")){
			return false;
		}
	}
	else{
		if(!confirm("해당 상품정보를 수정하시겠습니까?")){
			return false;
		}
	}
	return true;
}

function adminProduct_simpleUpdate(){
	if(!adminProduct_simpleUpdate_formCheck()){
		return false;
	}
	var formData = $("#adminProduct_simpleUpdateForm").serialize();
	
	$.ajax({
		type: "POST",
		url: "adminProduct",
		data: formData,
		dataType: "html",
		async: false,
		cache: false,
		success: function(result){
			// Contents 영역 삭제
			$('body').children().remove();
			// Contents 영역 교체
			$('body').html(result);
			/* alert("수정이 완료되었습니다."); */
		},
		error: function(error){
			console.log(error)
		}
	});
}
function resetPrice(){
	$("#adminProduct_change_originPrice_input").val("");
}
function resetDiscountPrice(){
	$("#adminProduct_change_sellingPrice_input").val("");
}


//상품관리 상태창 조절
var is_open_originPrice = false;
var is_open_sellingPrice = false;

function adminProduct_closeInputs(){
	adminProduct_closeOriPrice();
	adminProduct_closeSellPrice();
}
function adminProduct_openOriPrice(){
	$("#adminProduct_change_originPrice_input").css("width", "150px");
	$("#adminProduct_change_originPrice_input").css("border-bottom", "1px solid #bbb");
	$("#adminProduct_closeInputBtn01").css("display", "block");
	is_open_originPrice = true;
}

function adminProduct_closeOriPrice(){
	$("#adminProduct_change_originPrice_input").css("width", "0");
	$("#adminProduct_change_originPrice_input").css("border-bottom", "none");
	$("#adminProduct_closeInputBtn01").css("display", "none");
	is_open_originPrice = false;
}
function adminProduct_openSellPrice(){
	$("#adminProduct_change_sellingPrice_input").css("width", "150px");
	$("#adminProduct_change_sellingPrice_input").css("border-bottom", "1px solid #bbb");
	$("#adminProduct_closeInputBtn02").css("display", "block");
	is_open_sellingPrice = true;
}

function adminProduct_closeSellPrice(){
	$("#adminProduct_change_sellingPrice_input").css("width", "0");
	$("#adminProduct_change_sellingPrice_input").css("border-bottom", "none");
	$("#adminProduct_closeInputBtn02").css("display", "none");
	is_open_sellingPrice = false;
}

/* 상품 체크박스들 클릭시 상단 메뉴 노출 */
function openStatus(){
	$(".productStatus_extend").css("height", "auto");
	$(".productStatus_extend").css("padding", "10px");
}

function closeStatus(){
	$(".productStatus_extend").css("padding", "0");
	$(".productStatus_extend").css("height", "0");
}


$(document).ready(function() {
	
	$(".adminProduct_itemCheckbox").change(function(){
		var num_of_showingItem = 0, i, checkboxItem, checkedBoxLength = 0;
		var tableListItem = document.getElementsByClassName("adminProduct_listItem");
		for(i=0; i<tableListItem.length; i++){
			checkboxItem = tableListItem[i].getElementsByClassName("adminProduct_itemCheckbox");
			if(tableListItem[i].style.display == "none"){
			}
			else{
				num_of_showingItem++;
				if(checkboxItem[0].checked){
					checkedBoxLength++;
				}
			}
		}
		
		if($(".adminProduct_itemCheckbox").is(":checked")){
			openStatus();
		}
		else{
			closeStatus();
		}
		
//		if($("input[name='productItem']:checked").length == $("input[name='productItem']").length){
		if(num_of_showingItem == checkedBoxLength){
			$(".adminProduct_checkAll").prop("checked", true);
		}
		else{
			$(".adminProduct_checkAll").prop("checked", false);
		}
		
	});
	
	/* all checkbox 클릭시 전체 체크  */
	$(".adminProduct_checkAll").change(function(){
		var tableListItem, checkboxItem, num_of_showingItem = 0; 
		tableListItem = document.getElementsByClassName("adminProduct_listItem");
		
		if($(".adminProduct_checkAll").is(":checked")){
			for(i=0; i<tableListItem.length; i++){
				checkboxItem = tableListItem[i].getElementsByClassName("adminProduct_itemCheckbox");
				if(tableListItem[i].style.display == "none"){
				}
				else{
					num_of_showingItem++;
					$(checkboxItem).prop("checked", true);
				}
			}
			openStatus();
		}
		else{
			for(i=0; i<tableListItem.length; i++){
				checkboxItem = tableListItem[i].getElementsByClassName("adminProduct_itemCheckbox");
				if(tableListItem[i].style.display == "none"){
				}
				else{
					num_of_showingItem++;
					$(checkboxItem).prop("checked", false);
				}
			}
			if($("input[name='productItem']:checked").length <= 0){
				closeStatus();
			}
		}
	});
	
	$("#adminProduct_change_originPrice").click(function(){
		if(!is_open_originPrice){
			adminProduct_closeInputs();
			adminProduct_openOriPrice();
			$("#adminProduct_change_originPrice_input").focus();
		}
		else{
			adminProduct_closeOriPrice();
		}
	});
	
	$("#adminProduct_change_sellingPrice").click(function(){
		if(!is_open_sellingPrice){
			adminProduct_closeInputs();
			adminProduct_openSellPrice();
			$("#adminProduct_change_sellingPrice_input").focus();
		}
		else{
			adminProduct_closeSellPrice();
		}
	});	
	
});












