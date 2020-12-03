<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<title>고용량 오메가3 함요 : 자연방사유정란 오메란</title>
	<%@ include file="./header.jsp" %>
</head>
<style>
.mall-image{
  		width: 700px !important;
  		height: 500px !important;
  		object-fit: cover;
  	}
 </style>
<body>
<div id="body_wrapper">
    <jsp:include page="./popupMail.jsp"></jsp:include>
    <jsp:include page="./mobSidebar.jsp"></jsp:include>
    <jsp:include page="./login.jsp"></jsp:include>
    <jsp:include page="./mobOpenSidebar.jsp"></jsp:include>

    <!-- Header Section Begin -->
    <header class="header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-3 col-lg-2">
                    <div class="header__logo">
                        <h1><a href="index">${siteName}</a></h1>
                    </div>
                </div>
                <div class="col-xl-6 col-lg-7">
                    <nav class="header__menu">
                        <ul>
                            <li class="active"><a href="index">Home</a></li>
                            <li><a href="p2">오메란은?</a></li>
                            <li><a href="p3">오메란 제품 소개</a></li>
                            <li><a href=".p4">오메란의 효능</a></li>
                            <li><a href="mall">오메란 쇼핑몰</a>
                            </li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-3">
                    <div class="header__right">
                        <div class="header__right__auth">
					      <div id="top_right" class="p2_util p1_util only-pc">
					        <a href="faq" class="popup-btn">FAQ</a>
							   <% String userName = (String)session.getAttribute("user_name");
							    int status = -9;
							    if(session.getAttribute("user_category") != null){
							  	  status = (int)session.getAttribute("user_category");
							    }
							    if(userName != null){ %>
							  	    <% if(status == -2){ %>
							  	    	<a href="<%= request.getContextPath() %>/superAdmin"><% out.println(session.getAttribute("user_name")); %> 님</a>
							  	    <% }else if (status == -1){  %>
							  	    	<a href="<%= request.getContextPath() %>/<% out.println(session.getAttribute("adminSiteName")); %>/admin"><% out.println(session.getAttribute("user_name")); %> 관리자님</a>
							  	    <% }else if (status == 0){  %>
							  	    	<a href="https://ovenapp.io/view/RZoY9K1tJPXTYeXnfIw1T4RZcnbDLpEe/FZNkC"><% out.println(session.getAttribute("user_name")); %> 배송기사님</a>
							  	    <% }else{  %>
							  	    	<a href="#mypage"><% out.println(session.getAttribute("user_name")); %> 고객님</a>
							  	    <% } %>
								<a onclick="moveAjax('logout.do')" class="popup-btn">로그아웃</a>
							  <% }else{ %>
							   	<a href="#login" class="popup-btn">로그인</a>
							  <% } %>
							  <a href="<%= request.getContextPath() %>/" class="popup-btn">플랫폼 메인</a>
							  <%-- <a href="register" class="popup-btn">회원가입</a> --%>
							  <%-- <a href="#form-mail-popup" class="popup-btn">리셀러 회원신청</a> --%>
					      </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- <div class="canvas__open">
                <i class="fa fa-bars"></i>
            </div> -->
        </div>
    </header>
    <!-- Header Section End -->



<!-- Product Section Begin -->
<section class="product spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-4">
                <div class="section-title">
                    <h4>전체상품</h4>
                </div>
            </div>
            <div class="col-lg-8 col-md-8">
                <ul class="filter__controls">
                    <li class="active" data-filter="*">인기순</li>
                    <li data-filter=".women">판매</li>
                    <li data-filter=".men">가격낮은순</li>
                    <li data-filter=".kid">가격높은순</li>
                    <li data-filter=".kid">${detail}</li>

                </ul>
            </div>
        </div>
          <c:choose>
            <c:when test="${pagination.listCnt != 0}">
            <div class="row property__gallery">
            	<c:forEach items="${list}" var="row">
			            <div class="col-lg-3 col-md-4 col-sm-6 mix women">
			                <div class="product__item">
			                    <div class="product__item__pic set-bg"><a href="product_detail?p_id=${row.p_id}">
			                    		<img class="mall-image" src="${pageContext.request.contextPath}/uploadFolder/${row.product_img}"></a>
<%-- 			                   		request.setAttribute("product", ${row});
			                   		<h6><a href="product_detail">Buttons tweed blazer</a></h6> --%>

			                        <div class="label new">New ${pageContext.request.contextPath}</div>
			                    </div>
			                    <div class="product__item__text">
			                   	 <h6><a href="product_detail?p_id=${row.p_id}">${row.product_name}</a></h6>
			                        <div class="rating">
			                            <i class="fa fa-star"></i>
			                            <i class="fa fa-star"></i>
			                            <i class="fa fa-star"></i>
			                            <i class="fa fa-star"></i>
			                            <i class="fa fa-star"></i>
			                        </div>
			                        <div class="product__price">₩<fmt:formatNumber type="number" maxFractionDigits="3" value="${row.discount_price}" /></div>
			                    </div>
			                </div>
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
    </div>
   </section>
</div>

<!-- Js Plugins -->
<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.magnific-popup.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath}/js/mixitup.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.countdown.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.slicknav.js"></script>
<script src="${pageContext.request.contextPath}/js/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.nicescroll.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>

</html>
