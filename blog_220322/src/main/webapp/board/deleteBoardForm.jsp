<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//-----------------------------------boardOne 페이지에서 보낸 파라미터 값 변수에 저장
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
%>   
 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>deleteBoardForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
</head>
<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<br>
<br>

<!-- 상단 제목 -->
<div class = "container text-secondary" style = "text-align:center;">
	<h1 class = "text-secondary">글 삭제</h1>
</div>
<br>

<!-- 메인 -->
<div class = "container">
	<form method="post" action="<%= request.getContextPath() %>/board/deleteBoardAction.jsp">
		<table class = "table table-active">
			<tr>
				<td class = "text-secondary"> 글 번호 </td>
				<td class = "bg-light"> <input type="text" name="boardNo" value="<%=boardNo%>" readonly="readonly" class="form-control"> </td>
			</tr>
			<tr>
				<td class = "text-secondary"> 비밀번호 </td>
				<td class = "bg-light"> <input type="password" name="boardPw" class="form-control"> </td>
			</tr>
		</table>
		<div>
			<button type="submit" class="btn btn-outline-secondary">삭제</button>
			<a href="<%=request.getContextPath()%>/board/boardList.jsp" class = "btn btn-outline-secondary float-right">이전 페이지</a>
		</div>
	</form>
</div>
</body>
</html>