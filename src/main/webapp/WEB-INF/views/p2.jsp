<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
  <title>p2</title>
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
      <img src="img/p2_top_banner.png" class="p2_top_banner only-pc">
      <a href="index" class="p2_top_logo only-pc"><img src="img/p2_top_logo.png" alt=""></a>
      <div class="p2_util only-pc">
        <jsp:include page="./topRight.jsp"></jsp:include>
      </div>
      <div class="p2_menu01 only-pc">
        <jsp:include page="./menuLeft.jsp"></jsp:include>
      </div>
      <div class="p2_menu02 only-pc">
        <jsp:include page="./menuRight.jsp"></jsp:include>
      </div>
      
      <!-- Mobile only 헤더 -->      
      <div id="m_index" class="only-mobile">
        <img src="img/m_p2_header.png" id="m_p3_img">
        <a href="index" id="m_logo_area" class="m_logo_area_p3"></a>

        <div id="m_p1_header" class="m_p2_header_only_v2">
          <jsp:include page="./mobMenu.jsp"></jsp:include>
        </div>
      </div>
    </header>
    
    <!-- p2 content -->
    <div id="p2_mid" class="p2_mid_only">
      <img src="img/p2_mid_img.png" alt="" class="p2_mid_img p2mid_only">
      <img src="img/p2_mid_img2.png" alt="" class="p2_mid_img2">
      <img src="img/p2_mid_img3.png" alt="" class="p2_mid_img3">
    </div>
    
    
    <!-- PC only footer -->
    <footer id="p2_footer" class="only-pc">
      <jsp:include page="./footer.jsp"></jsp:include>
    </footer>

    <!-- Mobile only footer -->
    <div id="m_p1_footer" class="m_p2_foot_only only-mobile">
      <jsp:include page="./mobFooter.jsp"></jsp:include>
    </div>
    
  </div>
  
</body>

</html>
