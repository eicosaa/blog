package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Pdf;

public class PdfDao {
	public PdfDao() { } // -생성자 메소드
	
	// pdf 입력 (insertPdfAction.jsp)
	public void insertPdf(Pdf pdf) throws Exception {
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[PdfDao.insertPdf] conn : " + conn + " / 드라이버 로딩 성공");
		
		PreparedStatement stmt = null;
		String sql = "INSERT INTO pdf(pdf_name, pdf_original_name, pdf_type, pdf_pw, writer, create_date, update_date) VALUES(?, ?, ?, ?, ?, NOW(), NOW())";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, pdf.getPdfName());
		stmt.setString(2, pdf.getPdfOriginalName());
		stmt.setString(3, pdf.getPdfType());
		stmt.setString(4, pdf.getPdfPw());
		stmt.setString(5, pdf.getWriter());
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("[insertPdf] 입력 성공");
		} else {
			System.out.println("[insertPdf] 입력 실패");
		}
		// -데이터베이스 자원 반환
		stmt.close();
		conn.close();
	}
	
	// pdf 삭제 (return row로 삭제할 행의 수 반환, deletePdfAction.jsp)
	public int deletePdf(int pdfNo, String pdfPw) throws Exception {
		int row = 0;
		
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[PdfDao.deletePdf] conn : " + conn + " / 드라이버 로딩 성공");
		
		PreparedStatement stmt = null;		
		String sql = "DELETE FROM pdf WHERE pdf_no = ? AND pdf_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, pdfNo);
		stmt.setString(2, pdfPw);
		
		System.out.println("[Dao.deletepdf] sql : " + stmt);
		row = stmt.executeUpdate();
		
		// -데이터베이스 자원 반환
		stmt.close();
		conn.close();
		return row;
	}
	
	// pdf 목록 (n행씩 반환)
	public ArrayList<Pdf> selectPdfListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Pdf> list = new ArrayList<Pdf>();
		
		// 10행 반환되도록 구현
		Class.forName("org.mariadb.jdbc.Driver"); // -드라이버 로딩
		
		// 데이터베이스 자원 준비
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[PdfDao.selectPdfListByPage] conn : " + conn + " / 드라이버 로딩 성공");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT pdf_no pdfNo, pdf_original_name pdfOriginalName, writer, create_date createDate FROM pdf ORDER BY create_date DESC LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		// 데이터베이스 로직 끝
		
		// 데이터 변환(가공)
		while(rs.next()) {
			Pdf p = new Pdf();
			p.setPdfNo(rs.getInt("pdfNo"));
			p.setPdfOriginalName(rs.getString("pdfOriginalName"));
			p.setWriter(rs.getString("writer"));
			p.setCreateDate(rs.getString("createDate"));
			list.add(p);
		}
		
		// 데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// 상세보기
	public Pdf selectPdfOne(int pdfNo) throws Exception {
		Pdf pdf = null;
		
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[PdfDao.selectPdfOne] conn : " + conn + " / 드라이버 로딩 성공");
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT pdf_no pdfNo, pdf_original_name pdfOriginalName, writer, create_date createDate FROM pdf WHERE pdf_no = ? ORDER BY create_date DESC";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, pdfNo);
		System.out.println("[Dao.selectpdfOne] sql : " + stmt);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			pdf = new Pdf(); // 생성자메서드
			pdf.setPdfNo(rs.getInt("pdfNo"));
			pdf.setPdfOriginalName(rs.getString("pdfOriginalName"));
			pdf.setWriter(rs.getString("writer"));
			pdf.setCreateDate(rs.getString("createDate"));
		}
		
		// 데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return pdf;
	}
	
	// 전체 행의 수
	public int selectPdfTotalRow() throws Exception {
		int row = 0;
		
		// 데이터베이스 자원 준비
		// -데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[PdfDao.selectPdfTotalRow] conn : " + conn + " / 드라이버 로딩 성공");
		PreparedStatement stmt = null;
		ResultSet rs = null;
				
		String sql = "SELECT COUNT(*) cnt FROM pdf";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		return row;
	}
}
