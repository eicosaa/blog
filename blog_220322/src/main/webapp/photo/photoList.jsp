<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>    
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	int currentPage = 1; // -현재 페이지
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	PhotoDao photoDao = new PhotoDao();
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage);
	
	int lastPage = 0; // -마지막 페이지
	int totalCount = photoDao.selectPhotoTotalRow();
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>photoList</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class = "container">
	<!-- 메인 메뉴 -->
	
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	
	<!-- include 시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->
	<!-- -include는 내부 호출이기에 request.getContextPath() 사용 불가 -->
	
	<div class="container p-3 my-3 bg-secondary text-white">
	<h1>이미지 목록</h1>
	</div>
	
<div>
<table class = "table table-active">
<tr>
<%
	// 한 행의 5개의 이미지 출력 (tr 안에 td가 5개)
	// 이미지가 3개  - tr 1 - td 5
	// 이미지가 5개  - tr 1 - td 5
	// 이미지가 10개 - tr 2 - td 10
	// 이미지가 9개  - tr 2 - td 10
	
	// td의 개수 5의 배수가 되도록
	// lise.size()가 1 ~ 5 - td는 5개
	// lise.size()가 6 ~ 10 - td는 10개
	System.out.println(list.size() + " <-- list.size()");

	int endIdx = (((list.size() - 1) / 5) + 1) * 5;; // 5의 배수가 되어야 한다. (한 줄에 5개씩 출력)
	System.out.println(endIdx + " <-- 10");
	
	// for(Photo p : list) { // size()만큼 반복되므로 5의 배수가 아닐 수도 있다.
	for(int i = 0; i < endIdx; i++) { //01234, 0123456789
		// tr을 닫고 새로운 tr 시작
		if(i != 0 && i % 5 == 0) { // 5일 때(0을 제외한 5의 배수일 떼)
%>
			</tr><tr>
<%			
		}
	
		if(i < list.size()) {
%>
				<td>
					<a href = "<%= request.getContextPath() %>/photo/selectPhotoOne.jsp?photoNo=<%= list.get(i).photoNo %>">
						<img src="<%= request.getContextPath() %>/upload/<%= list.get(i).photoName %>" width = "200" height = "200">
						<!-- 상세보기에서는 원본 이미지 크기로 -->
					</a>
				</td>
<%
		} else {
%>
			<td>&nbsp;</td>
<%		
		}
	}
%>
</table>
<div>
<%

	if(currentPage > 1) {
%>
		<a href = "<%= request.getContextPath() %>/photo/photoList.jsp?currentPage=<%= currentPage - 1 %>" class = "btn btn-outline-dark">이전</a>
<%
	}

	if(currentPage < lastPage) {
%>
		<a href = "<%= request.getContextPath() %>/photo/photoList.jsp?currentPage=<%= currentPage + 1 %>" class = "btn btn-outline-dark" >다음</a>
<%
	}
%>
		<a href="<%= request.getContextPath() %>/photo/insertPhotoForm.jsp" class = "btn btn-outline-dark">이미지 등록</a>
</div>
</body>
</html>