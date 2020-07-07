<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
  <title>p4</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <link href="css/common.css" rel="stylesheet" type="text/css">
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/common.js"></script>
</head>

<body>
  <div id="omeran_pc_all">

    <header id="p2_header">

      <jsp:include page="./popupMail.jsp"></jsp:include>

      <img src="img/p4_top_banner.png" class="p2_top_banner">
      <a href="index" class="p2_top_logo"><img src="img/p1_top_logo.png" alt=""></a>
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

    <div id="p4_mid">
      <img src="img/p4_mid_img.png" alt="" class="p4_mid_img">
      <img src="img/p4_mid_img2.png" alt="" class="p4_mid_img2">

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
          꼼꼼하게 세착해야 유통이 가능합니다.<br>
          또한, 주기적으로 자가품질검사를 통해 다양한 테스트를 진행해<br>
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
      <div class="p5_pra01">
        <p class="p5_pra_title">산란일과 유통기한은?</p>
        <p class="p5_pra_sub">
          산란한지 5일 이내의 달걀을 취급을 기준으로하며,<br>
          판매자가 직접 냉장 배달을 지향하고 있습니다.<br>
          제품의 섭취 가능한 기간은 산란일자로부터 약 한 달간입니다.<br>
          소비자의 보관 상태에 따라 섭취 가능 기한은 상이할 수 있습니다.
        </p>
      </div>
    </div>

    <jsp:include page="./footer.jsp"></jsp:include>
  </div>

  <!-- 모바일 시작 -->
  <div id="omeran_mob_all">
    <div id="m_p3_all">

      <div id="m_index">
        <img src="img/m_p4.png" id="m_p3_img">
        <a href="p1.html" id="m_logo_area" class="m_logo_area_p4"></a>

        <div id="m_p1_header" class="m_p3_header_only">
          <jsp:include page="./mobMenu.jsp"></jsp:include>
        </div>
      </div>

      <div id="m_p3_bottom">
        <img src="img/m_p4_bottom.png" alt="">
      </div>

      <div class="m_p4_pra1">
        <p class="mp4_pra_title">닭이 자라는 환경은?</p>
        <p class="mp4_pra_sub">사육환경은 동물복지 인증을 충족하는 농장에서 닭들이 자유롭게 이동하며 자라며
          유기농 인증을 받은 곡물 사료와 더불어 고용량 오메가 함량을 위한
          연구개발된 혼합 된 사료를 닭에게 제공합니다.</p>
      </div>

      <div class="m_p4_pra1">
        <p class="mp4_pra_title">안전하고 깨끗한가요?</p>
        <p class="mp4_pra_sub">자연방사를 하게 되면 다양한 환경에 산란을 하기에 분료 및 이물질을
          꼼꼼하게 세착해야 유통이 가능합니다.
          또한, 주기적으로 자가품질검사를 통해 다양한 테스트를 진행해
          동일한 품질을 유지하기 위해 최선을 다하고 있습니다.</p>
      </div>

      <div class="m_p4_pra1 mp4p_back">
        <p class="mp4_pra_title">오메란의 생산철학</p>
        <p class="mp4_pra_sub">저희 오메란은 철저한 계획 생산을 목표로 하고 있습니다.
          계란 한 알에 함유되어야할 영양분의 품질을 유지하기 위해
          한정된 수량만 산란하고 있습니다.
          한정된 수량은 “특별한 냉장배송”으로 생산자가 소비자에게
          1:1로 직접 배달을 목표로 삼고 있습니다.</p>
      </div>

      <div class="m_p4_pra1 mp4p_fin">
        <p class="mp4_pra_title">산란일과 유통기한은?</p>
        <p class="mp4_pra_sub">산란한지 5일 이내의 달걀을 취급을 기준으로하며,
          판매자가 직접 냉장 배달을 지향하고 있습니다.
          제품의 섭취 가능한 기간은 산란일자로부터 약 한 달간입니다.
          소비자의 보관 상태에 따라 섭취 가능 기한은 상이할 수 있습니다.</p>
      </div>

      <div id="m_p1_footer" class="m_p3_only_footer">
        <jsp:include page="./mobFooter.jsp"></jsp:include>
      </div>

    </div>
  </div>

</body>

</html>
