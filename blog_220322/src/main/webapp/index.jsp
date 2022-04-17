<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>index</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
	<style>
			img { display: block; margin: 0px auto; }
			footer{ position:fixed; 
					left:0px; 
					bottom:0px; 
					height:30px; 
					width:100%; 
					background:#f3969a; 
					color: white; }
	</style>
</head>
<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<br>
<br>
<br>
<div class="container">		
	<div>
		<img src="<%=request.getContextPath()%>/inc/Logo.png" style="width:300px; height:300px; text-align:center;">
	</div>
	<br>
	
	<!-- 상단 제목 -->
	<div class = "container text-secondary" style = "text-align:center;">
		<h1 class = "text-secondary"><b>H O M E</b></h1>
	</div>

	<div>
		<table class="table text-center table-hover table-borderless">
				<tr>
					<td><h3><a href="<%= request.getContextPath() %>/board/boardList.jsp" class = "text-secondary">게시판</a></h3></td>
				</tr>
				<tr>
					<td><h3><a href="<%= request.getContextPath() %>/guestbook/guestbookList.jsp" class = "text-secondary">방명록</a></h3></td>
				</tr>
				<tr>
					<td><h3><a href="<%= request.getContextPath() %>/photo/photoList.jsp" class = "text-secondary">사진</a></h3></td>
				</tr>
				<tr>
					<td><h3><a href="<%= request.getContextPath() %>/pdf/pdfList.jsp" class = "text-secondary">PDF 자료실</a></h3></td>
				</tr>
		</table>
	</div>
</div>
<footer> &nbsp; &nbsp; &nbsp; creators : minseo &nbsp; &nbsp; &nbsp; email : fomalhaut612@naver.com   </footer>
</body>
</html>