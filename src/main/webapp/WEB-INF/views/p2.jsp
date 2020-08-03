<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
  <title>p2</title>
  <meta charset="utf-8">
  <%@ include file="./header.jsp" %>
</head>

<body>
  <div id="omeran_pc_all">

    <header id="p2_header">

      <jsp:include page="./popupMail.jsp"></jsp:include>

      <img src="img/p2_top_banner.png" class="p2_top_banner">
      <a href="index" class="p2_top_logo"><img src="img/p2_top_logo.png" alt=""></a>
      <div class="p2_util">
        <jsp:include page="./topRight.jsp"></jsp:include>
      </div>
      <div class="p2_menu01">
        <jsp:include page="./menuLeft.jsp"></jsp:include>
      </div>
      <div class="p2_menu02">
        <jsp:include page="./menuRight.jsp"></jsp:include>
      </div>
    </header>

    <jsp:include page="./login.jsp"></jsp:include>

    <div id="p2_mid" class="p2_mid_only">
      <img src="img/p2_mid_img.png" alt="" class="p2_mid_img p2mid_only">
      <img src="img/p2_mid_img2.png" alt="" class="p2_mid_img2">
      <img src="img/p2_mid_img3.png" alt="" class="p2_mid_img3">
    </div>
    <jsp:include page="./footer.jsp"></jsp:include>
  </div>

  <!-- 모바일 시작 -->
  <div id="omeran_mob_all">
    <jsp:include page="./mobSidebar.jsp"></jsp:include>
    <jsp:include page="./popupMail.jsp"></jsp:include>
    <jsp:include page="./login.jsp"></jsp:include>

    <div id="m_index">
      <jsp:include page="./mobOpenSidebar.jsp"></jsp:include>
      <img src="img/m_p2.png" id="m_p2_img">
      <a href="index" id="m_logo_area" class="m_logo_area_p2"></a>

      <div id="m_p1_header" class="m_p2_header_only">
        <jsp:include page="./mobMenu.jsp"></jsp:include>
      </div>

    </div>

    <div id="m_p1_footer" class="m_p2_foot_only">
      <jsp:include page="./mobFooter.jsp"></jsp:include>
    </div>
  </div>

</body>

</html>
