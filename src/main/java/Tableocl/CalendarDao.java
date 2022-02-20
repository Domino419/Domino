package Tableocl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class CalendarDao {
      Connection conn = null;       //JDBC 설정 연결하기  
	  PreparedStatement pstmt = null;      //쿼리문 설정 및 실행 
	  ResultSet rs;                    //결과값 받아오는 객체  	

	  public CalendarDao() { try{ Class.forName("oracle.jdbc.driver.OracleDriver");
	  conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","web_user","~~~~"); 
	  }catch 
		  (Exception e)
				  { e.printStackTrace() ;    //connection부터 이까지 한 덩어리//
	    }
	  }		 	   

	  public int write(String MemoYear, String MemoMonth, String MemoDay,String MemoContents) {
		    String SQL = "INSERT INTO CALENDARMEMO(MEMOYEAR, MEMOMONTH, MEMODAY, MEMOCONTENTS)"
		    		+ "VALUES (?, ?, ?, ?)";
		    try {
		        PreparedStatement pstmt = conn.prepareStatement(SQL);
		        
				/*
				 * //String MemoYear; MemoYear = new
				 * String(MemoYear.getBytes("iso-8859-1"),"euc-kr"); // String MemoMonth = 0;
				 * MemoMonth = new String(MemoMonth.getBytes("iso-8859-1"),"euc-kr"); // String
				 * MemoDay = 0; MemoDay = new String(MemoDay.getBytes("iso-8859-1"),"euc-kr");
				 * // String MemoContents = 0;
				 */		        
		        //MemoContents = new String(MemoContents.getBytes("iso-8859-1"),"euc-kr");
		        
		        pstmt.setInt(1, Integer.parseInt(MemoYear));
		        pstmt.setInt(2, Integer.parseInt(MemoMonth));
		        pstmt.setInt(3, Integer.parseInt(MemoDay));
		        pstmt.setString(4, MemoContents);
				/* pstmt.setInt(6, 1); */
		        return pstmt.executeUpdate();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return -1; // 데이터베이스 오류
		}
	
	
}

