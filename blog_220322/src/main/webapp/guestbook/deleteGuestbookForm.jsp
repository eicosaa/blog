<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	GuestbookDao guestbookDao = new GuestbookDao();
	Guestbook guestbook = guestbookDao.selectGuestbookOne(guestbookNo);
	
	// 디버깅
    System.out.println("[deleteGuestbookForm.jsp] guestbookNo : " + guestbook.getGuestbookNo());
    System.out.println("[deleteGuestbookForm.jsp] guestbookPw : " + guestbook.getGuestbookPw());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
	<title>deleteGuestbookForm</title>
</head>
<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<br>
<br>
<!-- 상단 제목 -->
<div class = "container text-secondary" style = "text-align:center;">
	<h1 class = "text-secondary">GUESTBOOK DELETE</h1>
</div>
<br>
			
<div class = "container">
	<!-- 방명록 삭제 -->
	<form method = "post" action = "<%= request.getContextPath() %>/guestbook/deleteGuestbookAction.jsp">
		<table class = "table">
			<tr>
				<td class = "table-active text-secondary">글 번호</td>
				<td class = "bg-light"><input type = "text" name = "guestbookNo" value = "<%= guestbook.getGuestbookNo() %>"class="form-control" readonly></td>
			</tr>
			<tr>
				<td class = "table-active text-secondary">비밀번호</td>
				<td class = "bg-light"><input type = "password" name = "guestbookPw" class="form-control"></td>
			</tr>
		</table>
		<button type = "submit" class = "btn btn-outline-secondary">삭제</button>
		<a href="<%= request.getContextPath() %>/guestbook/guestbookList.jsp" class = "btn btn-outline-secondary float-right">이전 페이지</a>
	</form>
</div>
</body>
</html>