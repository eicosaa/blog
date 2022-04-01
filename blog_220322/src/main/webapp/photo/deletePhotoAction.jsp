<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.PhotoDao" %>
<%@ page import = "vo.Photo" %>
<%
 	// 1) 테이블 데이터 삭제 <- photoNo 필요
	// 2) upload 폴더에 이미지 삭제 <- photoName

	request.setCharacterEncoding("utf-8");	
	
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");	
	String photoName = request.getParameter("photoName");	
	
	PhotoDao photoDao = new PhotoDao();
	
	
	// 1) 테이블 데이터 삭제
	int delRow = photoDao.deletePhoto(photoNo, photoPw);
	
	// 2) 폴더 이미지 삭제
	if(delRow == 1) { // 테이블 데이터 삭제 성공
		String path = application.getRealPath("upload"); // application(현재 프로젝트)안의 upload 폴더의 실제 폴더 경로를 반환
		File file = new File(path + "\\" + photoName); // 잘못된 파일을 불러온다. java.io.File
		file.delete(); // 이미지 파일을 삭제
		System.out.println("[deletePhotoAction.jsp] 삭제 성공");
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
	} else {
		System.out.println("[deletePhotoAction.jsp] 삭제 실패");
		response.sendRedirect(request.getContextPath()+"/photo/deletePhotoForm.jsp?photoNo=" + photoNo);
	}
	
	// -디버깅 코드
	System.out.println("[deletePhotoAction.jsp] photoNo : " + photoNo);
	System.out.println("[deletePhotoAction.jsp] photoPw : " + photoPw);
	System.out.println("[deletePhotoAction.jsp] photoName : " + photoName);
	System.out.println("[deletePhotoAction.jsp] delRow : " + delRow);  

/* 	// 인코딩
	request.setCharacterEncoding("utf-8");	
	
	// 요청값
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));		
	String photoPw = request.getParameter("photoPw");	
	
	// -메소드 호출
	PhotoDao photoDao = new PhotoDao();
	Photo photo = new Photo();
	
	int row = photoDao.deletePhoto(photoNo, photoPw);

	// 디버깅
	if(row == 1) { // 반환 값이 1일 때 삭제 성공, photoList 이동
		System.out.println("[deletePhotoAction.jsp] 삭제 성공");
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
	} else if(row == 0) { // 반환 값이 0일 때 삭제 실패, deletePhotoForm 이동
		System.out.println("[deletePhotoAction.jsp] 삭제 실패");
		response.sendRedirect(request.getContextPath()+"/photo/deletePhotoForm.jsp?photoNo=" + photoNo);
	} else { // 반환 값이 0, 1이 아닐 떄 에러
		System.out.println("[deletePhotoAction.jsp] 에러");
	}
		
	// -디버깅 코드
	System.out.println("[deletePhotoAction.jsp] photoNo : " + photo.photoNo);
	System.out.println("[deletePhotoAction.jsp] photoPw : " + photo.photoPw);
	System.out.println("[deletePhotoAction.jsp] row : " + row);  */
%>