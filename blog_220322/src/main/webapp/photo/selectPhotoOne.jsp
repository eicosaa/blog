<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	System.out.println("[selectPhotoOne.jsp] photoNo : " + photoNo);
	
	PhotoDao photoDao = new PhotoDao();
	Photo photo = photoDao.selectPhotoOne(photoNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>selectPhotoOne</title>
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
	<p>title : <%= photo.getPhotoName() %></p>
</div>
			
<div class = "container">
	
	<table class = "table table-active">
		<tr>
			<td class = "text-secondary">photoNo</td>
			<td class = "bg-light"><%= photo.getPhotoNo() %></td>
		</tr>
		<tr>
			<td class = "text-secondary">photo</td>
			<td class = "bg-light"><img src="<%= request.getContextPath() %>/upload/<%= photo.getPhotoName() %>"></td>
		</tr>
		<tr>
			<td class = "text-secondary">writer</td>
			<td class = "bg-light"><%= photo.getWriter() %></td>
		</tr>
		<tr>
			<td class = "text-secondary">createDate</td>
			<td class = "bg-light"><%= photo.getCreateDate() %></td>
		</tr>
	</table>
		<div>
			<a href="<%= request.getContextPath() %>/photo/deletePhotoForm.jsp?photoNo=<%= photo.getPhotoNo() %>" class = "btn btn-outline-secondary">삭제</a>
			<a href="<%= request.getContextPath() %>/photo/photoList.jsp" class = "btn btn-outline-secondary float-right">이전 페이지</a>
		</div>

</div>		
</body>
</html>