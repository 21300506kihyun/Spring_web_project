<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
  <title>${siteName}에 오신 것을 환영합니다.</title>
  <!-- <title>고용량 오메가3 함요 : 자연방사유정란 오메란</title> -->
  <%@ include file="./header.jsp" %>
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

    <!-- p1 content(반응형) -->
    <div id="p1_mid">
      <div class="p1_thro_line"></div>
      <div class="p1_mid_menu">
        <ul>
          <li><a href="#">오메란의 특별한 생산환경</a></li>
          <li><p>|</p></li>
          <li><a href="#">오메란의 오메가 함유</a></li>
          <li><p>|</p></li>
          <li><a href="#">오메가3의 장점</a></li>
        </ul>
      </div>
    </div>
    
    <!-- PC only footer -->
    <footer id="p2_footer" class="only-pc">
      <jsp:include page="./footer.jsp"></jsp:include>
    </footer>

    <!-- Mobile only footer -->
    <div id="m_p1_footer" class="only-mobile">
      <jsp:include page="./mobFooter.jsp"></jsp:include>
    </div>

  </div>

</body>

</html>
