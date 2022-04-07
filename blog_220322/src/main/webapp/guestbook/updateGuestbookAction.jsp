<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");	

	// 요청값
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookContent = request.getParameter("guestbookContent");
	String guestbookPw = request.getParameter("guestbookPw");	
	
	// -받은 요청값 하나로 묶기
	Guestbook guestbook = new Guestbook();
	guestbook.setGuestbookNo(guestbookNo);
	guestbook.setGuestbookPw(guestbookPw);
	guestbook.setGuestbookContent(guestbookContent);
	
	// -메소드 호출
	GuestbookDao guestbookDao = new GuestbookDao();
	guestbookDao.updateGuestbook(guestbook);
		
	// -디버깅 코드
	System.out.println("[updateGuestbookAction.jsp] guestbookContent : " + guestbookContent);
	System.out.println("[updateGuestbookAction.jsp] guestbookNo : " + guestbookNo);
	System.out.println("[updateGuestbookAction.jsp] guestbookPw : " + guestbookPw);

	// -페이지 이동
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
%>