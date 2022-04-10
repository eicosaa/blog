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
	public int updateBoard(Board board) throws Exception {
		Board b = new Board();
		int row = 0;
		
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[BoardDao.updateBoard] conn : " + conn + " / 드라이버 로딩 성공");
		PreparedStatement stmt = null;
		
		String sql = "UPDATE board SET category_name = ?, board_title = ?, board_content = ?, update_Date = NOW() WHERE board_no = ? AND board_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, b.getCategoryName());
		stmt.setString(2, b.getBoardTitle());
		stmt.setString(3, b.getBoardContent());
		stmt.setInt(4, b.getBoardNo()); 
		stmt.setString(5, b.getBoardPw());
		System.out.println("[Dao.updateBoard] sql : " + stmt);
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
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
		
		String sql = "SELECT board_no boardNo, category_name categoryName, board_content boardContent, board_title boardTitle, create_date createDate, update_date updateDate FROM board where board_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		System.out.println("[Dao.selectBoardOne] sql : " + stmt);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			board = new Board(); // 생성자메서드
			board.setBoardNo(rs.getInt("photoNo"));
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
	public ArrayList<Board> selectBoardListByPage(int beginRow, int rowPerPage) throws Exception {
		Board b = new Board();
		ArrayList<Board> list = new ArrayList<Board>();

		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[BoardDao.selectBoardListByPage] conn : " + conn + " / 드라이버 로딩 성공");
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "SELECT create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		// 데이터베이스 로직 끝
		
		// 데이터 변환(가공)
		while(rs.next()) {
			b.setBoardNo(rs.getInt("boardNo"));
			b.setCreateDate(rs.getString("createDate"));
			list.add(b);
		}
		
		// 데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
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
