package BBS;

public class BBS {
	private int bbsid ;    
	private String bbstitle ;   
	private String userID ;      
	private String bbsdate ;      
	private String bbscontent ;     
	private int bbsavailable ;       
	
	public int getBbsid() {
		return bbsid;
	}
	public void setBbsid(int bbsid) {
		this.bbsid = bbsid;
	}
	public String getBbstitle() {
		return bbstitle;
	}
	public void setBbstitle(String bbstitle) {
		this.bbstitle = bbstitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsdate() {
		return bbsdate;
	}
	public void setBbsdate(String bbsdate) {
		this.bbsdate = bbsdate;
	}
	public String getBbscontent() {
		return bbscontent;
	}
	public void setBbscontent(String bbscontent) {
		this.bbscontent = bbscontent;
	}
	public int getBbsavailable() {
		return bbsavailable;
	}
	public void setBbsavailable(int i) {
		this.bbsavailable = i;
	}
	
}
