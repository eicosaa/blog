<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.PdfDao" %>
<%@ page import = "vo.Pdf" %>
<%
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
	PdfDao photoDao = new PdfDao();
	Pdf pdf = photoDao.selectPdfOne(pdfNo);
	
	// 디버깅
    System.out.println("[deletePdfForm.jsp] pdfNo : " + pdfNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deletePdfForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
</head>
<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<br>
<br>

<!-- 상단 제목 -->
<div class = "container text-secondary" style = "text-align:center;">
	<h1 class = "text-secondary">PHOTO DELETE</h1>
</div>
<br>			
<div class = "container">
	<!-- 이미지 삭제 -->
	<form method = "post" action = "<%= request.getContextPath() %>/pdf/deletePdfAction.jsp">
		<table class = "table table-active">
			<tr>
				<td class = "text-secondary">PDF 번호</td>
				<td class = "bg-light"><input type = "text" name = "pdfNo" value = "<%= pdf.getPdfNo() %>"class="form-control" readonly></td>
			</tr>
			<tr>
				<td class = "text-secondary">비밀번호</td>
				<td class = "bg-light"><input type = "password" name = "pdfPw" class="form-control"></td>
			</tr>
		</table>
		<button type = "submit" class = "btn btn-outline-secondary">삭제</button>
		<a href="<%= request.getContextPath() %>/pdf/pdfList.jsp" class = "btn btn-outline-secondary float-right">이전 페이지</a>
	</form>
</div>
</body>
</html>