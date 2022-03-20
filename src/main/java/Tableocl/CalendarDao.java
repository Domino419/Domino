package Tableocl;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;





public class CalendarDao {
      Connection conn = null;       //JDBC 설정 연결하기  
	  PreparedStatement pstmt = null;      //쿼리문 설정 및 실행 
	  ResultSet rs;                    //결과값 받아오는 객체  	

	  public CalendarDao() { try{ Class.forName("oracle.jdbc.driver.OracleDriver");
	  conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","web_user","pass"); 
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

		        pstmt.setInt(1, Integer.parseInt(MemoYear));
		        pstmt.setInt(2, Integer.parseInt(MemoMonth));
		        pstmt.setInt(3, Integer.parseInt(MemoDay));
		        pstmt.setString(4, MemoContents);
		        return pstmt.executeUpdate();
		    } catch (Exception e) {
		        e.printStackTrace();
		 
		    return -1;} // 데이터베이스 오류
		    }
       

			/*
			 * 
			 * SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			 * SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy년 MM월dd일 HH시mm분ss초");
			 * 
			 * String format_time1 = format1.format (System.currentTimeMillis()); String
			 * format_time2 = format2.format (System.currentTimeMillis());
			 */
	
  
			public ArrayList<CalendarDto> getList(String y_, String m_) throws UnsupportedEncodingException   
			{
				String y = "year";
	    		if(y_ != null && !y_.equals(""))
	    			y = y_;
	    		
	    		String m = "";
	    		if(m_ != null && !m_.equals(""))
	    			m = m_;
				
				
		    String SQL = "SELECT MEMOYEAR , MEMOMONTH, MEMODAY, MEMOCONTENTS FROM CALENDARMEMO WHERE MEMOYEAR in (?) AND MEMOMONTH IN (?)" ; 

		    ArrayList<CalendarDto> list = new ArrayList<CalendarDto>();
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1, y);
				    pstmt.setString(2, m);
					rs = pstmt.executeQuery();
					
					while (rs.next()) {
						CalendarDto calendardto = new CalendarDto();  //리스트로 만들어서 반환 / 
						
						calendardto.setMemoYear(rs.getString(1));
						calendardto.setMemoMonth(rs.getString(2));
						calendardto.setMemoDay(rs.getString(3));
						calendardto.setMemoContents(rs.getString(4)); 
						list.add(calendardto);
						
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return list;
			}

		}