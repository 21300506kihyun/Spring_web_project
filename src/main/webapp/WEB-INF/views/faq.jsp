<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>

<head>
  <title>고용량 오메가3 함요 : 자연방사유정란 오메란</title>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" />
  <style>
    input[id*="faq-answer"] {display: none;}
    input[id*="faq-answer"]+label {display: block; padding: 20px; border-bottom: 1px solid #bbb;
      color: #000; background: #fdfdfd; cursor: pointer; position: relative; text-align: left; font-size: 20px;}
    input[id*="faq-answer"] + label em { position:absolute;top:30%;left:10px;width:50px; height:50px; margin-top:-15px;
    display:inline-block; margin-right: 50px; background:url('img/qna.png') 0 0 no-repeat;  background-size: contain;;
    /*img source: https://www.clipartmax.com/middle/m2i8Z5b1K9G6N4K9_question-and-answer-icon-png-personal-injury/ */}
    input[id*="faq-answer"] + label p{ margin-left: 50px; font-size: 20px;}
    input[id*="faq-answer"]+label+div { max-height: 0; transition: all .35s; overflow: hidden; background: #eee;}
    input[id*="faq-answer"]+label+div div{ }
    input[id*="faq-answer"]+label+div div p { display: inline-block; padding: 20px;}
    input[id*="faq-answer"]:checked+label+div { max-height: 1000px; }
  </style>
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/common.js"></script>
  <script>
  	var idx = 1; // form 번호 구분하기 위함
  	// faq search
  	function faqSearch(toUrl){
	  var formData = $("#faqSearch").serialize();

	  // ajax option
      var ajaxOption = {
        url : toUrl,
        async : true,
        type : "POST",
        data : formData,
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
  	
 	// faq modify
  	function faqModify(toUrl, id){
  	  if(confirm("해당 글을 수정하시겠습니까?")){
 	  	var formId = "#"+"faqContent"+id;
	  	var formData = $(formId).serialize();
	  	// ajax option
      	var ajaxOption = {
	  			url : toUrl,
	  			async : true,
        		type : "POST",
        		data : formData,
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
	}
  	
  	function fn_updateBoard(id){
  		var comSubmit = new ComSubmit("faqContent"+id);

  		comSubmit.setUrl("<c:url value='/updateBoard' />");
  		comSubmit.submit();
  	}
  	function fn_deleteBoard(){
  		var comSubmit = new ComSubmit();
  		comSubmit.setUrl("<c:url value='deleteBoard' />");
  		comSubmit.submit();
  	}
  	
  	function mysubmit(id) {
  	    var myform = document.forms['faqContent'+id];
  	    if(confirm("수정하시겠습니까?")){
	  	    if( myform['title'].value.length < 1) {
	  	        alert('제목 입력하세요.');
	  	        return false;
	  	    }
	  	    if( myform['content'].value.length < 1) {
	  	        alert( '내용을 입력하세요.');
	  	        return false;
	  	    }
	  	    fn_updateBoard(id);
	  	    return true;
  	    }
  	}
</script>

</head>

<body>
  <div id="omeran_pc_all">

    <header id="p2_header">

      <jsp:include page="./popupMail.jsp"></jsp:include>

      <img src="img/p1_top_banner.png" class="p2_top_banner">
      <a href="index" class="p2_top_logo" id="p1_top_logoc"><img src="img/p1_top_logo.png" alt=""></a>
      <div class="p2_util p1_util">
        <jsp:include page="./topRight.jsp"></jsp:include>
      </div>
      <div class="p2_menu01" id="p1_menu01">
        <jsp:include page="./menuLeft.jsp"></jsp:include>
      </div>
      <div class="p2_menu02" id="p1_menu02">
        <jsp:include page="./menuRight.jsp"></jsp:include>
      </div>
    </header>

    <jsp:include page="./login.jsp"></jsp:include>

    <div class="faq-mid">
      <div class="faq-mid-menu">
        <p class="faq-title">FAQ: 자주 묻는 질문</p>
        <div class="faq-mid-line"></div>


        <div class="faq-div">
          <form id="faqSearch" method="post" action="faq" onsubmit="faqSearch('${curURL}'); return false;">
            <input name="faqKeyword" type="text" id="find_input" class="faq-input" placeholder="제목을 검색해주세요." value="${keyword}">
            <input type="submit" class="faq-submit" value="검색하기">
            <% if(session.getAttribute("status") != null){
  				if((int)session.getAttribute("status") == -1){%>
            <input type="button" class="faq-submit" value="글쓰기" onclick="moveAjax('faqWrite')">
            <%  }
  			   } %>
          </form>
        </div>

        <div class="faq-table">
          	<c:choose>
          		<c:when test="${pagination.listCnt != 0}">
          		  <div class="accordion">
		            <c:forEach items="${list}" var="row">
		              <input type="checkbox" name="accordion" id="faq-answer${row.faq_id}">
		              <label for="faq-answer${row.faq_id}"><em></em>
		                <p>${row.title}</p>
		              </label>
		              <div>
		              	<div style="text-align: left;">${row.content}</div>
		                <% if(session.getAttribute("status") != null){
			              		if((int)session.getAttribute("status") == -1){%>
			              <form name="faqContent${row.faq_id}" id ="faqContent${row.faq_id}" onsubmit="faqModify('faqModify', '${row.faq_id}'); return false;" action="" method="post">
				            <input type="hidden" class="faq-admin-input" name="title" value="${row.title}">
				            <input type="hidden" name="faq_id" value="${row.faq_id}">
				            <textarea style="display: none" name="content">${row.content}</textarea>
			                <div class="faq-admin-btn-container">
			                	<input type="submit"  class="faq-admin-btn" value="수정하기">
			                	<input type="button" class="faq-admin-btn" value="삭제하기" onclick="faqDelete(${row.faq_id})">
			                </div>
		                  </form>
		                <% 	}
			              }%>
		              </div>
		              
		            </c:forEach>
		          </div>
          		</c:when>
          		<c:otherwise>
          		  <div class="no-accordion">
          			<p class="faq-no-result">검색된 자료가 없습니다 :(</p>
          		  </div>
          		</c:otherwise>
        	</c:choose>
          <div>
            <ul>
              <c:if test="${pagination.curRange != 1}">
              	<li class="page-num"><a onclick="paging('${curURL}', '1', '${keyword}')"> [처음] </a></li>
              </c:if>
              <c:if test="${pagination.curPage != 1}">
              	<li class="page-num"><a onclick="paging('${curURL}', '${pagination.prevPage}', '${keyword}')"> [이전] </a></li>
              </c:if>
              <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
              	<c:choose>
              		<c:when test="${pageNum == pagination.curPage}">
              		  <li class="page-num"><a class="page-num-selected" onclick="paging('${curURL}', ${pageNum}, '${keyword}')"> ${pageNum} </a></li>
              		</c:when>
              		<c:otherwise>
              		  <li class="page-num"><a onclick="paging('${curURL}', ${pageNum}, '${keyword}')"> ${pageNum} </a></li>
              		</c:otherwise>
            	</c:choose>
              </c:forEach>
              <c:if test="${pagination.curPage != pagination.pageCnt && pagination.pageCnt > 0}">
              	<li class="page-num"><a onclick="paging('${curURL}', '${pagination.nextPage}', '${keyword}')"> [다음] </a></li>
              </c:if>
              <c:if test="${pagination.curRange != pagination.rangeCnt && pagination.rangeCnt > 0}">
                <li class="page-num"><a onclick="paging('${curURL}', '${pagination.pageCnt}', '${keyword}')"> [끝] </a></li>
              </c:if>
            </ul>
          </div>
          <%-- [FOR DEBUG] 총 게시글 수 : ${pagination.listCnt} / 총 페이지수 : ${pagination.pageCnt} / 현재 페이지 : ${pagination.curPage } / 현재 블럭 : ${pagination.curRange } / 총 블럭 수 : ${pagination.rangeCnt } --%>
        </div>
      </div>
    </div>

    <jsp:include page="./footer.jsp"></jsp:include>
  </div>

  <!-- 모바일 시작 -->
  <div id="omeran_mob_all">
    <div id="m_index">
      <img src="img/m_index.png" id="m_main_img">
      <a href="p1.html" id="m_logo_area"></a>

      <div id="m_p1_header">
        <jsp:include page="./mobMenu.jsp"></jsp:include>
      </div>

      <div id="m_p1_foo_menu">
        <ul>
          <li><a href="#" class="m_index_main">오메란의 특별한 생산환경</a></li>
          <li>
            <p>|</p>
          </li>
          <li><a href="#" class="m_index_main">오메란의 오메가 함유</a></li>
          <li>
            <p>|</p>
          </li>
          <li><a href="#" class="m_index_main">오메가3의 장점</a></li>
        </ul>
      </div>

    </div>

    <div id="m_p1_footer">
      <jsp:include page="./mobFooter.jsp"></jsp:include>
    </div>
  </div>

</body>

</html>

<!-- 바로 글 쓰기 버전  -->
<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>

<head>
  <title>고용량 오메가3 함요 : 자연방사유정란 오메란</title>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" />
  <style>
    input[id*="faq-answer"] {display: none;}
    input[id*="faq-answer"]+label {display: block; padding: 20px; border-bottom: 1px solid #bbb;
      color: #000; background: #fdfdfd; cursor: pointer; position: relative; text-align: left; font-size: 20px;}
    input[id*="faq-answer"] + label em { position:absolute;top:30%;left:10px;width:50px; height:50px; margin-top:-15px;
    display:inline-block; margin-right: 50px; background:url('img/qna.png') 0 0 no-repeat;  background-size: contain;;
    /*img source: https://www.clipartmax.com/middle/m2i8Z5b1K9G6N4K9_question-and-answer-icon-png-personal-injury/ */}
    input[id*="faq-answer"] + label p{ margin-left: 50px; font-size: 20px;}
    input[id*="faq-answer"]+label+div { max-height: 0; transition: all .35s; overflow: hidden; background: #eee;}
    input[id*="faq-answer"]+label+div div{ border: 1px soild black;}
    input[id*="faq-answer"]+label+div div p { display: inline-block; padding: 25px;}
    input[id*="faq-answer"]:checked+label+div { max-height: 1000px; }
  </style>
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/common.js"></script>
  <!-- 스마트에디터 -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/smartEditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
  <script type="text/javascript" src="<%=request.getContextPath() %>/smartEditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
  <script>
  	var idx = 1; // form 번호 구분하기 위함
  	// faq search
  	function faqSearch(toUrl){
	  var formData = $("#faqSearch").serialize();

	  // ajax option
      var ajaxOption = {
        url : toUrl,
        async : true,
        type : "POST",
        data : formData,
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
  	function fn_updateBoard(id){
  		var comSubmit = new ComSubmit("faqContent"+id);

  		comSubmit.setUrl("<c:url value='/updateBoard' />");
  		comSubmit.submit();
  	}
  	function fn_deleteBoard(){
  		var comSubmit = new ComSubmit();
  		comSubmit.setUrl("<c:url value='deleteBoard' />");
  		comSubmit.submit();
  	}
  	
  	function mysubmit(id) {
  	    var myform = document.forms['faqContent'+id];
  	    if(confirm("수정하시겠습니까?")){
	  	    if( myform['title'].value.length < 1) {
	  	        alert('제목 입력하세요.');
	  	        return false;
	  	    }
	  	    if( myform['content'].value.length < 1) {
	  	        alert( '내용을 입력하세요.');
	  	        return false;
	  	    }
	  	    fn_updateBoard(id);
	  	    return true;
  	    }
  	}
  	
  	// 스마트 에디터
  	var editorIdx = 0;
  	var oEditors = new Array(10);
  	for(var i = 0; i < oEditors.length; i++){
  		oEditors[i] = null;
  	}
</script>

</head>

<body>
  <div id="omeran_pc_all">

    <header id="p2_header">

      <jsp:include page="./popupMail.jsp"></jsp:include>

      <img src="img/p1_top_banner.png" class="p2_top_banner">
      <a href="index" class="p2_top_logo" id="p1_top_logoc"><img src="img/p1_top_logo.png" alt=""></a>
      <div class="p2_util p1_util">
        <jsp:include page="./topRight.jsp"></jsp:include>
      </div>
      <div class="p2_menu01" id="p1_menu01">
        <jsp:include page="./menuLeft.jsp"></jsp:include>
      </div>
      <div class="p2_menu02" id="p1_menu02">
        <jsp:include page="./menuRight.jsp"></jsp:include>
      </div>
    </header>

    <jsp:include page="./login.jsp"></jsp:include>

    <div class="faq-mid">
      <div class="faq-mid-menu">
        <p class="faq-title">FAQ: 자주 묻는 질문</p>
        <div class="faq-mid-line"></div>


        <div class="faq-div">
          <form id="faqSearch" method="post" action="faq" onsubmit="faqSearch('${curURL}'); return false;">
            <input name="faqKeyword" type="text" id="find_input" class="faq-input" placeholder="제목을 검색해주세요." value="${keyword}">
            <input type="submit" class="faq-submit" value="검색하기">
            <% if(session.getAttribute("status") != null){
  				if((int)session.getAttribute("status") == -1){%>
            <input type="button" class="faq-submit" value="글쓰기" onclick="moveAjax('faqWrite')">
            <%  }
  			   } %>
          </form>
        </div>

        <div class="faq-table">
          	<c:choose>
          		<c:when test="${pagination.listCnt != 0}">
          		  <div class="accordion">
		            <c:forEach items="${list}" var="row">
		              <input type="checkbox" name="accordion" id="faq-answer${row.faq_id}">
		              <label for="faq-answer${row.faq_id}"><em></em>
		                <p>${row.title}</p>
		              </label>
		              <div>
		              	<div style="text-align: left;">${row.content}</div>
		                <% if(session.getAttribute("status") != null){
			              		if((int)session.getAttribute("status") == -1){%>
			              <form name="faqContent${row.faq_id}" id ="faqContent${row.faq_id}" onsubmit="return editorToTextarea('${row.faq_id}') & mysubmit('${row.faq_id}')" action="" method="post">
				            <input type="text" class="faq-admin-input" name="title" value="${row.title}">
				            <input type="hidden" name="faq_id" value="${row.faq_id}">
				            <input type="hidden" name="u_id" value="${row.faq_id}">
			                <textarea class="faq-admin-input" name="content" rows="8" cols="50">${row.content}</textarea>
			                <div class="faq-admin-textarea-div">
			                	<textarea style="width: 100%;"id="content${row.faq_id}" name="content" rows="8" cols="50">${row.content}</textarea> 
			                </div>
			                <div class="faq-admin-btn-container">
			                	<input type="submit"  class="faq-admin-btn" value="수정하기">
			                	<input type="button" class="faq-admin-btn" value="삭제하기" onclick="faqModify('delete', ${row.faq_id})">
			                </div>
		                  </form>
		                  <script type="text/javascript">
			              	var oEditors${row.faq_id} = [];
			              	var textareaId${row.faq_id} = "content"+${row.faq_id};
			              	nhn.husky.EZCreator.createInIFrame({
			              	  oAppRef: oEditors${row.faq_id},
			              	  elPlaceHolder: textareaId${row.faq_id},
			              	  sSkinURI: "<%=request.getContextPath() %>/smartEditor/SmartEditor2Skin.html",
			              	  fCreator: "createSEditor2"
			                });
			              </script>
			              <script type="text/javascript">
						    function editorToTextarea(faq_id){
						      var id = "textareaId"+faq_id;
							  // 에디터의 내용이 textarea에 적용된다.
							  oEditors${row.faq_id}.getById[textareaId${row.faq_id}].exec("UPDATE_CONTENTS_FIELD", []);
							  alert("hi");
							  var tmp = document.getElementById(id).value;
							  alert(tmp);
							  return true;
						    }
						  </script>
		                <% 	}
			              }%>
		              </div>
		              
		            </c:forEach>
		          </div>
          		</c:when>
          		<c:otherwise>
          		  <div class="no-accordion">
          			<p class="faq-no-result">검색된 자료가 없습니다 :(</p>
          		  </div>
          		</c:otherwise>
        	</c:choose>
          <div>
            <ul>
              <c:if test="${pagination.curRange != 1}">
              	<li class="page-num"><a onclick="paging('${curURL}', '1', '${keyword}')"> [처음] </a></li>
              </c:if>
              <c:if test="${pagination.curPage != 1}">
              	<li class="page-num"><a onclick="paging('${curURL}', '${pagination.prevPage}', '${keyword}')"> [이전] </a></li>
              </c:if>
              <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
              	<c:choose>
              		<c:when test="${pageNum == pagination.curPage}">
              		  <li class="page-num"><a class="page-num-selected" onclick="paging('${curURL}', ${pageNum}, '${keyword}')"> ${pageNum} </a></li>
              		</c:when>
              		<c:otherwise>
              		  <li class="page-num"><a onclick="paging('${curURL}', ${pageNum}, '${keyword}')"> ${pageNum} </a></li>
              		</c:otherwise>
            	</c:choose>
              </c:forEach>
              <c:if test="${pagination.curPage != pagination.pageCnt && pagination.pageCnt > 0}">
              	<li class="page-num"><a onclick="paging('${curURL}', '${pagination.nextPage}', '${keyword}')"> [다음] </a></li>
              </c:if>
              <c:if test="${pagination.curRange != pagination.rangeCnt && pagination.rangeCnt > 0}">
                <li class="page-num"><a onclick="paging('${curURL}', '${pagination.pageCnt}', '${keyword}')"> [끝] </a></li>
              </c:if>
            </ul>
          </div>
          [FOR DEBUG] 총 게시글 수 : ${pagination.listCnt} / 총 페이지수 : ${pagination.pageCnt} / 현재 페이지 : ${pagination.curPage } / 현재 블럭 : ${pagination.curRange } / 총 블럭 수 : ${pagination.rangeCnt }
        </div>
      </div>
    </div>

    <jsp:include page="./footer.jsp"></jsp:include>
  </div>

  <!-- 모바일 시작 -->
  <div id="omeran_mob_all">
    <div id="m_index">
      <img src="img/m_index.png" id="m_main_img">
      <a href="p1.html" id="m_logo_area"></a>

      <div id="m_p1_header">
        <jsp:include page="./mobMenu.jsp"></jsp:include>
      </div>

      <div id="m_p1_foo_menu">
        <ul>
          <li><a href="#" class="m_index_main">오메란의 특별한 생산환경</a></li>
          <li>
            <p>|</p>
          </li>
          <li><a href="#" class="m_index_main">오메란의 오메가 함유</a></li>
          <li>
            <p>|</p>
          </li>
          <li><a href="#" class="m_index_main">오메가3의 장점</a></li>
        </ul>
      </div>

    </div>

    <div id="m_p1_footer">
      <jsp:include page="./mobFooter.jsp"></jsp:include>
    </div>
  </div>

</body>

</html>

 --%>