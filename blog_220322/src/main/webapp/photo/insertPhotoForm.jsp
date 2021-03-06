<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>insertPhotoForm</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.6.0/dist/minty/bootstrap.css">
</head>
<body>
<!-- 메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<!-- include 시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
<!-- -include는 내부 호출이기에 request.getContextPath() 사용 불가 -->
<br>
<br>
<!-- 메인 메뉴 끝 -->

<!-- 상단 제목 -->
<div class = "container text-secondary" style = "text-align:center;">
	<h1 class = "text-secondary">PHOTO INSERT</h1>
</div>
<br>
<div class = "container">
	<div>
		<!-- 
			1) form태그 안에 값을 넘기는 기본값은 문자열이다. 
			2) 파일을 넘길 수 없다. 기본값(application/x-www-form-urlencoded)을 변경해야 한다.
			3) 기본값 "multipart/form-data"로 변경하면 기본값이 문자열에서 바이너리(이진수)로 변경된다.
			4) 같은 폼 안에 모든 값이 바이너리로 넘어간다. 글자를 넘겨받는 request.getParameter()를 사용할 수 없다.
			5) 복잡한 코드를 통해서만 바이너리 내용을 넘겨 받을 수 있다.
			6) 외부 라이브러리(cos.jar)를 사용해서 복잡한 코드를 간단하게 구현하자.
		-->
		<form action="<%= request.getContextPath() %>/photo/insertPhotoAction.jsp" method="post" enctype="multipart/form-data">
			<table class = "table table-active">
				<tr>
					<td class = "text-secondary">이미지 파일</td>
					<td class = "bg-light"><input type = "file" name = "photo" class = "custom-file"></td>
				</tr>
				<tr>
					<td class = "text-secondary">비밀번호</td>
					<td class = "bg-light"><input type = "password" name = "photoPw" class = "form-control"></td>
				</tr>
				<tr>
					<td class = "text-secondary">글쓴이</td>
					<td class = "bg-light"><input type = "text" name = "writer" class = "form-control"></td>
				</tr>
			</table>
			<button type = "submit" class = "btn btn-outline-secondary">이미지 등록</button>
			<a href="<%= request.getContextPath() %>/photo/photoList.jsp" class = "btn btn-outline-secondary float-right">이전 페이지</a>
		</form>
	</div>
</div>
</body>
</html>