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

function resetInput(id){
	$("#"+id).val("");
}

function emailFormatCheck(str){
	var regExp = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
    if (regExp.test(str)) {
    	return true;
    }
    else {
    	return false;
    }
}


// Simple Update 담당 함수
function setUpdateAsDelete(id){
	setValueAs_1_byId(id);
}

function setValueAs_1_byId(id){
	$("#"+id).val("1");
}

function simpleUpdate(formId, postURL, replaceAreaId){
	var formData = $("#"+formId).serialize();
	
	$.ajax({
		type: "POST",
		url: postURL,
		data: formData,
		dataType: "html",
		async: false,
		cache: false,
		success: function(result){
			// Contents 영역 삭제
			$('#'+replaceAreaId).children().remove();
			// Contents 영역 교체
			$('#'+replaceAreaId).html(result);
			/* alert("수정이 완료되었습니다."); */
		},
		error: function(error){
			console.log(error)
		}
	});
}

// ID check
function admin_idCheck(idInput_id, checkInput){
	var testID = $("#"+idInput_id).val();
	
	$.ajax({
		type: "POST",
		url: "admin_idCheck.do",
		dataType : "json",
		data: {"user_id" : testID},
		async: false,
		cache: false,
		success: function(result){
			if(result >= 1){
				alert("중복된 아이디 입니다.");
				$("#"+checkInput).val("");
			}
			else{
				alert("사용 가능한 아이디입니다.");
				$("#"+checkInput).val("1");
			}
		},
		error: function(error){
			console.log(error)
		}
	});
}

function superAdmin_idCheck(idInput_id, checkInput){
	var testID = $("#"+idInput_id).val();
	
	$.ajax({
		type: "POST",
		url: "superAdmin_idCheck.do",
		dataType : "json",
		data: {"user_id" : testID},
		async: false,
		cache: false,
		success: function(result){
			if(result >= 1){
				alert("중복된 아이디 입니다.");
				$("#"+checkInput).val("");
			}
			else{
				alert("사용 가능한 아이디입니다.");
				$("#"+checkInput).val("1");
			}
		},
		error: function(error){
			console.log(error)
		}
	});
}



function superAdmin_mallNameheck(idInput_id, checkInput){
	var mallName = $("#"+idInput_id).val();
	
	
	$.ajax({
		type: "POST",
		url: "superAdmin_mallNameCheck.do",
		dataType : "json",
		data: {"mall_name" : mallName},
		async: false,
		cache: false,
		success: function(result){
			if(result >= 1){
				alert("중복된 쇼핑몰 이름입니다.");
				$("#"+checkInput).val("");
			}
			else{
				alert("사용 가능한 이름입니다.");
				$("#"+checkInput).val("1");
			}
		},
		error: function(error){
			console.log(error)
		}
	});
}



// admin tap 
function admin_moveTap(toURL, tapNum){
	var URL = toURL + "?tap=" + tapNum;
	$.ajax({
		type: "POST",
		url: URL,
		dataType: "html",
		async: false,
		cache: false,
		success: function(result){
			// Contents 영역 삭제
			$('#adminProduct_content').children().remove();
			// Contents 영역 교체
			$('#adminProduct_content').html(result);
		},
		error: function(error){
			console.log(error)
		}
	});
	return false;
}

function admin_search(curPage, toURL){
	var searchKeyword = "search_keyword=" + $("#admin_searchInput").val();
	var goPage = "currentPage="+curPage;
	var Data = searchKeyword + "&" + goPage;
	$.ajax({
		type: "POST",
		url: toURL,
		data: Data,
		async: false,
		cache: false,
		success: function(result){
			// Contents 영역 삭제
			$('#adminProduct_content').children().remove();
			// Contents 영역 교체
			$('#adminProduct_content').html(result);
		},
		error: function(error){
			console.log(error)
		}
	});
	return false;
}

