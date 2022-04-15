package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class CategoryDao {
	public CategoryDao() { } // -생성자 메소드
	
	// -카테고리 목록과 카테고리별 개수 메서드
	public ArrayList<HashMap<String, Object>> CategoryList() throws Exception {
		
		// 데이터베이스 접속 + 자원 준비
		Connection conn = null;
		conn = DBUtil.getConnection();
		System.out.println("[CategoryDao.CategoryList] conn : " + conn + " / 드라이버 로딩 성공");
		PreparedStatement stmt = null;

		String categorySql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
		PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
		ResultSet categoryRs = categoryStmt.executeQuery();
		
		// 쿼리에 결과를 Category, Board VO로 저장할 수 없다. -> HashMap을 사용해서 저장하자!
		ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
		while(categoryRs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("categoryName", categoryRs.getString("categoryName"));
			map.put("cnt", categoryRs.getInt("cnt"));
			categoryList.add(map);
		}

		return categoryList;
	}
}
