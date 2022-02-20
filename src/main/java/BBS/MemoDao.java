package BBS;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MemoDao {
	  Connection conn = null;       //JDBC 설정 연결하기  
	  PreparedStatement pstmt = null;      //쿼리문 설정 및 실행 
	  ResultSet rs;                    //결과값 받아오는 객체  	

	  public MemoDao() { 
		   try{ Class.forName("oracle.jdbc.driver.OracleDriver");
	             conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","web_user","~~~~"); 
	  }catch 
		  (Exception e)
				  { e.printStackTrace() ;    //connection부터 이까지 한 덩어리//
	    }
	  }		 	   

	public String getDate() // 현재시간을 넣어주기위해
	{
	    String SQL = "SELECT SYSDATE FROM DUAL"; // 현재 시간 찍기 
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        rs = pstmt.executeQuery();
	        if(rs.next()) {
	            return rs.getString(1);
	        }        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return ""; // 데이터베이스 오류
	}

	
	/**<pre> getNext row 갯수를 세어서 게시글 번호를 넘버링함 / BBS게시판이랑 다른 넘버링 방식 </pre> */
	public int getNext()   
	{
	    String SQL = "SELECT MAX(MEMOID) FROM PROJECTHISTORY";   
	     //String SQL = "select count(*) from projecthistory where memoavailable = 1";   
	     try {
	         PreparedStatement pstmt = conn.prepareStatement(SQL);
	         rs = pstmt.executeQuery();
	         while (rs.next()) {
	         int a = rs.getInt(1) + 1 ;
	         return a;
	         }
	        }catch (Exception e) {
	           e.printStackTrace();
	        }
	    return -1; //
	 }
    //Memo게시판용 메소드 생성 
	//글쓰기 form에서 제목, 글쓴이, 내용 
		public int mwrite(String workcoment, String userID, String Coment) {	
	   // String SQL = "INSERT INTO PROJECTHISTORY VALUES (?,?,?,?,?)"; 입력할 때 날짜값이 틀려서 인서트 실패 
	    String SQL = "INSERT INTO PROJECTHISTORY VALUES  (TO_DATE( ?, 'YYYY-MM-DD HH24:MI:SS'),?,?,?,?)";
	    //INSERT INTO PROJECTHISTORY VALUES (TO_CHAR(TO_DATE('20200202', 'yyyymmdd')),1,2,3,16); test SQL OK
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        
	        String title;
	        title = new String(workcoment.getBytes("iso-8859-1"),"euc-kr");
	        String content;
	        content = new String(Coment.getBytes("iso-8859-1"),"euc-kr");    
	        
	        
	        pstmt.setString(1, getDate());  // 위에서 만든 data값을 넣어줌 / 
	        pstmt.setString(2, title);       // 제목란
	        pstmt.setString(3, content);    //  글 내용 
	        pstmt.setInt   (4, getNext());   // memoid 게시판 번호 .순서 
	        pstmt.setInt   (5, 1);
	        return pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // 데이터베이스 오류
	}
		
	     public ArrayList<Memo> getList(int pageNumber){
	    String SQL =   "SELECT * FROM (SELECT A.*, RANK() OVER(ORDER BY MemoID desc) RNUM FROM PROJECTHISTORY A WHERE memoAvailable = 1) WHERE rnum <= ? AND rnum >= ? ";   
	    /*SELECT * 
	    FROM (SELECT A.*, RANK() OVER(ORDER BY MemoID DESC) M FROM PROJECTHISTORY A WHERE memoAvailable = 1)
	    WHERE MEMOID <= 10 AND MEMOID >= 1   sql 쿼리 실행 ok */
	     
	     
	    ArrayList<Memo> list = new ArrayList<Memo>();
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(2, (pageNumber - 1 ) * 10 + 1);
	        pstmt.setInt(1, (pageNumber - 1 ) * 10 + 10);
	        rs = pstmt.executeQuery();
	        
	        while (rs.next()) {
	        Memo memo = new Memo(); //리스트로 만들어서 반환 / 
	            
	        memo.setData(rs.getString(1));
	        memo.setWorkcoment(rs.getString(2));
	        memo.setComent(rs.getString(3));
	        memo.setMemoid(rs.getInt(4));
	        memo.setMemoavailable(rs.getInt(5));
	        list.add(memo);
	            
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list; 
	  }
	     
	     
	     
	     public boolean nextPage(int pageNumber) {
	         String SQL = "SELECT * FROM PROJECTHISTORY WHERE memoAvailable = 1 and memoid > ? "; 
	         try {
	             PreparedStatement pstmt = conn.prepareStatement(SQL);
	             pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
	             rs = pstmt.executeQuery();
	             if (rs.next())
	             {
	                 return true;
	             }
	         } catch (Exception e) {
	             e.printStackTrace();
	         }
	         return false; 
	     }
			
			public Memo getMemo(int memoid) {
				String SQL = "SELECT * FROM PROJECTHISTORY WHERE memoid = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setInt(1, memoid);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						Memo Memo = new Memo();

						Memo.setData(rs.getString(1));
						Memo.setWorkcoment(rs.getString(2));
						Memo.setComent(rs.getString(3));
						Memo.setMemoid(rs.getInt(4));
						Memo.setMemoavailable(rs.getInt(5));
						return Memo;
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return null;
			}

			public int mupdate (int memoid, String workcoment, String Conment) throws UnsupportedEncodingException {
				  String title;
				  title = new String(workcoment.getBytes("iso-8859-1"),"euc-kr");
				  String content;
				  content = new String(Conment.getBytes("iso-8859-1"),"euc-kr");
				 String SQL = "UPDATE PROJECTHISTORY SET workcoment = ?, Coment = ? WHERE  memoid = ? ";

			  	try {
				       PreparedStatement pstmt = conn.prepareStatement(SQL);
			           pstmt.setString(1, title);
			           pstmt.setString(2, content);
				       pstmt.setInt(3, memoid);
				       return pstmt.executeUpdate();
				    } catch (Exception e) {
				        e.printStackTrace();
				    }
				    return -1; // 데이터베이스 오류
			   } 
			 
			public int mdelete(int memoid)
			{
			    String SQL = "UPDATE PROJECTHISTORY SET bbsAvailable = 0  WHERE memoid = ?";
			    try {
			        PreparedStatement pstmt = conn.prepareStatement(SQL);
			        pstmt.setInt(1, memoid);
			        return pstmt.executeUpdate();
			    } catch (Exception e) {
			        e.printStackTrace();
			    }
			    return -1; // 데이터베이스 오류
			}
}
