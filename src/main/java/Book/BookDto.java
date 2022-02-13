package Book;

public class BookDto {
  private int bookid ;  
  private int isbn ;     //고유한 값
  private String booktitle ;  // 제목 
  private String bookwriter ; // 지은이 
  private String bookpublish ;   //출판사 
  private int page ;
  private int bookprice ;     // ISBN으로 긁었더니 딸려온 거. 구매금액 != 출판금액 
  private String pday ;
  private String memo ;      //기남 book coment 
  private String gubun ;     // 장르 구분 
  
//getter/setter 자동 추가 단축키 · Alt + Shift + S  외우자!! //

  
public int getBookid() {
	return bookid;
}
public void setBookid(int bookid) {
	this.bookid = bookid;
}
public int getIsbn() {
	return isbn;
}
public void setIsbn(int isbn) {
	this.isbn = isbn;
}
public String getBooktitle() {
	return booktitle;
}
public void setBooktitle(String booktitle) {
	this.booktitle = booktitle;
}
public String getBookwriter() {
	return bookwriter;
}
public void setBookwriter(String bookwriter) {
	this.bookwriter = bookwriter;
}
public String getBookpublish() {
	return bookpublish;
}
public void setBookpublish(String bookpublish) {
	this.bookpublish = bookpublish;
}
public int getPage() {
	return page;
}
public void setPage(int page) {
	this.page = page;
}
public int getBookprice() {
	return bookprice;
}
public void setBookprice(int bookprice) {
	this.bookprice = bookprice;
}
public String getPday() {
	return pday;
}
public void setPday(String pday) {
	this.pday = pday;
}
public String getMemo() {
	return memo;
}
public void setMemo(String memo) {
	this.memo = memo;
}
public String getGubun() {
	return gubun;
}
public void setGubun(String gubun) {
	this.gubun = gubun;
}
  
}

