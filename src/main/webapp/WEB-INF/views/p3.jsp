<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
  <title>${siteName}에 오신 것을 환영합니다.</title>
  <%@ include file="./header.jsp" %>
</head>

<body>
  <div id="body-wrapper">
    <jsp:include page="./popupMail.jsp"></jsp:include>
    <jsp:include page="./mobSidebar.jsp"></jsp:include>
    <jsp:include page="./login.jsp"></jsp:include>
    <jsp:include page="./mobOpenSidebar.jsp"></jsp:include>
    
    <header id="p2_header">
      <!-- PC only 헤더 -->
      <img src="${pageContext.request.contextPath}/img/p3_top_banner.png" class="p2_top_banner only-pc">
      <a href="index" class="p2_top_logo only-pc"><img src="${pageContext.request.contextPath}/img/p3_top_logo.png" alt=""></a>
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
        <img src="${pageContext.request.contextPath}/img/m_p3.png" id="m_p3_img">
        <a href="index" id="m_logo_area" class="m_logo_area_p3"></a>

        <div id="m_p1_header" class="m_p3_header_only">
          <jsp:include page="./mobMenu.jsp"></jsp:include>
        </div>
      </div>
    </header>
    
    <!-- p3 content -->
    <div id="p2_mid" class="p3_mid_only">
      <div class="p3_pra01">
        <p>인체에서 합성되지 않지만 정상성장과 혈관건강유지를 위한<br>
          <span>알파-리놀렌산(ALA), 에이코사펜타엔산(EPA), 도코사헥사엔산(DHA)</span>으로 대표되는<br>
          대사에 필수적인 영양학적으로 중요한 불포화 지방산입니다.</p>

        <p>그린란드 이누이트족이 채식을 하지 않는 육식위주의 식습관에도 불구하고<br>
          심혈관계 질환을 보이지 않는 이유가 고품질의 생선 섭취가 원인임이 알려지며<br>
          심박수, 혈압, 동맥경화증이 감소된다는 사실과 함께 꾸준한 연구가 진행</p>

        <p>DHA는 신경 발생, 인지 및 신경퇴행성 질환에 역할을 하는 필수 영양소 후보이며,<br>
          EPA는 고중성지방혈증 환자에서 위약에 비해 심근 경색, 뇌졸중 및 심혈관계 질환에 의한<br>
          사망을 26% 감소시키는데 효과적임이 보고</p>

        <p>현대에 ‘필수’라는 단어의 사용은 엄격한 기준이 적용됨에도 불구하고 오메가-3는<br>
          어린이와 동물 성장 및 발달에 필수 영양소로서 확고한 영양학적 지위와 함께 눈이나 신경의 정상적인<br>
          발달을 돕고 염증치료에 작용하는 등 다양한 효능에 더불어 중요성에 대한 인식이 확대되어 가고 있습니다.</p>
      </div>
      <img src="${pageContext.request.contextPath}/img/p3_pra_img.png" alt="" class="p2_mid_img">
      <img src="${pageContext.request.contextPath}/img/p3_pra_img2.png" alt="" class="p2_mid_img2">
      <div class="p3_pra01">
        <p>오메가3와 오메가6는 뇌혈관, 심혈관 질환 및 항염증에 경쟁적으로 작용하지만<br>
          오메가6의 높은 비율의 섭취는 오히려 질환에 단점으로 작용하며<br>
          산화된 오메가6는 유방암, 전립선암 증가된 동물실험 결과를 가지고 있습니다.<br>
          가장 단순한 해결 방법은 더 많은 오메가3 지방산을 섭취하고<br>
          오메가6 지방산의 섭취를 줄이는 것입니다.<br>
          오메가3대비 이상적인 비율은 1:1~4:1 이지만<br>
          현재 서구형 식단에서는 12:1~16:1인 오메가6:오메가3의 섭취비율을<br>
          WHO가 권장하는 4:1수준으로 낮춰야 할 필요성이 강하게 제기되고 있습니다.</p>
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
