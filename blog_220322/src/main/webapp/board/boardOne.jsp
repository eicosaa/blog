<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%
	//----------------------------------------------전 페이지에서 넘어온 값 변수에 저장
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName");	
	System.out.println("[boardOne.jsp] boardNo : " + boardNo);
	System.out.println("[boardOne.jsp] categoryName : " + categoryName);
	
	// -boardOne.jsp에 필요한 dao 생성
	BoardDao boardDao = new BoardDao();
	CategoryDao categoryDao = new CategoryDao();
	
	// -카테고리 목록 메서드 객체 생성
	ArrayList<HashMap<String,Object>> categoryList = categoryDao.CategoryList();
	
	// -selectBoardOne 메서드 객체 생성
	Board board = boardDao.selectBoardOne(boardNo);
	
	// -request.getContextPath() : 프로젝트 명이 바뀔 수 있기 때문에 사용 
	//	(프로젝트 명이 바뀌면 a href를 수정해야 하기 때문에 번거롭지 않기 위해 사용)
	// -request.getContextPath()는 프로젝트 명을 갖고 옴 (/blog라는 글이 들어갈거임)
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardOne</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">

	<jsp:include page="/inc/upMenu.jsp"></jsp:include>

	<br>
	<div class = "row">
		<!-- 좌측 메뉴, category별 게시글 링크 메뉴 -->
		<div class = "col-sm-2 bg-warning">
			<br>
			<ul class="list-group">
				<li class="list-group-item">= CATEGORY =</li>
				<%
					for(HashMap<String, Object> m : categoryList) {
				%>
						<li class = "list-group-item">
							<a href="<%= request.getContextPath() %>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>" ><%=m.get("categoryName")%> <span class = "badge bg-warning"><%=m.get("cnt")%></span> </a>
						</li>
				<%		
					}
				%>
			</ul> 
			<br>				
		</div>
			
	<!-- 메인 -->
	<div class = "col-sm-8 bg-light">
		<div class="container p-3 my-3 bg-dark text-white">
		<h1>board 게시글</h1>
	</div>
	<!-- 게시글 리스트 -->
	<table class = "table table-info">
		<tr>
			<td>boardNo</td>
			<td class="table-warning"><%= board.getBoardNo() %></td>
		</tr>
		<tr>
			<td>categoryName</td>
			<td class="table-warning"><%= board.getCategoryName() %></td>
		</tr>
		<tr>
			<td>boardTitle</td>
			<td class="table-warning"><%= board.getBoardTitle() %></td>
		</tr>
		<tr>
			<td>boardContent</td>
			<td class="table-warning"><%= board.getBoardContent() %></td>
		</tr>
		<tr>
			<td>createDate</td>
			<td class="table-warning"><%= board.getCreateDate() %></td>
		</tr>
		<tr>
			<td>updateDate</td>
			<td class="table-warning"><%= board.getUpdateDate() %></td>
		</tr>
	</table>
		<div>
			<a href="<%= request.getContextPath() %>/board/updateBoardForm.jsp?boardNo=<%= board.getBoardNo() %>" class = "btn btn-outline-info">수정</a>
			<a href="<%= request.getContextPath() %>/board/deleteBoardForm.jsp?boardNo=<%= board.getBoardNo() %>" class = "btn btn-outline-info">삭제</a>
			<a href="<%= request.getContextPath() %>/board/boardList.jsp" class = "btn btn-outline-info">이전 페이지</a>
		</div>
	</div>
</div>
</body>
</html>