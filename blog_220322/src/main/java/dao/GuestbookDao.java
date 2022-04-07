package dao;

import java.util.ArrayList;

import util.DBUtil;
import vo.Guestbook;
import java.sql.*;

public class GuestbookDao {
	// 생성자 메소드
	public GuestbookDao() { }
	
	// 입력
	// GuestbookDao guestbookDao = new GuestbookDao();
	// Guestbook guestbook = new Guestbook();
	// guestbookDao.insertGuestbook(); 호출
	public void insertGuestbook(Guestbook guestbook) throws Exception {
		
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[insertGuestbook] conn : " + conn + " / 드라이버 로딩 성공");
		
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO guestbook(guestbook_content, writer, guestbook_pw, create_date, update_date) VALUES(?, ?, ?, NOW(), NOW())";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, guestbook.getGuestbookContent());
		stmt.setString(2, guestbook.getWriter());
		stmt.setString(3, guestbook.getGuestbookPw());
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("입력 성공");
		} else {
			System.out.println("입력 실패");
		}
		stmt.close();
		conn.close();
	}
	// updateGuestbookForm.jsp에서 호출
	public Guestbook selectGuestbookOne(int guestbookNo) throws Exception {
		Guestbook guestbook = null;
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent FROM guestbook WHERE guestbook_no = ? ORDER BY create_date DESC";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, guestbookNo);
		System.out.println(stmt + " <-- sql selectOne");
		rs = stmt.executeQuery();
		if(rs.next()) {
			guestbook = new Guestbook(); // 생성자메서드
			guestbook.setGuestbookNo(rs.getInt("guestbookNo"));
			guestbook.setGuestbookContent(rs.getString("guestbookContent"));
		}
		rs.close();
		stmt.close();
		conn.close();
		return guestbook;
	}
	// updateGuestbookAction.jsp에서 호출
	// (메소드의) 이름 - updateGuestbook
	// 반환타입 - 수정한 행의 수 반환 -> 0수정실패, 1수정성공 -> int
	// 입력매개변수 - guestbookNo, guestbookContent, guestbookPw 3개 -> 하나의 타입매개변수로 받고 싶다 -> Guestbook 타입을 사용
	public int updateGuestbook(Guestbook guestbook) throws Exception {
		int row = 0;
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "UPDATE guestbook SET guestbook_content = ? WHERE guestbook_no = ? AND guestbook_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, guestbook.getGuestbookContent());
		stmt.setInt(2, guestbook.getGuestbookNo());
		stmt.setString(3, guestbook.getGuestbookPw());
		System.out.println(stmt + " <-- sql updateGuestbook");
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	// 삭제(deleteGuestbook) 프로세스
	// 이름 - deleteGuestbook
	// 반환값 - row 행 결과 수 -> 0, 1 -> int
	// 입력 매개값 - guestbookNo, guestbookPw 2개 -> int, String 타입을 사용 (Guestbook타입을 사용해도 된다.)
	public int deleteGuestbook(int guestbookNo, String guestbookPw) throws Exception {
		int row = 0;
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM guestbook WHERE guestbook_no = ? AND guestbook_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, guestbookNo);
		stmt.setString(2, guestbookPw);
		
		System.out.println(stmt + " <-- sql deleteGuestbook");
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return row;
	}
	
	
	// guestbook 전체 행의 수를 반환 메서드
	public int selectGuestbookTotalRow() throws Exception {
		int row = 0;
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT COUNT(*) cnt FROM guestbook";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		return row;
	}
	
	// guestbook n행씩 반환하는 메소드
	public ArrayList<Guestbook> selectGuestbookListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Guestbook> list = new ArrayList<Guestbook>();
		// guestbook 10행 반환되도록 구현
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer, create_date createDate FROM guestbook ORDER BY create_date DESC LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		// 데이터베이스 로직 끝
		
		// 데이터 변환(가공)
		while(rs.next()) {
			Guestbook g = new Guestbook();
			g.setGuestbookNo(rs.getInt("guestbookNo"));
			g.setGuestbookContent(rs.getString("guestbookContent"));
			g.setWriter(rs.getString("writer"));
			g.setCreateDate(rs.getString("createDate"));
			list.add(g);
		}
		
		// 데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
}
