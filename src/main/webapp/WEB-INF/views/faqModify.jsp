<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
  <title>고용량 오메가3 함요 : 자연방사유정란 오메란</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" />
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/common.js"></script>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
  <!-- 스마트에디터 -->
  <%-- <script type="text/javascript" src="${pageContext.request.contextPath}/smartEditor/js/service/HuskyEZCreator.js" charset="utf-8"></script> --%>
  <script type="text/javascript" src="<%=request.getContextPath() %>/smartEditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<script type="text/javascript"> 

	$(document).ready(function(){ 
		$("#list").on("click", function(e){ 
			e.preventDefault(); 
			fn_openBoardList(); 
		}); 
		
		$("#write").on("click", function(e){ //작성하기 버튼 
			e.preventDefault(); 
			fn_updateBoard(); 
		}); 
	}); 
	function fn_openBoardList(){ 
		var comSubmit = new ComSubmit(); 
		comSubmit.setUrl("<c:url value='faq' />"); 
		comSubmit.submit(); 
	} 
	
	function fn_updateBoard(){ 
		var comSubmit = new ComSubmit("frm"); 
		comSubmit.setUrl("<c:url value='/faq.modify' />"); 
		comSubmit.submit(); 
	}

	function mysubmit() {
	    var myform = document.forms['faq-modify'];
	    if( myform['title'].value.length < 1) {
	        alert('제목 입력하세요.');
	        return false;
	    }
	    if( myform['contents'].value.length < 1) {
	        alert( '내용을 입력하세요.');
	        return false;
	    }
	    fn_updateBoard();
	    return true;
	}

</script>

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
        <p class="faq-title">FAQ 글수정하기 (관리자 전용)</p>
        <div class="faq-mid-line"></div>

		<div class="faq-write-container">
		  <form name="faq-modify" id ="frm" onsubmit="return editorToTextarea() & mysubmit()" action="" method="post">
		  	<input type="hidden" name="writer" value="<% out.println(session.getAttribute("u_id")); %>">
		  	<input type="hidden" name="faq_id" value="${faq_id}">
			<div class="faq-input-container">
				<p class="faq-label">제목</p>
				<input name="title" type="text" class="faq-form-input" placeholder="FAQ 게시판에 노출될 질문의 제목을 입력해주세요." value="${title}">
			</div>
			<div class="faq-input-container">
				<p class="faq-label">FAQ 답변</p>
				<textarea style="width: 100%" id="contents" name="contents" rows="8" cols="50" placeholder="질문에 대한 답변을 달아주세요.">${content}</textarea>	
			</div>
			<div class="faq-btn-container">
				<input type="button" class="faq-submit" value="뒤로가기" onclick="moveAjax('faq')">
				<input type="submit"  class="faq-submit" value="글쓰기">
			</div>
		  </form>
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
          <li><p>|</p></li>
          <li><a href="#" class="m_index_main">오메란의 오메가 함유</a></li>
          <li><p>|</p></li>
          <li><a href="#" class="m_index_main">오메가3의 장점</a></li>
        </ul>
      </div>

    </div>

    <div id="m_p1_footer">
      <jsp:include page="./mobFooter.jsp"></jsp:include>
    </div>
  </div>


<script type="text/javascript">
  var oEditors = [];
  nhn.husky.EZCreator.createInIFrame({
	  oAppRef: oEditors,
	  elPlaceHolder: "contents",
	  sSkinURI: "<%=request.getContextPath() %>/smartEditor/SmartEditor2Skin.html",
	  fCreator: "createSEditor2"
  });
</script>
<script type="text/javascript">
  function editorToTextarea(){
	  // 에디터의 내용이 textarea에 적용된다.
	  oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
	  
	  return true;
  }
</script>
</body>

</html>
