<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// -인코딩
	request.setCharacterEncoding("utf-8");

	//-메소드 호출
	BoardDao boardDao = new BoardDao();
	Board board = new Board();
	
	// -요청값 / updateBoardForm 페이지에서 보낸 파라미터 값 변수에 저장
	board.setBoardNo(Integer.parseInt(request.getParameter("boardNo")));
	board.setCategoryName(request.getParameter("categoryName"));
	board.setBoardTitle(request.getParameter("boardTitle"));	
	board.setBoardContent(request.getParameter("boardContent"));	
	board.setBoardPw(request.getParameter("boardPw"));
						
	// -디버깅 코드
	System.out.println("[updateBoardAction.jsp] boardNo : " + board.getBoardNo());
	System.out.println("[updateBoardAction.jsp] categoryName : " + board.getCategoryName());
	System.out.println("[updateBoardAction.jsp] boardTitle : " + board.getBoardTitle());
	System.out.println("[updateBoardAction.jsp] boardContent : " + board.getBoardContent());
	System.out.println("[updateBoardAction.jsp] boardPw : " + board.getBoardPw());
	
	// -수행결과 int 타입의 값 반환하는 executeUpdate를 사용하여 몇 행을 입력했는지 return
	int row = boardDao.updateBoard(board);
		
	// 디버깅
	if(row == 0) { // 행의 변화(쿼리의 수행 결과)가 없으면 수정 실패, form으로 돌아간다.
		System.out.println("[updateBoardAction.jsp] 수정 실패");
		response.sendRedirect(request.getContextPath() + "/board/updateBoardForm.jsp?boardNo=" + board.getBoardNo());
	} else if(row == 1) { // 행의 변화(쿼리의 수행 결과)가 있으면 수정 성공
		System.out.println("[updateBoardAction.jsp] 수정 성공");
		response.sendRedirect(request.getContextPath() + "/board/boardOne.jsp?boardNo=" + board.getBoardNo());
	} else { // 행의 변화(쿼리의 수행 결과)가 0이나 1이 아닌 수는 에러
		System.out.println("[updateBoardAction.jsp] 수정 에러");
	}
	
%>
