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
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
</head>
<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<br>
<br>

<!-- 상단 제목 -->
<div class = "container text-secondary" style = "text-align:center;">
	<h1 class = "text-secondary">게시글 보기</h1>
	<p>title : <%= board.getBoardTitle() %></p>
</div>
			
<div class = "container">
<div class="row">
	<!-- 좌측 -->
	<div class="col-sm-2">
		<!-- category별 게시글 링크 메뉴 -->
		<div style = "text-align:center;">
			<ul class="list-group">
			<li class="list-group-item bg-secondary text-light"><b>CATEGORY</b></li>
			<%
				for(HashMap<String, Object> m : categoryList) {
			%>
					<li class = "list-group-item bg-light">
						<a href = "<%= request.getContextPath() %>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>" class = "text-secondary"><%= m.get("categoryName")%>
						<span class = "badge bg-warning"><%= m.get("cnt")%></span> 
						</a>
					</li>
			<%		
				}
			%>
			</ul> 
		</div>
	</div>	
			
	<!-- 메인 -->
	<!-- 게시글 리스트 -->
	<div class = "col-sm-10">
	<table class = "table table-active">
		<tr>
			<td class = "text-secondary">boardNo</td>
			<td class = "bg-light"><%= board.getBoardNo() %></td>
		</tr>
		<tr>
			<td class = "text-secondary">categoryName</td>
			<td class = "bg-light"><%= board.getCategoryName() %></td>
		</tr>
		<tr>
			<td class = "text-secondary">boardTitle</td>
			<td class = "bg-light"><%= board.getBoardTitle() %></td>
		</tr>
		<tr>
			<td class = "text-secondary">boardContent</td>
			<td class = "bg-light"><%= board.getBoardContent() %></td>
		</tr>
		<tr>
			<td class = "text-secondary">createDate</td>
			<td class = "bg-light"><%= board.getCreateDate() %></td>
		</tr>
		<tr>
			<td class = "text-secondary">updateDate</td>
			<td class = "bg-light"><%= board.getUpdateDate() %></td>
		</tr>
	</table>
		<div>
			<a href="<%= request.getContextPath() %>/board/updateBoardForm.jsp?boardNo=<%= board.getBoardNo() %>" class = "btn btn-outline-secondary">수정</a>
			<a href="<%= request.getContextPath() %>/board/deleteBoardForm.jsp?boardNo=<%= board.getBoardNo() %>" class = "btn btn-outline-secondary">삭제</a>
			<a href="<%= request.getContextPath() %>/board/boardList.jsp" class = "btn btn-outline-secondary float-right">이전 페이지</a>
		</div>
	</div>
</div>
</div>
</body>
</html>