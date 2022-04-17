<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 다른 페이지의 한 부분으로 사용되는 페이지 -->

<nav class="navbar navbar-expand-lg navbar-dark bg-dark" >
<div class="container-fluid">
	<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">
    <img src="<%=request.getContextPath()%>/inc/Logo.png" alt="Logo" style="width:27px;">
	</a>
  <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">B L O G</a>
  <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navb">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navb">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link active" href="<%=request.getContextPath()%>/index.jsp">Home</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/board/boardList.jsp">Board</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">Guestbook</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/photo/photoList.jsp">Photo</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/pdf/pdfList.jsp">Pdf</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/inc/about.jsp">About</a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search">
      <button class="btn btn-outline-light my-2 my-sm-0" type="button">Search</button>
    </form>
  </div>
</div>
</nav>