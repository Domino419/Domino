package BBS;

//프로젝트 히스토리 기록용  - 게시판명 Memo에 쓸 JAVA Bean //

public class Memo {
  private int memoid ;	
  private String data ;  
  private String workcoment ;   
  private String coment ;
  private String userID ;       
  private int memoavailable ;
  
  
public int getMemoid() {
	return memoid;
}
public void setMemoid(int memoid) {
	this.memoid = memoid;
}
public String getData() {
	return data;
}
public void setData(String data) {
	this.data = data;
}
public String getWorkcoment() {
	return workcoment;
}
public void setWorkcoment(String workcoment) {
	this.workcoment = workcoment;
}
public String getComent() {
	return coment;
}
public void setComent(String coment) {
	this.coment = coment;
}
public String getUserID() {
	return userID;
}
public void setUserID(String userID) {
	this.userID = userID;
}
public int getMemoavailable() {
	return memoavailable;
}
public void setMemoavailable(int memoavailable) {
	this.memoavailable = memoavailable;
}
/*
 * public Memo(int memoid, String data, String workcoment, String coment, String
 * userID, int memoavailable) { super(); this.memoid = memoid; this.data = data;
 * this.workcoment = workcoment; this.coment = coment; this.userID = userID;
 * this.memoavailable = memoavailable; }
 */   

  
  
}
