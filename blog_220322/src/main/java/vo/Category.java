package vo;
// category 테이블 VO(도메인 객체) : VO, DTO, Domain
public class Category {
	public Category() { } // -생성자 메소드
	
	// -----------------필드의 정보 은닉(private)
	private String categoryName;
	private String createDate;
	private String updateDate;
	
	@Override
	public String toString() {
		return "Category [categoryName=" + categoryName + ", createDate=" + createDate + ", updateDate=" + updateDate
				+ "]";
	}
	
	// -----------------Getter & Setter
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
	
}
