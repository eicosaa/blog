<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>insertPdfForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
</head>
<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<br>
<br>

<!-- 상단 제목 -->
<div class = "container text-secondary" style = "text-align:center;">
	<h1 class = "text-secondary">PDF INSERT</h1>
</div>
<br>			
<div class = "container">
	<div>
		<form action="<%= request.getContextPath() %>/pdf/insertPdfAction.jsp" method="post" enctype="multipart/form-data">
			<table class = "table table-active">
				<tr>
					<td class = "text-secondary">PDF 파일</td>
					<td class = "bg-light"><input type = "file" name = "pdf" class = "custom-file"></td>
				</tr>
				<tr>
					<td class = "text-secondary">비밀번호</td>
					<td class = "bg-light"><input type = "password" name = "pdfPw" class = "form-control"></td>
				</tr>
				<tr>
					<td class = "text-secondary">글쓴이</td>
					<td class = "bg-light"><input type = "text" name = "writer" class = "form-control"></td>
				</tr>
			</table>
			<button type = "submit" class = "btn btn-outline-secondary">PDF 등록</button>
			<a href="<%= request.getContextPath() %>/pdf/pdfList.jsp" class = "btn btn-outline-secondary float-right">이전 페이지</a>
		</form>
	</div>
</div>
</body>
</html>