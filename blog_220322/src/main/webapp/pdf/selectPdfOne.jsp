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
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">
	
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>

	<div class="container p-3 my-3 bg-secondary text-white">
	<h1>selectPdfOne</h1>
	</div>
	
	<div>
	<table class = "table table-info">
		<tr>
			<td>pdfNo</td>
			<td class="table-warning"><%= pdf.getPdfNo() %></td>
		</tr>
		<tr>
			<td>pdf</td>
			<td class="table-warning"><a href="<%=request.getContextPath()%>/uploadPdf/<%= pdf.getPdfOriginalName() %>"><%= pdf.getPdfOriginalName() %></a></td>
		</tr>
		<tr>
			<td>writer</td>
			<td class="table-warning"><%= pdf.getWriter() %></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td class="table-warning"><%= pdf.getCreateDate() %></td>
		</tr>
	</table>
	</div>
		<div>
			<a href="<%= request.getContextPath() %>/pdf/deletePdfForm.jsp?pdfNo=<%= pdf.getPdfNo() %>" class = "btn btn-outline-info">삭제</a>
			<a href="<%= request.getContextPath() %>/pdf/pdfList.jsp" class = "btn btn-outline-info">이전 페이지</a>
		</div>

</div>		
</body>
</html>