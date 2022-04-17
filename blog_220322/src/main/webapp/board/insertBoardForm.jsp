<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "dao.CategoryDao"%>
<%@ page import = "java.util.ArrayList"%>
<%@ page import = "java.util.HashMap"%>
<%
	// -insertBoardForm.jsp에 필요한 dao 생성
	CategoryDao categoryDao = new CategoryDao();
	
	// -카테고리 목록 메서드 객체 생성
	ArrayList<HashMap<String,Object>> list = categoryDao.CategoryList();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>insertBoardForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
</style>
</head>
<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<br>
<br>
<!-- 상단 제목 -->
<div class = "container text-secondary" style = "text-align:center;">
	<h1 class = "text-secondary">글 입력</h1>
</div>
<br>
<!-- 메인 -->
<div class = "container">
	<form method="post" action="<%= request.getContextPath() %>/board/insertBoardAction.jsp">
		<table class = "table table-active">
			<tr>
				<td class = "text-secondary">categoryName</td>
				<td class = "bg-light">
					<select name="categoryName" class = "form-control">
						<%
							for(HashMap<String, Object> m : list) {
						%>
								<option value = "<%= m.get("categoryName") %>"><%= m.get("categoryName") %></option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td class = "text-secondary">boardTitle</td>
				<td class = "bg-light">
					<input name="boardTitle" type="text" class="form-control">
				</td>
			</tr>
			<tr>
				<td class = "text-secondary">boardContent</td>
				<td class = "bg-light">
					<textarea name="boardContent" rows="13" cols="100" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<td class = "text-secondary">boardPw</td>
				<td class = "bg-light">
					<input name="boardPw" type="password" class="form-control">
				</td>
			</tr>
		</table>
		
		<div>
					<button type="submit" class="btn btn-outline-secondary">입력</button>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp" class = "btn btn-outline-secondary float-right">이전 페이지</a>
		</div>
	</form>
</div>
</body>
</html>