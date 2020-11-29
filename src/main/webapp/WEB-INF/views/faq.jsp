<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>

<head>
  <!-- <title>FAQ: 자연방사유정란 오메란</title> -->
  <title>FAQ: ${siteName} 쇼핑몰</title>
  <%@ include file="./header.jsp" %>
  <style>
    input[id*="faq-answer"] {display: none;}
    input[id*="faq-answer"]+label {display: block; padding: 20px; border-bottom: 1px solid #bbb; margin-bottom: 0 !important;
      color: #000; background: #fdfdfd; cursor: pointer; position: relative; text-align: left; font-size: 20px;}
    input[id*="faq-answer"] + label em { position:absolute;top:30%;left:10px;width:50px; height:50px; margin-top:-15px;
    display:inline-block; margin-right: 50px; background:url('${pageContext.request.contextPath}/img/qna.png') 0 0 no-repeat;  background-size: contain;;
    /*img source: https://www.clipartmax.com/middle/m2i8Z5b1K9G6N4K9_question-and-answer-icon-png-personal-injury/ */}
    input[id*="faq-answer"] + label p{ margin-left: 50px; font-size: 20px;}
    input[id*="faq-answer"]+label+div { max-height: 0; transition: all .35s; overflow: hidden; background: #eee;}
    input[id*="faq-answer"]+label+div div{ }
    input[id*="faq-answer"]+label+div div p { display: inline-block; padding: 20px;}
    input[id*="faq-answer"]:checked+label+div { max-height: 10000px; }
    @media screen and (max-width:768px) {
	    input[id*="faq-answer"]+label {font-size: 15px;}
	    input[id*="faq-answer"] + label em {top:50%;width:30px; height:30px;margin-right: 30px;}
	    input[id*="faq-answer"] + label p{ margin-left: 30px; font-size: 15px;}
	    input[id*="faq-answer"]+label+div { }
	    input[id*="faq-answer"]+label+div div{ }
	    input[id*="faq-answer"]+label+div div p { }
	    input[id*="faq-answer"]:checked+label+div { }
    }
  </style>
  <script>
    var idx = 1; // form 번호 구분하기 위함
    // faq search
    function faqSearch(toUrl) {
      var formData = $("#faqSearch").serialize();

      // ajax option
      var ajaxOption = {
        url: toUrl,
        async: true,
        type: "POST",
        data: formData,
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

    // faq modify
    function faqModify(toUrl, id) {
      if (confirm("해당 글을 수정하시겠습니까?")) {
        var formId = "#" + "faqContent" + id;
        var formData = $(formId).serialize();
        // ajax option
        var ajaxOption = {
          url: toUrl,
          async: true,
          type: "POST",
          data: formData,
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
  </script>

</head>

<body>
  <div id="body_wrapper">
    <jsp:include page="./popupMail.jsp"></jsp:include>
    <jsp:include page="./mobSidebar.jsp"></jsp:include>
    <jsp:include page="./login.jsp"></jsp:include>
    <jsp:include page="./mobOpenSidebar.jsp"></jsp:include>


    <header id="p2_header">
      <!-- PC only 헤더 -->
      <img src="${pageContext.request.contextPath}/img/p1_top_banner.png" class="p2_top_banner only-pc">
      <a href="index" class="p2_top_logo only-pc" id="p1_top_logoc"><img src="${pageContext.request.contextPath}/img/p1_top_logo.png" alt=""></a>
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
      <img src="${pageContext.request.contextPath}/img/m_index.png" class="p2_top_banner only-mobile">
      <a href="index" id="m_logo_area" class="only-mobile"></a>
      <div id="m_p1_header" class="only-mobile">
        <jsp:include page="./mobMenu.jsp"></jsp:include>
      </div>
    </header>

    <!-- FAQ content -->
    <div class="faq-mid">
      <div class="faq-mid-menu">
        <p class="faq-title">FAQ: 자주 묻는 질문</p>
        <div class="faq-mid-line"></div>


        <div class="faq-div">
          <form id="faqSearch" method="post" action="faq" onsubmit="faqSearch('${curURL}'); return false;">
            <input name="faqKeyword" type="text" id="find_input" class="faq-input" placeholder="제목을 검색해주세요." value="${keyword}">
            <input type="submit" class="faq-submit" value="검색하기">
            <% if(session.getAttribute("user_category") != null){
	              		if((int)session.getAttribute("user_category") == -2 || 
	              				((int)session.getAttribute("user_category") == -1 && (int)session.getAttribute("mall_id") == (int)session.getAttribute("curr_mall_id"))){%>
            <input type="button" class="faq-submit" value="글쓰기" onclick="moveAjax('faqWrite')">
              		<%  }
		       } %>
          </form>
        </div>
<% out.println(session.getAttribute("curr_mall_id")); %>
<% out.println(session.getAttribute("mall_id")); %>
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
                    <div style="text-align: left;">
                      <p>${row.content}</p>
                    </div>
                    <% if(session.getAttribute("user_category") != null){
		              		if((int)session.getAttribute("user_category") == -2 || 
		              				((int)session.getAttribute("user_category") == -1 && (int)session.getAttribute("mall_id") == (int)session.getAttribute("curr_mall_id"))){%>
                    <form name="faqContent${row.faq_id}" id="faqContent${row.faq_id}" onsubmit="faqModify('faqModify', '${row.faq_id}'); return false;" action="" method="post">
                      <input type="hidden" name="title" value="${row.title}">
                      <input type="hidden" name="faq_id" value="${row.faq_id}">
                      <textarea style="display: none" name="content">${row.content}</textarea>
                      <div class="faq-admin-btn-container">
                        <input type="submit" class="faq-admin-btn" value="수정하기">
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

    <!-- PC only footer -->
    <footer id="p2_footer" class="only-pc">
      <jsp:include page="./footer.jsp"></jsp:include>
    </footer>

    <!-- Mobile only footer -->
    <div id="m_p1_footer" class="only-mobile footer-disable-background">
      <jsp:include page="./mobFooter.jsp"></jsp:include>
    </div>
  </div>

</body>

</html>
