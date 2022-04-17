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
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</style>
</head>
<body>
<div class = "container">

	<jsp:include page="/inc/upMenu.jsp"></jsp:include>

	<div class="container p-3 my-3 bg-dark text-white">
	<h1>글 입력</h1>
	</div>
	<form method="post" action="<%= request.getContextPath() %>/board/insertBoardAction.jsp">
		<table class = "table table-primary">
			<tr>
				<td>categoryName</td>
				<td>
					<select name="categoryName" class = "form-select">
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
				<td>boardTitle</td>
				<td>
					<input name="boardTitle" type="text" class="form-control">
				</td>
			</tr>
			<tr>
				<td>boardContent</td>
				<td>
					<textarea name="boardContent" rows="5" cols="80" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<td>boardPw</td>
				<td>
					<input name="boardPw" type="password" class="form-control">
				</td>
			</tr>
		</table>
		<div>
					<button type="submit" class="btn btn-outline-info">입력</button>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp" class = "btn btn-outline-info">이전 페이지</a>
		</div>
	</form>
</div>
</body>
</html>