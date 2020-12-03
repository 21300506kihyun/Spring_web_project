<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="지역기반 신선식품 배송 플랫폼 입니다.">
  <meta name="author" content="">
  <title>오메란몰: 지역기반 신선식품 유통 플랫폼</title>
  <%@ include file="./header.jsp" %>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/shop-homepage.css" type="text/css">
  <style>
  	.top-image{
  		width: 900px !important; 
  		height: 250px !important; 
  		object-fit: cover;
  	}
  	.mall-image{
  		width: 700px !important;
  		height: 200px !important;
  		object-fit: cover;
  	}
  </style>
</head>

<body>
  <div id="body_wrapper">
	<jsp:include page="./popupMail.jsp"></jsp:include>
	<jsp:include page="./login.jsp"></jsp:include>
	<!-- Navigation -->
	  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	    <div class="container">
	      <a class="navbar-brand" href="${pageContext.request.contextPath}/">지역기반 신선식품 유통 플랫폼</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="navbar-toggler-icon"></span>
	      </button>
	      <div class="collapse navbar-collapse" id="navbarResponsive">
            <jsp:include page="./platformTopRight.jsp"></jsp:include>
	      </div>
	    </div>
	  </nav>
	
	  <!-- Page Content -->
	  <div class="container">
	
	    <div class="row">
	
	      <div class="col-lg-3">
	
	        <h1 class="my-4">Omeranmall</h1>
	        <div class="list-group">
	          <a href="${pageContext.request.contextPath}/" class="list-group-item">전체</a>
	        </div>
	
	      </div>
	      <!-- /.col-lg-3 -->
	
	      <div class="col-lg-9">
	
	        <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
	          <ol class="carousel-indicators">
	            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
	            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
	            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
	          </ol>
	          <div class="carousel-inner" role="listbox">
	          	<c:forEach items="${mallList}" var="row" varStatus="idx">
	          		<c:choose>
	          			<c:when test="${idx.count == 1}">
		          			<div class="carousel-item active">
				              <img class="d-block img-fluid top-image" src="${pageContext.request.contextPath}/uploadFolder/${row.represent_img}" alt="${idx.count}th slide">
				            </div>
	          			</c:when>
	          			<c:otherwise>
			          		<div class="carousel-item">
				              <img class="d-block img-fluid top-image" src="${pageContext.request.contextPath}/uploadFolder/${row.represent_img}" alt="${idx.count}th slide">
				            </div>
	          			</c:otherwise>
	          		</c:choose>
	          	</c:forEach>
	          </div>
	          <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
	            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	            <span class="sr-only">Previous</span>
	          </a>
	          <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
	            <span class="carousel-control-next-icon" aria-hidden="true"></span>
	            <span class="sr-only">Next</span>
	          </a>
	        </div>
	
			<div class="row">
	          <c:forEach items="${mallList}" var="row" varStatus="idx">
		          <div class="col-lg-4 col-md-6 mb-4">
		            <div class="card h-100">
		              <a href="./${row.mall_name}/"><img class="card-img-top mall-image" src="${pageContext.request.contextPath}/uploadFolder/${row.represent_img}"></a>
		              <div class="card-body">
		                <h4 class="card-title">
		                  <a href="./${row.mall_name}/">${row.mall_name}</a>
		                </h4>
		                <h5>${row.farm_name}</h5>
		                <p class="card-text">${row.farm_detail}</p>
		              </div>
		              <div class="card-footer">
		                <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
		              </div>
		            </div>
		          </div>
	          </c:forEach>
	        </div>
	      </div>
	      <!-- /.col-lg-9 -->
	
	    </div>
	    <!-- /.row -->
	
	  </div>
	  <!-- /.container -->
	
	  <!-- Footer -->
	  <footer class="py-5 bg-dark">
	    <div class="container">
	      <p class="m-0 text-center text-white">Copyright &copy; WA-lab 2020 Capstone Team</p>
	    </div>
	    <!-- /.container -->
	  </footer>
	
	  <!-- Bootstrap core JavaScript -->
	  <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	  <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
	</div>

</body>

</html>
