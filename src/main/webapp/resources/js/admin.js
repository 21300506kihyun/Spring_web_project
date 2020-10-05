// [ Administration Page]
/** adminProduct **/
function adminProduct_moveTap(moveUrl){
	var ajaxOption = {
		url: moveUrl,
		async: false,
        type: "POST",
        dataType: "html",
        cache: false
	}
	$.ajax(ajaxOption).done(function(data) {
       // Contents 영역 삭제
       $('#adminProduct_content').children().remove();
       // Contents 영역 교체
       $('#adminProduct_content').html(data);
     });
}

$(document).ready(function() {
	// 탭 메뉴 클릭시 
	$('.adminProduct_tapMenus').on('click', function(){
		$(this).addClass('on');
		$(this).siblings().removeClass('on');
	});

	$("#adminProduct_tap01").click(function(){
		/* $(".adminProduct_content").css("display", "none");
		$("#adminProduct_content01").css("display", "block"); */
		
		adminProduct_moveTap("adminProduct.tap01");
	});
	$("#adminProduct_tap02").click(function(){
		/* $(".adminProduct_content").css("display", "none");
		$("#adminProduct_content02").css("display", "block"); */
		
		adminProduct_moveTap("adminProduct.tap02");
	});	

	$("#adminProduct_tap03").click(function(){
		/* $(".adminProduct_content").css("display", "none");
		$("#adminProduct_content03").css("display", "block"); */
		adminProduct_moveTap("adminProduct.tap03");
	});	

	$("#adminProduct_tap04").click(function(){
		/* $(".adminProduct_content").css("display", "none");
		$("#adminProduct_content04").css("display", "block"); */
		adminProduct_moveTap("adminProduct.tap04");
	});	

	$("#adminProduct_tap05").click(function(){
		/* $(".adminProduct_content").css("display", "none");
		$("#adminProduct_content05").css("display", "block"); */
		adminProduct_moveTap("adminProduct.tap05");
	});	

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
		if($("input[name='productItem']:checked").length == $("input[name='productItem']").length){	
			$(".adminProduct_checkAll").prop("checked", true);
		}
		else{
			$(".adminProduct_checkAll").prop("checked", false);
		}
		if($(".adminProduct_itemCheckbox").is(":checked")){
	//		$(".productStatus_basic").css("display", "none");
			openStatus()
		}
		else{
	//		$(".productStatus_basic").css("display", "table-row");
			closeStatus();
		}
	});
	
	/* all checkbox 클릭시 전체 체크  */
	$(".adminProduct_checkAll").change(function(){
		if($(".adminProduct_checkAll").is(":checked")){
			/* $(".adminProduct_itemCheckbox").attr("checked", true); */
			$(".adminProduct_itemCheckbox").prop("checked", true);
			openStatus()
		}
		else{
			/* $(".adminProduct_itemCheckbox").attr("checked", false); */
			$(".adminProduct_itemCheckbox").prop("checked", false);
	//		$(".productStatus_basic").css("display", "table-row");
			closeStatus();
		}
	});
});
