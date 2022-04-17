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
	<title>Insert title here</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">

	<jsp:include page="/inc/upMenu.jsp"></jsp:include>

	<div class="container p-3 my-3 bg-dark text-white">
	<h1>수정</h1>
	</div>
	<form method="post" action="<%= request.getContextPath() %>/board/updateBoardAction.jsp">
		<table class = "table table-info">
			<tr>
				<td>boardNo</td>
				<td class="table-warning"><input type="text" name="boardNo" value="<%= board.getBoardNo() %>" readonly="readonly" class="form-control"></td>
			</tr>
			<tr>
				<td>categoryName</td>
				<td class="table-warning">
					<select name="categoryName" class = "form-select">
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
				<td>boardTitle</td>
				<td class="table-warning"><input type="text" name="boardTitle" value="<%= board.getBoardTitle() %>" class="form-control"></td>
			</tr>
			<tr>
				<td>boardContent</td>
				<td class="table-warning">
					<textarea rows="5" cols="50" name="boardContent" class="form-control"><%= board.getBoardContent() %></textarea>
				</td>
			<tr>	
				<td>boardPw</td>
				<td class="table-warning"><input type="password" name="boardPw" value="" class="form-control"></td>
			</tr>
		</table>
		<button type="submit" class = "btn btn-outline-warning">수정</button>
		<a href="<%= request.getContextPath() %>/board//boardList.jsp" class = "btn btn-outline-warning">이전 페이지</a>
	</form>
</div>
</body>
</html>