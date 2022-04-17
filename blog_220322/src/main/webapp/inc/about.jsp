<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>About</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
<style>
	img { display: block; margin: 0px auto; }
	
	footer{ position:fixed; 
	  		left:0px; 
	  		bottom:0px; 
	  		height:30px; 
	  		width:100%; 
	  		background:#f3969a; 
	  		color: white; 
	}
</style>
</head>
<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<br>
<br>
<div class="container">
	<!-- 상단 제목 -->
	<div class = "container text-secondary" style = "text-align:center;">
		<img src="<%=request.getContextPath()%>/inc/img.png" alt="img" style="width:500px; height:500px; text-align:center;">
		<h1 class = "text-secondary">ABOUT CREATORS</h1>
	</div>
	
	<div class = "row">
		<div class = "col-sm-3"></div>
		<div class = "col-sm-6">
			<table class = "table" style = "text-align:left;" style="table-layout: fixed;">
				<tr>
					<td class = "text-secondary">creators</td>
					<td class = "text-secondary">Kim min seo</td>
				</tr>
				<tr>
					<td class = "text-secondary">email</td>
					<td class = "text-secondary">fomalhaut612@naver.com</td>
				</tr>
				<tr>
					<td class = "text-secondary">github</td>
					<td>
						<a href = "https://github.com/eicosaa/blog" class = "text-info">https://github.com/eicosaa/blog</a>
						<span class = "badge bg-warning">click the link!</span>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
</div>
<footer> &nbsp; &nbsp; &nbsp; creators : minseo &nbsp; &nbsp; &nbsp; email : fomalhaut612@naver.com </footer>
</body>
</html>