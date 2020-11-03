// [ Administration Page]

/** [ adminSidebar.jsp ] **/
function adminSide_hide(){
	$("#adminSide").removeClass("adminSide_openWidth");
	$("#adminSide").addClass("adminSide_closeWidth");
	$("#adminSide_logoDiv").css("display", "none");
	$("#adminSide_symlink").css("display", "none");
	$(".adminSide_menuText").css("display", "none");
	$(".adminSide_openBtn").css("display", "block");
	
	$.ajax({
		url: "adminSidebar.toggle",
		data: "isSideOpen=sideOff",
		type: "POST",
		success: function(data){
			
		},
		error: function(){
			
		}
	});
	
}
function adminSide_show(){
	$("#adminSide").removeClass("adminSide_closeWidth");
	$("#adminSide").addClass("adminSide_openWidth");
	$("#adminSide_logoDiv").css("display", "block");
	$("#adminSide_symlink").css("display", "block");
	$(".adminSide_menuText").css("display", "inline-block");
	$(".adminSide_openBtn").css("display", "none");
	
	$.ajax({
		url: "adminSidebar.toggle",
		data: "isSideOpen=sideOn",
		type: "POST",
		success: function(data){
			
		},
		error: function(){
			
		}
	});
}

/** [ adminProduct.jsp ] **/
function adminProduct_moveTap(moveUrl){
	$("#adminProduct_searchInput").val("");
	var ajaxOption = {
		url: moveUrl,
		async: false,
        type: "POST",
        dataType: "html",
        cache: false,
        error:function(){
        	alert("정보 불러오기에 실패하였습니다. 다시 시도해주세요.");
        }
	}
	$.ajax(ajaxOption).done(function(data) {
       // Contents 영역 삭제
       $('#adminProduct_content').children().remove();
       // Contents 영역 교체
       $('#adminProduct_content').html(data);
     });
}

// 검색기능 + 검색시 체크박스 상황 조정
function adminProduct_filter(){
    var value, name, item, i, num_of_showingItem = 0, checkLength=0, checkboxItem;

    value = document.getElementById("adminProduct_searchInput").value.toUpperCase();
    item = document.getElementsByClassName("adminProduct_listItem");

    for(i=0;i<item.length;i++){
      name = item[i].getElementsByClassName("adminProduct_itemName");
      checkboxItem = item[i].getElementsByClassName("adminProduct_itemCheckbox");
      
      if(name[0].innerHTML.toUpperCase().indexOf(value) > -1){
        item[i].style.display = "table-row";
        num_of_showingItem++;
        if(checkboxItem[0].checked){
      	  checkLength++;
        }
      }else{
        item[i].style.display = "none";
      }
    }
    
    if(num_of_showingItem == 0){
    	$(".adminProduct_checkAll").prop("checked", false);
    	$(".adminProduct_listNoData").css("display", "table-row");
    }
    else if(checkLength == num_of_showingItem){
    	$(".adminProduct_checkAll").prop("checked", true);
    	$(".adminProduct_listNoData").css("display", "none");
    }
    else{
    	$(".adminProduct_checkAll").prop("checked", false);
    	$(".adminProduct_listNoData").css("display", "none");
    }
    
//    num_of_showingItem = 0;
//    checkLength = 0;
}

$(document).ready(function() {
	// 탭 메뉴 클릭시 
	$('.adminProduct_tapMenus').on('click', function(){
		$(this).addClass('on');
		$(this).siblings().removeClass('on');
	});

	$("#adminProduct_tap01").click(function(){
		adminProduct_moveTap("adminProduct_tap01");
	});
	$("#adminProduct_tap02").click(function(){
		adminProduct_moveTap("adminProduct_tap02");
	});	

	$("#adminProduct_tap03").click(function(){
		adminProduct_moveTap("adminProduct_tap03");
	});	

	$("#adminProduct_tap04").click(function(){
		adminProduct_moveTap("adminProduct_tap04");
	});	

	$("#adminProduct_tap05").click(function(){
		adminProduct_moveTap("adminProduct_tap05");
	});
});
