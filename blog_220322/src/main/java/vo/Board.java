package vo;

public class Board {
	public Board() { } // -생성자 메소드
	
	// -----------------필드의 정보 은닉(private)
	private int boardNo;
	private String categoryName;
	private String boardTitle;
	private String boardContent;
	private String boardPw;
	private String createDate;
	private String updateDate;
	
	// -----------------Getter & Setter
	
	// -[boardNo] Getter & Setter
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	
	// -[categoryName] Getter & Setter
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	// -[boardTitle] Getter & Setter
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	
	// -[boardContent] Getter & Setter
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	
	// -[boardPw] Getter & Setter
	public String getBoardPw() {
		return boardPw;
	}
	public void setBoardPw(String boardPw) {
		this.boardPw = boardPw;
	}
	
	// -[createDate] Getter & Setter
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	// -[updateDate] Getter & Setter
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
}
