<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<title>고용량 오메가3 함요 : 자연방사유정란 오메란</title>
	<%@ include file="./header.jsp" %>
</head>

<body>
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
                        <h1><a href="index">Omeran</a></h1>
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
  							if(userName != null){ %>
							  	<a href="#mypage"><% out.println(session.getAttribute("user_name")); %> 님</a>
								<a onclick="moveAjax('logout.do')" class="popup-btn">로그아웃</a>
							  <% }else{ %>
							   	<a href="#login" class="popup-btn">로그인</a>
							  <% } %>
							  <a href="#form-mail-popup" class="popup-btn">회원가입</a>
							  <a href="#form-mail-popup" class="popup-btn">리셀러 회원신청</a>
					      </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="canvas__open">
                <i class="fa fa-bars"></i>
            </div>
        </div>
    </header>
    <!-- Header Section End -->
    
        <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="./index.html"><i class="fa fa-home"></i> Home</a>
                        <span>구매하기</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Checkout Section Begin -->
    <section class="checkout spad">
        <div class="container">
            <form action="#" class="checkout__form">
                <div class="row">
                    <div class="col-lg-8">
                        <h5>주문자 정보</h5>
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="checkout__form__input">
                                    <p> 이름 : ${userInfo.user_name} </p>
                                    <p> 휴대폰 : ${userInfo.telephone} </p>
                                    <p> 이메일 : ${userInfo.email} </p>
                                </div>
                            </div>
                       </div>
                      <h5>배송지 정보</h5>
                      <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="checkout__form__input">
                                    <p> 우편번호 : ${address.address01} </p>
                                    <p> 주소 : ${address.address02} </p>
                                    <p> 상세주소 : ${address.address03} </p>
                                </div>
                            </div>                   
                       </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="checkout__order">
                                <h5> 상품정보 </h5>
                                <div class="checkout__order__product">
                                    <ul>
                                        <li>
                                            <span class="top__text">상품 </span>
                                            <span class="top__text__right"> 가격 </span>
                                        </li>
                                        <li>${detail.product_name}<span>${detail.price}</span></li>
                                    </ul>
                                </div>
                                <div class="checkout__order__total">
                                    <ul>
                                        <li>총 가격 <span>${detail.price}</span></li>
                                    </ul>
                                </div>
                                <button type="submit" class="site-btn">구매하기 </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </section>
        <!-- Checkout Section End -->

        <!-- Js Plugins -->
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <script src="js/mixitup.min.js"></script>
        <script src="js/jquery.countdown.min.js"></script>
        <script src="js/jquery.slicknav.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.nicescroll.min.js"></script>
        <script src="js/main.js"></script>
          <!-- jQuery -->
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <!-- iamport.payment.js -->
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    </body>

    </html>

</body>
</html>