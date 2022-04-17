<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.CategoryDao"%>
<%@ page import = "dao.BoardDao"%>
<%
	// -boardList.jsp에 필요한 dao 생성
	BoardDao boardDao = new BoardDao();
	CategoryDao categoryDao = new CategoryDao();
	
	// -페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10; // rowPerPage은 한 페이지에 내가 보고 싶은 글 수 (한 행에 10개씩 보고 싶다.)
	int beginRow = (currentPage - 1) * rowPerPage; // 현재 페이지가 변경되면 beginRow도 변경된다. -> 가져오는 데이터 변경된다.
	int totalRow = boardDao.selectBoardTotalRow(); // 전체 행의 개수	
	int lastPage = 0;
	if(totalRow % rowPerPage == 0) {
		lastPage = totalRow / rowPerPage;
	} else {
		lastPage = (totalRow / rowPerPage) + 1;
	}
	// -페이징 디버깅 코드
	System.out.println("[boardList.jsp] currentPage : " + currentPage);
	System.out.println("[boardList.jsp] beginRow : " + beginRow);
	System.out.println("[boardList.jsp] totalRow : " + totalRow);
	System.out.println("[boardList.jsp] lastPage : " + lastPage);
	
	// 이전, 다음 링크에서 null 값을 넘기는 것이 불가능해서 null -> 공백으로 치환해서 코드를 처리
	String categoryName = "";
	if(request.getParameter("categoryName") != null) {
		categoryName = request.getParameter("categoryName");
	}	

	// -카테고리 목록 메서드 객체 생성
	ArrayList<HashMap<String,Object>> categoryList = categoryDao.CategoryList();
	
	// -boardList 메서드 객체 생성
	ArrayList<Board> boardList = boardDao.selectBoardListByPage(beginRow, rowPerPage, categoryName);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
</head>
<style>
	footer{ position:fixed; 
	  left:0px; 
	  bottom:0px; 
	  height:30px; 
	  width:100%; 
	  background:#f3969a; 
	  color: white; }
</style>

<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<br>
<!-- 상단 제목 -->
<div class = "container text-secondary" style = "text-align:center;">
	<h1 class = "text-secondary">게시글 목록</h1>
	<p>total : <%= totalRow %></p>
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
	<div class = "col-sm-10">
		<!-- 게시글 리스트 -->
		<div>
			<table class = "table table-hover">
				<thead class = "bg-dark text-white">
					<tr>
						<th>categoryName</th>
						<th>boardTitle</th>
						<th>createDate</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(Board b : boardList) {
					%>
							<tr>
								<td><%= b.getCategoryName() %></td>
								<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%= b.getBoardNo() %>" class = "text-secondary"><b><%= b.getBoardTitle() %></b></a></td>
								<td><%= b.getCreateDate() %></td>
							</tr>
					<%		
						}
					%>
				</tbody>
			</table>
		</div>
		
		<!-- 버튼 -->		
		<div>
			<!-- 페이징 -->
			<!-- 페이지가 만약 10페이지였다면 이전을 누르면 9페이지, 다음을 누르면 11페이지 -->
			<%
				if(currentPage > 1) { // 현재 페이지가 1이면 이전 페이지가 존재해서는 안된다.
			%>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%= currentPage - 1 %>&categoryName=<%= categoryName %>" class = "btn btn-secondary">이전</a>
			<%
				}
			%>
			<!-- 
				전체 행   			마지막 페이지 ? 
				10개					1
				11,12,13 ~ 20		2
				21 ~ 30				3
				31 ~ 40				4
				
				마지막 페이지 = 전체 행 / rowPerPage
			-->
			<%
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%= currentPage + 1 %>&categoryName=<%= categoryName %>" class = "btn btn-secondary">다음</a>
			<%
				}
			%>
			
			<!-- 게시글 입력 버튼 -->
			<a href="<%= request.getContextPath() %>/board/insertBoardForm.jsp" class = "btn btn-outline-secondary float-right">게시글 입력</a>
		</div>
		<br>
	</div>
</div>
</div>
<footer> &nbsp; &nbsp; &nbsp; creators : minseo &nbsp; &nbsp; &nbsp; email : fomalhaut612@naver.com </footer>
</body>
</html>