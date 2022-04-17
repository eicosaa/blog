<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	System.out.println("[updateGuestbookForm.jsp] guestbookNo : " + guestbookNo);
	
	GuestbookDao guestbookDao = new GuestbookDao();
	Guestbook guestbook = guestbookDao.selectGuestbookOne(guestbookNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
	<title>updateGuestbookForm</title>
</head>
<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<br>
<br>
<!-- 상단 제목 -->
<div class = "container text-secondary" style = "text-align:center;">
	<h1 class = "text-secondary">GUESTBOOK UPDATE</h1>
</div>
<br>			
<div class = "container">
	<!-- 방명록 수정 -->
	<form method = "post" action = "<%= request.getContextPath() %>/guestbook/updateGuestbookAction.jsp">
		<table class = "table">
			<tr>
				<td class = "table-active text-secondary">글 번호</td>
				<td class = "bg-light"><input type = "text" name = "guestbookNo" value = "<%= guestbook.getGuestbookNo() %>" class="form-control" readonly></td>
			</tr>
			<tr>
				<td class = "table-active text-secondary">내용</td>
				<td class = "bg-light">
					<textarea name="guestbookContent" rows="10" cols="80" class="form-control"><%= guestbook.getGuestbookContent() %></textarea>
				</td>
			</tr>
			<tr>
				<td class = "table-active text-secondary">비밀번호</td>
				<td class = "bg-light"><input type = "password" name = "guestbookPw" class="form-control"></td>
			</tr>
		</table>
		<button type = "submit" class = "btn btn-outline-secondary">수정</button>
		<a href="<%= request.getContextPath() %>/guestbook/guestbookList.jsp" class = "btn btn-outline-secondary float-right">이전 페이지</a>
	</form>
</div>
</body>
</html>