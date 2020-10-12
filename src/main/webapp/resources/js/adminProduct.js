/**
 * 
 */
$(document).ready(function() {
	
	/* table > checkbox 리스트화 */
	$(".selectBtn").click(function(){
		var rowData = new Array();
		var tdArr = new Array();
		var checkbox = $("input[name=productItem]:checked");
		
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {
	
			// checkbox.parent() : checkbox의 부모는 <td>이다.
			// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
			
			// 체크된 row의 모든 값을 배열에 담는다.
			rowData.push(tr.text());
			
			// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
			var no = td.eq(1).text()+"/ ";
			var productCode = td.eq(2).text()+"/ ";
			var productName = td.eq(3).text()+"/ ";
			var initialPrice = td.eq(4).text()+"/ ";
			var discountRate = td.eq(5).text()+"/ ";
			var finalPrice = td.eq(6).text()+"/ ";
			var modDate = td.eq(7).text()+"/ ";
			var state = td.eq(8).text()+"/ <br>";
			
			// 가져온 값을 배열에 담는다.
			tdArr.push(no);
			tdArr.push(productCode);
			tdArr.push(productName);
			tdArr.push(initialPrice);
			tdArr.push(discountRate);
			tdArr.push(finalPrice);
			tdArr.push(modDate);
			tdArr.push(state);
			
			//console.log("no : " + no);
		});
		
		$(".ex3_Result1").html(" * 체크된 Row의 모든 데이터 = <br>"+rowData);	
		$(".ex3_Result2").html(tdArr);	
	});
	
	/* 상품 체크박스들 클릭시 상단 메뉴 노출 */
	function openStatus(){
		$(".productStatus_extend").css("height", "auto");
		$(".productStatus_extend").css("padding", "10px");
	}
	
	function closeStatus(){
		$(".productStatus_extend").css("padding", "0");
		$(".productStatus_extend").css("height", "0");
	}
	
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
	
	
	
	// 상품관리 상태창 조절
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
	
	$(".adminProduct_closeInputBtn").click(function(){
		adminProduct_closeInputs();
	});
	
	
});












