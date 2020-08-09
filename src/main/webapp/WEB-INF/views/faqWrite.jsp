<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
  <title>FAQ: 글 작성하기</title>
  <%@ include file="./header.jsp" %>
  <!-- Smart Editor -->
  <script type="text/javascript" src="<%=request.getContextPath()%>/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>
</head>

<script type="text/javascript">
  $(document).ready(function() {
    $("#list").on("click", function(e) {
      e.preventDefault();
      fn_openBoardList();
    });

    $("#write").on("click", function(e) { //작성하기 버튼
      e.preventDefault();
      fn_insertBoard();
    });
  });

  function fn_openBoardList() {
    var comSubmit = new ComSubmit();
    comSubmit.setUrl("<c:url value='faq' />");
    comSubmit.submit();
  }

  function fn_insertBoard() {
    var comSubmit = new ComSubmit("frm");
    comSubmit.setUrl("<c:url value='/insertBoard' />");
    comSubmit.submit();
  }

  function mysubmit() {
    var myform = document.forms['faq-write'];
    if (myform['TITLE'].value.length < 1) {
      alert('제목 입력하세요.');
      return false;
    }
    if (myform['CONTENTS'].value.length < 1) {
      alert('내용을 입력하세요.');
      return false;
    }
    fn_insertBoard();
    return true;
  }
</script>

<body>

  <div id="body_wrapper">
    <jsp:include page="./popupMail.jsp"></jsp:include>
    <jsp:include page="./mobSidebar.jsp"></jsp:include>
    <jsp:include page="./login.jsp"></jsp:include>
    <jsp:include page="./mobOpenSidebar.jsp"></jsp:include>

    <header id="p2_header">
      <!-- PC only 헤더 -->
      <img src="img/p1_top_banner.png" class="p2_top_banner only-pc">
      <a href="index" class="p2_top_logo only-pc" id="p1_top_logoc"><img src="img/p1_top_logo.png" alt=""></a>
      <div id="top_right" class="p2_util p1_util only-pc">
        <jsp:include page="./topRight.jsp"></jsp:include>
      </div>
      <div id="p1_menu01" class="p2_menu01 only-pc">
        <jsp:include page="./menuLeft.jsp"></jsp:include>
      </div>
      <div id="p1_menu02" class="p2_menu02 only-pc">
        <jsp:include page="./menuRight.jsp"></jsp:include>
      </div>

      <!-- Mobile only 헤더 -->
      <img src="img/m_index.png" class="p2_top_banner only-mobile">
      <a href="index" id="m_logo_area" class="only-mobile"></a>
      <div id="m_p1_header" class="only-mobile">
        <jsp:include page="./mobMenu.jsp"></jsp:include>
      </div>
    </header>

    <!-- FAQ Write Content -->
    <div class="faq-mid">
      <div class="faq-mid-menu">
        <p class="faq-title">FAQ 글쓰기</p>
        <div class="faq-mid-line"></div>

        <div class="faq-write-container">
          <form name="faq-write" id="frm" onsubmit="return editorToTextarea() & mysubmit()" action="" method="post">
            <input type="hidden" name="writer" value="<% out.println(session.getAttribute("u_id")); %>">
            <div class="faq-input-container">
              <p class="faq-label">제목</p>
              <input name="TITLE" type="text" class="faq-form-input" placeholder="FAQ 게시판에 노출될 질문의 제목을 입력해주세요.">
            </div>
            <div class="faq-input-container">
              <p class="faq-label">FAQ 답변</p>
              <textarea style="width: 100%; min-width: 280px;" id="CONTENTS" name="CONTENTS" rows="8" cols="80" placeholder="질문에 대한 답변을 달아주세요."></textarea>
            </div>
            <div class="faq-btn-container">
              <input type="button" class="faq-submit" value="뒤로가기" onclick="moveAjax('faq')">
              <input type="submit" class="faq-submit" value="글쓰기">
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- PC only footer -->
    <footer id="p2_footer" class="only-pc">
      <jsp:include page="./footer.jsp"></jsp:include>
    </footer>

    <!-- Mobile only footer -->
    <div id="m_p1_footer" class="only-mobile footer-disable-background">
      <jsp:include page="./mobFooter.jsp"></jsp:include>
    </div>
  </div>

  <script type="text/javascript">
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
      oAppRef: oEditors,
      elPlaceHolder: "CONTENTS",
      sSkinURI: "<%=request.getContextPath()%>/se2/SmartEditor2Skin.html",
      fCreator: "createSEditor2"
    });
  </script>
  <script type="text/javascript">
    function editorToTextarea() {
      // 에디터의 내용이 textarea에 적용된다.
      oEditors.getById["CONTENTS"].exec("UPDATE_CONTENTS_FIELD", []);

      return true;
    }

    //textArea에 이미지 첨부
    function pasteHTML(filepath) {
      var sHTML = '<img src="<%=request.getContextPath()%>/uploadFolder/' + filepath + '">';
      oEditors.getById["CONTENTS"].exec("PASTE_HTML", [sHTML]);
    }
  </script>
</body>

</html>
