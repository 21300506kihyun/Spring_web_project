<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style>
		.adminDashboard_card{
			box-shadow:0 1px 0px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12);
			background-color: #fff;
			border-radius: 2px;
			padding: 1em;
		}
		.adminDashboard_spacer{
			margin-bottom: 2em;
		}
		.adminDashboard_halfBox{
			display: flex;
			justify-content: space-between;
		}
		.adminDashboard_half{
			width: 49%;
			display: inline-block;
		}
		.adminDashboard_cardTitle{
			font-size: 20px;
			font-weight: 500;
			margin-bottom: 10px;
		}
		
	</style>
</head>
<body>
	<!-- 관리자 정보 -->
	<div class="adminDashboard_card">
		<p class="adminDashboard_cardTitle">Test#1</p>
		<p>Administration Information</p>
		<p>관리자 및 관리 사이트의 정보를 간단히 조회할 수 있습니다.</p>
		<p>넣고 싶은 내용에 대해서 말씀주세요.</p>
	</div>
	
	<div class="adminDashboard_spacer"></div>
	
	<div class="adminDashboard_halfBox">
		<div class="adminDashboard_card adminDashboard_half">
			<p class="adminDashboard_cardTitle">Test#2</p>
			<p>Chart of Statistic<br>
			추후에 사이트 관리에 도움이 될 수 있는 그래프가 들어갈 수 있습니다.</p>
		</div>
		
		<div class="adminDashboard_card adminDashboard_half">
			<p class="adminDashboard_cardTitle">Test#3</p>
			<p>Chart of Statistic<br>
			추후에 사이트 관리에 도움이 될 수 있는 그래프가 들어갈 수 있습니다.</p>
		</div>
	</div>
</body>
</html>