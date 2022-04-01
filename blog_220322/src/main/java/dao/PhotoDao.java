package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.Guestbook;
import vo.Photo;

public class PhotoDao {
	
	// 이미지 이름을 반환하는 메서드
	public String selectPhotoName(int photoNo) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		String sql = "SELECT photo_name FROM photo WHERE photo_no = ?";
		String photoName = "";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[insertPhoto] conn : " + conn + " / 드라이버 로딩 성공");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, photoName);

		return photoName;
	}
	
	// 이미지 입력
	public void insertPhoto(Photo photo) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		String sql = "INSERT INTO photo(photo_name, photo_original_name, photo_type, photo_pw, writer, create_date, update_date) VALUES(?, ?, ?, ?, ?, NOW(), NOW())";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[insertPhoto] conn : " + conn + " / 드라이버 로딩 성공");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, photo.photoName);
		stmt.setString(2, photo.photoOriginalName);
		stmt.setString(3, photo.photoType);
		stmt.setString(4, photo.photoPw);
		stmt.setString(5, photo.writer);
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("[insertPhoto] 입력 성공");
		} else {
			System.out.println("[insertPhoto] 입력 실패");
		}
		stmt.close();
		conn.close();
	}
	
	// 이미지 삭제
	public int deletePhoto(int photoNo, String photoPw) throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[deletePhoto] conn : " + conn + " / 드라이버 로딩 성공");
		
		String sql = "DELETE FROM photo WHERE photo_no = ? AND photo_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		stmt.setString(2, photoPw);
		
		System.out.println("[Dao.deletephoto] sql : " + stmt);
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return row;
	}
	
	// 이미지 목록 (n행씩 반환)
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo>();
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mariadb://localhost:3307/blog","root","java1234");
		String sql = "SELECT photo_no photoNo, photo_name photoName FROM photo ORDER BY create_date DESC LIMIT ?,?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Photo p = new Photo();
			p.photoNo = rs.getInt("photoNo");
			p.photoName = rs.getString("photoName");
			list.add(p);
		}
		return list;
	}
	
	// 이미지 하나 상세보기
	public Photo selectPhotoOne(int photoNo) throws Exception {
		Photo photo = null;
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[selectPhotoOne] conn : " + conn + " / 드라이버 로딩 성공");
		
		String sql = "SELECT photo_no photoNo, photo_name photoName, writer, create_date createDate FROM photo WHERE photo_no = ? ORDER BY create_date DESC";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		System.out.println("[Dao.selectphotoOne] sql : " + stmt);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			photo = new Photo(); // 생성자메서드
			photo.photoNo = rs.getInt("photoNo");
			photo.photoName = rs.getString("photoName");
			photo.writer = rs.getString("writer");
			photo.createDate = rs.getString("createDate");
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return photo;
	}
	
	// 전체 행의 수
	public int selectPhotoTotalRow() throws Exception {
		// int total = 0;
		// return total;
		
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3307/blog"; // 주소
		String dbuser = "root"; // 아이디
		String dbpw = "java1234"; // 패스워드
		
		String sql = "SELECT COUNT(*) cnt FROM guestbook";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println("[selectPhotoTotalRow] conn : " + conn + " / 드라이버 로딩 성공");
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		return row;
	}
	
	// 수정은 삭제 후 새로 입력
}
