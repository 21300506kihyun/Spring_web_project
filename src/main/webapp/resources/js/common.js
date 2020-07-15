$(document).ready(function(){
    $('.p5_button_list .p5_numb').click(function(){
        $(this).addClass('p5_be_green')
        $(this).siblings('.p5_numb').removeClass('p5_be_green')
    })
})

// popup
$(document).ready(function(){
	$('.popup-btn').click(function(){
        var $href = $(this).attr('href');
        layer_popup($href);
    });
    function layer_popup(el){

        var $el = $(el);        //레이어의 id를 $el 변수에 저장
        var isDim = $el.prev().hasClass('dimBg');   //dimmed 레이어를 감지하기 위한 boolean 변수

        isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

        var $elWidth = ~~($el.outerWidth()),
            $elHeight = ~~($el.outerHeight()),
            docWidth = $(document).width(),
            docHeight = $(document).height();

        // 화면의 중앙에 레이어를 띄운다.
        if ($elHeight < docHeight || $elWidth < docWidth) {
            $el.css({
                marginTop: -$elHeight /2,
                marginLeft: -$elWidth/2
            })
        } else {
            $el.css({top: 0, left: 0});
        }

        $el.find('.btn-layerClose').click(function(){
            isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
            return false;
        });

        $('.layer .dimBg').click(function(){
            $('.dim-layer').fadeOut();
            return false;
        });

    }
})

// login pop-up
$(document).ready(function(){
	$('.popup-btn').click(function(){
        var $href = $(this).attr('href');
        layer_popup($href);
    });
    function layer_popup(el){

        var $el = $(el);        //레이어의 id를 $el 변수에 저장
        var isDim = $el.prev().hasClass('login-dimBg');   //dimmed 레이어를 감지하기 위한 boolean 변수

        isDim ? $('.login-dim-layer').fadeIn() : $el.fadeIn();

        var $elWidth = ~~($el.outerWidth()),
            $elHeight = ~~($el.outerHeight()),
            docWidth = $(document).width(),
            docHeight = $(document).height();

        // 화면의 중앙에 레이어를 띄운다.
        if ($elHeight < docHeight || $elWidth < docWidth) {
            $el.css({
                marginTop: -$elHeight /2,
                marginLeft: -$elWidth/2
            })
        } else {
            $el.css({top: 0, left: 0});
        }

        $el.find('.btn-login-submit').click(function(){
            isDim ? $('.login-dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
            return false;
        });

        $('.layer .login-dimBg').click(function(){
            $('.login-dim-layer').fadeOut();
            return false;
        });

    }
})

// faq modify, delete
function faqModify(objective, faq_id){
	if(objective == "delete"){
		if(confirm("해당 글을 삭제하시겠습니까?")){
			alert("delete: FAQ("+faq_id+")");
		}
	}
	else if(objective == "modify"){
		if(confirm("해당 글을 수정하시겠습니까?")){
			alert("modify: FAQ("+faq_id+")");			
		}
	}
	else{
		alert("error");
	}
}

// faq write
function moveAjax(toUrl){
	// ajax option
    var ajaxOption = {
            url : toUrl,
            async : true,
            type : "POST",
            dataType : "html",
            cache : false
    };
    
    $.ajax(ajaxOption).done(function(data){
        // Contents 영역 삭제
        $('#omeran_pc_all').children().remove();
        // Contents 영역 교체
        $('#omeran_pc_all').html(data);
    });

}
