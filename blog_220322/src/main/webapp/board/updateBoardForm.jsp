<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*"%>
<%@ page import = "java.util.*" %>
<%
	// -요청값
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	
	// -updateBoardForm.jsp에 필요한 dao 생성
	BoardDao boardDao = new BoardDao();
	CategoryDao categoryDao = new CategoryDao();
	
	// -카테고리 목록 메서드 객체 생성
	ArrayList<HashMap<String,Object>> categoryList = categoryDao.CategoryList();
	
	// -수정 할 글의 카테고리를 가져올 메서드 객체 생성
	Board board = boardDao.selectBoardOne(boardNo);
	
	// -디버깅 코드
	System.out.println("[updateBoardForm.jsp] categoryName : " + board.getCategoryName());
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>updateBoardForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
</head>
<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<br>
<br>

<!-- 상단 제목 -->
<div class = "container text-secondary" style = "text-align:center;">
	<h1 class = "text-secondary">게시글 수정</h1>
	<p>title : <%= board.getBoardTitle() %></p>
</div>

<!-- 메인 -->
<div class = "container">
	<form method="post" action="<%= request.getContextPath() %>/board/updateBoardAction.jsp">
		<table class = "table table-active">
			<tr>
				<td class = "text-secondary">boardNo</td>
				<td class = "bg-light"><input type="text" name="boardNo" value="<%= board.getBoardNo() %>" readonly="readonly" class="form-control"></td>
			</tr>
			<tr>
				<td class = "text-secondary">categoryName</td>
				<td class = "bg-light">
					<select name="categoryName" class = "form-control">
						<%
							for(HashMap<String,Object> s : categoryList) {
								if(s.get("categoryName").equals(board.getCategoryName())) { // 수정 시 글의 카테고리
						%>
									<option selected="selected" value="<%= s.get("categoryName") %>"><%= s.get("categoryName") %></option>
						<%
								} else {
						%>
									<option value="<%= s.get("categoryName") %>"><%= s.get("categoryName") %></option>
						<%		
								}
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td class = "text-secondary">boardTitle</td>
				<td class = "bg-light"><input type="text" name="boardTitle" value="<%= board.getBoardTitle() %>" class="form-control"></td>
			</tr>
			<tr>
				<td class = "text-secondary">boardContent</td>
				<td class = "bg-light">
					<textarea rows="5" cols="50" name="boardContent" class="form-control"><%= board.getBoardContent() %></textarea>
				</td>
			<tr>	
				<td class = "text-secondary">boardPw</td>
				<td class = "bg-light"><input type="password" name="boardPw" value="" class="form-control"></td>
			</tr>
		</table>
		
		<button type="submit" class = "btn btn-outline-secondary">수정</button>
		<a href="<%= request.getContextPath() %>/board//boardList.jsp" class = "btn btn-outline-secondary float-right">이전 페이지</a>
	</form>
</div>
</body>
</html>