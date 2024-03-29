$(document).ready(function() {
  $('.p5_button_list .p5_numb').click(function() {
    $(this).addClass('p5_be_green')
    $(this).siblings('.p5_numb').removeClass('p5_be_green')
  })
})

// popup
$(document).ready(function() {
  $('.popup-btn').click(function() {
    var $href = $(this).attr('href');
    layer_popup($href);
  });

  function layer_popup(el) {

    var $el = $(el); //레이어의 id를 $el 변수에 저장
    var isDim = $el.prev().hasClass('dimBg'); //dimmed 레이어를 감지하기 위한 boolean 변수

    isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

    var $elWidth = ~~($el.outerWidth()),
      $elHeight = ~~($el.outerHeight()),
      docWidth = $(document).width(),
      docHeight = $(document).height();

    // 화면의 중앙에 레이어를 띄운다.
    if ($elHeight < docHeight || $elWidth < docWidth) {
      $el.css({
        marginTop: -$elHeight / 2,
        marginLeft: -$elWidth / 2
      })
    } else {
      $el.css({
        top: 0,
        left: 0
      });
    }

    $el.find('.btn-layerClose').click(function() {
      isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
      return false;
    });

    $('.layer .dimBg').click(function() {
      $('.dim-layer').fadeOut();
      return false;
    });

  }
})

// login pop-up
$(document).ready(function() {
  $('.popup-btn').click(function() {
    var $href = $(this).attr('href');
    layer_popup($href);
  });

  function layer_popup(el) {
    var $el = $(el); //레이어의 id를 $el 변수에 저장
    var isDim = $el.prev().hasClass('login-dimBg'); //dimmed 레이어를 감지하기 위한 boolean 변수

    isDim ? $('.login-dim-layer').fadeIn() : $el.fadeIn();

    var $elWidth = ~~($el.outerWidth()),
      $elHeight = ~~($el.outerHeight()),
      docWidth = $(document).width(),
      docHeight = $(document).height();

    // 화면의 중앙에 레이어를 띄운다.
    if ($elHeight < docHeight || $elWidth < docWidth) {
      $el.css({
        marginTop: -$elHeight / 2,
        marginLeft: -$elWidth / 2
      })
    } else {
      $el.css({
        top: 0,
        left: 0
      });
    }

    $el.find('.btn-login-submit').click(function() {
      isDim ? $('.login-dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
      return false;
    });

    $('.layer .login-dimBg').click(function() {
      $('.login-dim-layer').fadeOut();
      return false;
    });

  }
})

// faq delete
function faqDelete(faq_id) {
  if (confirm("해당 글을 삭제하시겠습니까?")) {
    var destination = "faq.delete?faq_id=" + faq_id;

    var ajaxOption = {
      url: destination,
      async: true,
      type: "post",
      data: faq_id,
      dataType: "html",
      cache: false
    };

    $.ajax(ajaxOption).done(function(data) {
      // Contents 영역 삭제
      $('#body_wrapper').children().remove();
      // Contents 영역 교체
      $('#body_wrapper').html(data);
    });
  }
}

// paging
function paging(toUrl, curPage, keyword) {
  var destination = toUrl + "?curPage=" + curPage + "&faqKeyword=" + keyword;

  var ajaxOption = {
    url: destination,
    async: true,
    type: "POST",
    data: curPage,
    dataType: "html",
    cache: false
  };

  $.ajax(ajaxOption).done(function(data) {
    // Contents 영역 삭제
    $('#body_wrapper').children().remove();
    // Contents 영역 교체
    $('#body_wrapper').html(data);
  });
}


// faq write
function moveAjax(toUrl) {
  // ajax option
  var ajaxOption = {
    url: toUrl,
    async: true,
    type: "POST",
    dataType: "html",
    cache: false
  };

  $.ajax(ajaxOption).done(function(data) {
    // Contents 영역 삭제
    $('#body_wrapper').children().remove();
    // Contents 영역 교체
    $('#body_wrapper').html(data);
  });

}

function gfn_isNull(str) {
  if (str == null)
    return true;
  if (str == "NaN")
    return true;
  if (new String(str).valueOf() == "undefined")
    return true;
  var chkStr = new String(str);
  if (chkStr.valueOf() == "undefined")
    return true;
  if (chkStr == null)
    return true;
  if (chkStr.toString().length == 0)
    return true;
  return false;
}

function ComSubmit(opt_formId) {
  this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
  this.url = "";
  if (this.formId == "commonForm") {
    $("#commonForm")[0].reset()
  }
  this.setUrl = function setUrl(url) {
    this.url = url;
  };
  this.addParam = function addParam(key, value) {
    $("#" + this.formId).append($("<input type='hidden' name='" + key + "' id='" + key + "' value='" + value + "' >"));
  };
  this.submit = function submit() {
    var frm = $("#" + this.formId)[0];
    frm.action = this.url;
    frm.method = "post";
    frm.submit();
  };
}


// mobile hamburger bar
function openSidebar() {
  document.getElementById("sidebar").style.display = "block";
  document.getElementById("overlay").style.display = "block";
}

function closeSidebar() {
  document.getElementById("sidebar").style.display = "none";
  document.getElementById("overlay").style.display = "none";
}
