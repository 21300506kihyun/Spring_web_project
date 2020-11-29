<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
  <title>p4</title>
  <%@ include file="./header.jsp" %>
</head>

<body>
  <div id="body-wrapper">
    <jsp:include page="./popupMail.jsp"></jsp:include>
    <jsp:include page="./mobSidebar.jsp"></jsp:include>
    <jsp:include page="./login.jsp"></jsp:include>
    <jsp:include page="./mobOpenSidebar.jsp"></jsp:include>
    
    <header id="p2_header">
	  <!-- PC only header -->
      <img src="${pageContext.request.contextPath}/img/p4_top_banner.png" class="p2_top_banner only-pc">
      <a href="index" class="p2_top_logo only-pc"><img src="${pageContext.request.contextPath}/img/p1_top_logo.png" alt=""></a>
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
      	<jsp:include page="./mobOpenSidebar.jsp"></jsp:include>
        <img src="${pageContext.request.contextPath}/img/m_p4.png" id="m_p3_img">
        <a href="index" id="m_logo_area" class="m_logo_area_p4"></a>

        <div id="m_p1_header" class="m_p3_header_only">
          <jsp:include page="./mobMenu.jsp"></jsp:include>
        </div>
      </div>
    </header>
    
    <!-- p4 content -->
    <div id="p4_mid">
      <img src="${pageContext.request.contextPath}/img/p4_mid_img.png" alt="" class="p4_mid_img">
      <img src="${pageContext.request.contextPath}/img/p4_mid_img2.png" alt="" class="p4_mid_img2">
      
      <div class="p5_pra01">
        <p class="p5_pra_title">닭이 자라는 환경은?</p>
        <p class="p5_pra_sub">
          사육환경은 동물복지 인증을 충족하는 농장에서 닭들이 자유롭게 이동하며 자라며<br>
          유기농 인증을 받은 곡물 사료와 더불어 고용량 오메가 함량을 위한<br>
          연구개발된 혼합 된 사료를 닭에게 제공합니다.
        </p>
      </div>
      <div class="p5_pra01">
        <p class="p5_pra_title">안전하고 깨끗한가요?</p>
        <p class="p5_pra_sub">
          자연방사를 하게 되면 다양한 환경에 산란을 하기에 분료 및 이물질을<br>
          꼼꼼하게 세척해야 유통이 가능합니다.<br>
          또한, 주기적으로 자가품질검사를 통한 다양한 테스트를 진행하여<br>
          동일한 품질을 유지하기 위해 최선을 다하고 있습니다.
        </p>
      </div>
      <div class="p5_pra01 p5_spec_si">
        <p class="p5_pra_title">오메란의 생산철학</p>
        <p class="p5_pra_sub">
          저희 오메란은 철저한 계획 생산을 목표로 하고 있습니다.<br>
          계란 한 알에 함유되어야할 영양분의 품질을 유지하기 위해<br>
          한정된 수량만 산란하고 있습니다.<br>
          한정된 수량은 “특별한 냉장배송”으로 생산자가 소비자에게<br>
          1:1로 직접 배달을 목표로 삼고 있습니다.
        </p>
      </div>
      <div class="p5_pra01 p5_pra01_fin">
        <p class="p5_pra_title">산란일과 유통기한은?</p>
        <p class="p5_pra_sub">
          산란한지 5일 이내의 달걀을 취급기준으로하며,<br>
          판매자가 직접 냉장 배달을 지향하고 있습니다.<br>
          제품의 섭취 권장 기간은 산란일자로부터 약 1 개월이내입니다.<br>
          소비자의 보관 상태에 따라 섭취 가능 기한은 상이할 수 있습니다.
        </p>
      </div>
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
