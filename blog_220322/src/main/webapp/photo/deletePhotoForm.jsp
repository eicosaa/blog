<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.PhotoDao" %>
<%@ page import = "vo.Photo" %>
<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	PhotoDao photoDao = new PhotoDao();
	Photo photo = photoDao.selectPhotoOne(photoNo);
	
	// 디버깅
    System.out.println("[deletePhotoForm.jsp] photoNo : " + photo.getPhotoNo());
    System.out.println("[deletePhotoForm.jsp] photoPw : " + photo.getPhotoPw());
    System.out.println("[deletePhotoForm.jsp] photoName : " + photo.getPhotoName());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deletePhotoForm</title>
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
	<p>title : <%= photo.getPhotoName() %></p>
</div>
			
<div class = "container">
	<!-- 이미지 삭제 -->
	<form method = "post" action = "<%= request.getContextPath() %>/photo/deletePhotoAction.jsp">
		<table class = "table table-active">
			<tr>
				<td class = "text-secondary">이미지 번호</td>
				<td class = "bg-light"><input type = "text" name = "photoNo" value = "<%= photo.getPhotoNo() %>"class="form-control" readonly></td>
			</tr>
			<tr>
				<td class = "text-secondary">이미지</td>
				<td class = "bg-light"><input type = "text" name = "photoName" value = "<%= photo.getPhotoName() %>"class="form-control" readonly></td>
			</tr>
			<tr>
				<td class = "text-secondary">비밀번호</td>
				<td class = "bg-light"><input type = "password" name = "photoPw" class="form-control"></td>
			</tr>
		</table>
		<button type = "submit" class = "btn btn-outline-secondary">삭제</button>
		<a href="<%= request.getContextPath() %>/photo/photoList.jsp" class = "btn btn-outline-secondary float-right">이전 페이지</a>
	</form>
</div>
</body>
</html>