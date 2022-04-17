<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.ArrayList" %>

<%
	int currentPage = 1; // -현재 페이지
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 2; // -페이지 당 보여줄 글의 수
	int beginRow = (currentPage - 1) * rowPerPage; // -시작 행 / beginRow는 currentPage에 따라 달라짐
	GuestbookDao guestbookDao = new GuestbookDao();
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);
	// -메소드 호출 / selectGuestbookListByPage를 호출하면 ArrayList<Guestbook>에서 받을 수 있다.

		
	int lastPage = 0; // -마지막 페이지
	int totalCount = guestbookDao.selectGuestbookTotalRow();
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
	// 4.0 / 2/0 = 2.0 -> 2.0
	// 5.0 / 2.0 = 2.5 -> 3.0 
	// -방법1 : math 사용 / 방법2 : if 사용, 나누어 떨어지면 +1
	// -Math.ceil : 올림
	/* 
	lastPage = totalCount / rowPerPage;
	if(totalCount % rowPerPage != 0) {
		lastPage++;
	}
	*/
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>guestbookList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
</head>
<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<!-- include 시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
<!-- 메인 메뉴 끝 -->
<!-- -include는 내부 호출이기에 request.getContextPath() 사용 불가 -->
<br>
<br>

<!-- 상단 제목 -->
<div class = "container text-secondary" style = "text-align:center;">
	<h1 class = "text-secondary">GUESTBOOK</h1>
</div>
<br>
			
<div class = "container">
<%
	for(Guestbook g : list) {
%>
		<table class = "table table-bordered">
			<tr>
				<td width=40 class = "bg-secondary text-white"><%= g.getGuestbookNo() %></td>
				<td width=500 class = "text-secondary"><%= g.getWriter() %></td>
				<td><%= g.getCreateDate() %></td>
			</tr>
			<tr>
				<td colspan = "3" class = "bg-light"><%= g.getGuestbookContent() %></td>
			</tr>
		</table>
	<div>
		<a href="<%= request.getContextPath() %>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%= g.getGuestbookNo() %>" class = "btn btn-outline-secondary">수정</a>
		<a href="<%= request.getContextPath() %>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%= g.getGuestbookNo() %>" class = "btn btn-outline-secondary">삭제</a>
	</div>
	<br>
<%
	}
%>

<%
	if(currentPage > 1) {
%>
		<a href = "<%= request.getContextPath() %>/guestbook/guestbookList.jsp?currentPage=<%= currentPage - 1 %>" class = "btn btn-outline-secondary float-left">이전</a>
<%
	}

	if(currentPage < lastPage) {
%>
		<a href = "<%= request.getContextPath() %>/guestbook/guestbookList.jsp?currentPage=<%= currentPage + 1 %>" class = "btn btn-outline-secondary float-right" >다음</a>
<%
	}
%>
</div>
<br>	
<div class = "container text-secondary" style = "text-align:center;">
	<hr width="100%" color="#f3969a" noshade/>
	<h1 class = "text-secondary">GUESTBOOK INSERT</h1>
<br>

	<!-- 방명록 입력 -->
	<form method = "post" action = "<%= request.getContextPath() %>/guestbook/insertGuestbookAction.jsp">
		<table class = "table table-active">
			<tr>
				<td class = "text-secondary">글쓴이</td>
				<td><input type = "text" name = "writer" class="form-control"></td>
				<td class = "text-secondary">비밀번호</td>
				<td><input type = "password" name = "guestbookPw" class="form-control"></td>
			</tr>
			<tr>
				<td colspan = "4"><textarea name = "guestbookContent" rows = "2" cols = "60" class="form-control"></textarea></td>
			</tr>
		</table>
		<button type = "submit" class = "btn btn-outline-secondary float-right">입력</button>
	</form>
</div>
</body>
</html>