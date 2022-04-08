package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Guestbook;
import vo.Photo;

public class PhotoDao {
	
	// 이미지 이름을 반환하는 메서드
	public String selectPhotoName(int photoNo) throws Exception {
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[PhotoDao.selectPhotoName] conn : " + conn + " / 드라이버 로딩 성공");
		
		PreparedStatement stmt = null;
		String sql = "SELECT photo_name FROM photo WHERE photo_no = ?";
		String photoName = "";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, photoName);

		return photoName;
	}
	
	// 이미지 입력
	public void insertPhoto(Photo photo) throws Exception {
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[PhotoDao.insertPhoto] conn : " + conn + " / 드라이버 로딩 성공");
		
		PreparedStatement stmt = null;
		String sql = "INSERT INTO photo(photo_name, photo_original_name, photo_type, photo_pw, writer, create_date, update_date) VALUES(?, ?, ?, ?, ?, NOW(), NOW())";

		stmt = conn.prepareStatement(sql);
		stmt.setString(1, photo.getPhotoName());
		stmt.setString(2, photo.getPhotoOriginalName());
		stmt.setString(3, photo.getPhotoType());
		stmt.setString(4, photo.getPhotoPw());
		stmt.setString(5, photo.getWriter());
		
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
		
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[PhotoDao.deletePhoto] conn : " + conn + " / 드라이버 로딩 성공");
		
		PreparedStatement stmt = null;
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

		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[PhotoDao.selectPhotoListByPage] conn : " + conn + " / 드라이버 로딩 성공");
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT photo_no photoNo, photo_name photoName FROM photo ORDER BY create_date DESC LIMIT ?,?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Photo p = new Photo();
			p.setPhotoNo(rs.getInt("photoNo"));
			p.setPhotoName(rs.getString("photoName"));
			list.add(p);
		}
		return list;
	}
	
	// 이미지 하나 상세보기
	public Photo selectPhotoOne(int photoNo) throws Exception {
		Photo photo = null;
		
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[PhotoDao.selectPhotoOne] conn : " + conn + " / 드라이버 로딩 성공");
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT photo_no photoNo, photo_name photoName, writer, create_date createDate FROM photo WHERE photo_no = ? ORDER BY create_date DESC";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		System.out.println("[Dao.selectphotoOne] sql : " + stmt);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			photo = new Photo(); // 생성자메서드
			photo.setPhotoNo(rs.getInt("photoNo"));
			photo.setPhotoName(rs.getString("photoName"));
			photo.setWriter(rs.getString("writer"));
			photo.setCreateDate(rs.getString("createDate"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return photo;
	}
	
	// 전체 행의 수
	public int selectPhotoTotalRow() throws Exception {
		int row = 0;
		
		// -데이터베이스 접속 + 자원 준비
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[PhotoDao.selectPhotoTotalRow] conn : " + conn + " / 드라이버 로딩 성공");
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
	
	// 수정은 삭제 후 새로 입력
}
