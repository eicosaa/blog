package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DBUtil;
import vo.Board;
import vo.Photo;

public class BoardDao {
	public BoardDao() { } // -생성자 메소드

	// 입력
	public void insertBoard(Board board) {
		
		// -mariadb 드라이버 로딩 + mariadb RDBMS 접속 + 자원 준비
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[BoardDao.insertBoard] conn : " + conn + " / 드라이버 로딩 성공");
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO board(category_name, board_title,	board_content, board_pw, create_date, update_date) VALUES (?, ?, ?, ?, NOW(), NOW())";
	
		try {
			 stmt = conn.prepareStatement(sql);
			 stmt.setString(1, board.getCategoryName());
			 stmt.setString(2, board.getBoardTitle());
			 stmt.setString(3, board.getBoardContent());
			 stmt.setString(4, board.getBoardPw());
			 
			 System.out.println("stmt : " + stmt);
			 
			 // -수행결과 int 타입의 값 반환하는 executeUpdate를 사용하여 몇 행을 입력했는지 return
			 int row = stmt.executeUpdate();
			 // 디버깅
			 if(row == 1) {
			 	 System.out.println("[insertBoard] " + row + "행 입력 성공");
			 } else {
				 System.out.println("[insertBoard] 입력 실패");
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				stmt.close();
				conn.close(); // -Connection 객체는 사용이 끝나면 반납	
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// 수정
	public int updateBoard(Board board) {
		int row = 0;
		
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[BoardDao.updateBoard] conn : " + conn + " / 드라이버 로딩 성공");
		PreparedStatement stmt = null;
		
		String sql = "UPDATE board SET category_name = ?, board_title = ?, board_content = ?, update_Date = NOW() WHERE board_no = ? AND board_pw = ?";

		try {
			 stmt = conn.prepareStatement(sql);
			 stmt.setString(1, board.getCategoryName());
			 stmt.setString(2, board.getBoardTitle());
			 stmt.setString(3, board.getBoardContent());
			 stmt.setInt(4, board.getBoardNo()); 
			 stmt.setString(5, board.getBoardPw());
			
			 System.out.println("[Dao.updateBoard] stmt : " + stmt);
			 
			 // -수행결과 int 타입의 값 반환하는 executeUpdate를 사용하여 몇 행을 입력했는지 return
			 row = stmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				stmt.close();
				conn.close(); // -Connection 객체는 사용이 끝나면 반납	
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return row;
	}
	
	// 삭제
	public int deleteBoard(int boardNo, String boardPw) throws Exception {
		
		int row = 0;
		
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[BoardDao.deleteBoard] conn : " + conn + " / 드라이버 로딩 성공");
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM board WHERE board_no = ? AND board_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		stmt.setString(2, boardPw);
		
		System.out.println("[Dao.deleteBoard] sql : " + stmt);
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// 상세보기
	public Board selectBoardOne(int boardNo) throws Exception {
		
		Board board = null;
		
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[BoardDao.selectBoardOne] conn : " + conn + " / 드라이버 로딩 성공");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// -쿼리 저장
		String sql = "SELECT board_no boardNo, category_name categoryName, board_content boardContent, board_title boardTitle, create_date createDate, update_date updateDate FROM board where board_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo); // -사용자가 선택해서 넘어온 ?값
		System.out.println("[Dao.selectBoardOne] sql : " + stmt);
		
		// -쿼리를 실행 후 결과값(테이블 모양의 ResultSet타입)을 리턴
		// -한 행의 데이터값을 가져오기에 ArrayList 대신 Board board 사용
		rs = stmt.executeQuery();
		if(rs.next()) { // -next()메소드 : 문자 혹은 문자열을 공백 기준으로 한 단어 또는 한 문자씩 입력받음, 다음 줄로 커서를 이동해서 읽을 값들이 존재하면 true, 존재하지 않으면 false 
			board = new Board(); // 생성자메서드
			board.setBoardNo(rs.getInt("boardNo"));
			board.setBoardTitle(rs.getString("boardTitle"));
			board.setCategoryName(rs.getString("categoryName"));
			board.setBoardContent(rs.getString("boardContent"));
			board.setCreateDate(rs.getString("createDate"));
			board.setUpdateDate(rs.getString("updateDate"));

		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return board;
	}
	
	// 목록 (n행씩 반환)
	public ArrayList<Board> selectBoardListByPage(int beginRow, int rowPerPage, String categoryName) throws Exception {
		ArrayList<Board> boardList = new ArrayList<Board>();

		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[BoardDao.selectBoardListByPage] conn : " + conn + " / 드라이버 로딩 성공");
		PreparedStatement boardStmt = null;

		String boardSql = null;
		if(categoryName.equals("")) {
			boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
			boardStmt = conn.prepareStatement(boardSql);
			boardStmt.setInt(1, beginRow);
			boardStmt.setInt(2, rowPerPage);
		} else {
			boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name = ? ORDER BY create_date DESC LIMIT ?, ?";
			boardStmt = conn.prepareStatement(boardSql);
			boardStmt.setString(1, categoryName);
			boardStmt.setInt(2, beginRow);
			boardStmt.setInt(3, rowPerPage);
		}
		ResultSet boardRs = boardStmt.executeQuery();
		// 데이터베이스 로직 끝
		
		// 데이터 변환(가공)
		while(boardRs.next()) {
			Board b = new Board();
			b.setBoardNo(boardRs.getInt("boardNo"));
			b.setCategoryName(boardRs.getString("categoryName"));
			b.setBoardTitle(boardRs.getString("boardTitle"));
			b.setCreateDate(boardRs.getString("createDate"));
			boardList.add(b);
		}
		
		// 데이터베이스 자원들 반환
		boardRs.close();
		boardStmt.close();
		conn.close();
		
		return boardList;
	}
	
	// 전체 행의 수
	public int selectBoardTotalRow() throws Exception {
		Board b = new Board();
		int row = 0;
		
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[BoardDao.selectBoardTotalRow] conn : " + conn + " / 드라이버 로딩 성공");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT COUNT(*) cnt FROM board";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		return row;
	}
	
}
