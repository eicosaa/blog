<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");	
	
	// 요청값 받아오기
	String writer = request.getParameter("writer");
	String guestbookPw = request.getParameter("guestbookPw");
	String guestbookContent = request.getParameter("guestbookContent");
	
	// -받은 요청값 하나로 묶기(메소드 호출을 위해)
	Guestbook guestbook = new Guestbook();
	guestbook.setWriter(writer);
	guestbook.setGuestbookPw(guestbookPw);
	guestbook.setGuestbookContent(guestbookContent);	
	
	// -메소드 호출
	GuestbookDao guestbookDao = new GuestbookDao();
	guestbookDao.insertGuestbook(guestbook);
		
	// -디버깅 코드
	System.out.println("[insertGuestbookAction.jsp] guestbookContent : " + guestbookContent);
	System.out.println("[insertGuestbookAction.jsp] writer : " + writer);
	System.out.println("[insertGuestbookAction.jsp] guestbookPw : " + guestbookPw);

	// -페이지 이동 (입력 실패하거나 성공 후 guestbookList.jsp로 이동)
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
%>