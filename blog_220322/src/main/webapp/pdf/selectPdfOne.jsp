<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
	System.out.println("[selectPdfOne.jsp] pdfNo : " + pdfNo);
	
	PdfDao pdfDao = new PdfDao();
	Pdf pdf = pdfDao.selectPdfOne(pdfNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>selectPdfOne</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
</head>
<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<br>
<br>

<!-- 상단 제목 -->
<div class = "container text-secondary" style = "text-align:center;">
	<h1 class = "text-secondary">PHOTO ONE</h1>
	<p>title : <%= pdf.getPdfOriginalName() %></p>
</div>
			
<div class = "container">
	
	<div>
	<table class = "table table-active">
		<tr>
			<td class = "text-secondary">pdfNo</td>
			<td class = "bg-light"><%= pdf.getPdfNo() %></td>
		</tr>
		<tr>
			<td class = "text-secondary">pdf</td>
			<td class = "bg-light"><a href="<%=request.getContextPath()%>/uploadPdf/<%= pdf.getPdfOriginalName() %>"><%= pdf.getPdfOriginalName() %></a></td>
		</tr>
		<tr>
			<td class = "text-secondary">writer</td>
			<td class = "bg-light"><%= pdf.getWriter() %></td>
		</tr>
		<tr>
			<td class = "text-secondary">createDate</td>
			<td class = "bg-light"><%= pdf.getCreateDate() %></td>
		</tr>
	</table>
	</div>
		<div>
			<a href="<%= request.getContextPath() %>/pdf/deletePdfForm.jsp?pdfNo=<%= pdf.getPdfNo() %>" class = "btn btn-outline-secondary">삭제</a>
			<a href="<%= request.getContextPath() %>/pdf/pdfList.jsp" class = "btn btn-outline-secondary float-right">이전 페이지</a>
		</div>

</div>		
</body>
</html>