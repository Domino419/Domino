package BBS;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.*;

public class BbsDAO {
  Connection conn = null;       //JDBC 설정 연결하기  
  PreparedStatement pstmt = null;      //쿼리문 설정 및 실행 
  ResultSet rs;                    //결과값 받아오는 객체  	

  public BbsDAO() { try{ Class.forName("oracle.jdbc.driver.OracleDriver");
  conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","web_user","pass"); 
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

public int getNext()   //게시글 번호 가져오기 
{
     String SQL = "SELECT MAX(bbsID) FROM BBSJSP";   
	  
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
public int write(String bbsTitle, String userID, String bbsContent) {
    String SQL = "INSERT INTO BBSJSP VALUES (?,?,?,?,?,?)";
    try {
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        String title;
        title = new String(bbsTitle.getBytes("iso-8859-1"),"euc-kr");
        String content;
        content = new String(bbsContent.getBytes("iso-8859-1"),"euc-kr");
        pstmt.setInt(1, getNext());
        pstmt.setString(2, title);
        pstmt.setString(3, userID);
        pstmt.setString(4, getDate());
        pstmt.setString(5, content);
        //pstmt.setString(5, "테스트");
        pstmt.setInt(6, 1);
        return pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return -1; // 데이터베이스 오류
}
     public ArrayList<BBS> getList(int pageNumber)
     //public ArrayList<BBS> getList()
    {
    String SQL = "     SELECT * FROM"
    		+ "    		(SELECT A.*, RANK() OVER(ORDER BY BBSID DESC) RNUM FROM BBSJSP A WHERE bbsAvailable = 1) "
    		+ "    		WHERE RNUM >= ? AND RNUM <= ? ";
    ArrayList<BBS> list = new ArrayList<BBS>();
    try {
        PreparedStatement pstmt = conn.prepareStatement(SQL);
       // pstmt.setInt(1, 10);        
        pstmt.setInt(1, (pageNumber - 1 ) * 10 + 1);
        pstmt.setInt(2, (pageNumber - 1 ) * 10 + 10);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            BBS bbs = new BBS();
            bbs.setBbsid(rs.getInt(1));
            bbs.setBbstitle(rs.getString(2));
            bbs.setUserID(rs.getString(3));
            bbs.setBbsdate(rs.getString(4));
            bbs.setBbscontent(rs.getString(5));
            bbs.setBbsavailable(rs.getInt(6));
            list.add(bbs);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list; 
}
     public boolean nextPage(int pageNumber) {
         String SQL = "SELECT * FROM BBSJSP WHERE BBSAVAILABLE = 1 and BBSID < ? "; 
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
 
public BBS getBbs(int bbsID)
{
        String SQL = "SELECT * FROM BBSJSP WHERE BBSID = ?"; 
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            rs = pstmt.executeQuery();
            if (rs.next())
            {
                BBS bbs = new BBS();
                bbs.setBbsid(rs.getInt(1));
                bbs.setBbstitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsdate(rs.getString(4));
                bbs.setBbscontent(rs.getString(5));
                bbs.setBbsavailable(rs.getInt(6));
                return bbs;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; 
    }


 public int update (int bbsid, String bbsTitle, String bbsContent) throws UnsupportedEncodingException {
	  String title;
	  title = new String(bbsTitle.getBytes("iso-8859-1"),"euc-kr");
	  String content;
	  content = new String(bbsContent.getBytes("iso-8859-1"),"euc-kr");
	 String SQL = "UPDATE BBSJSP SET BBSTITLE = ?, BBSCONTENT = ? WHERE  BBSID = ? ";

  	try {
	       PreparedStatement pstmt = conn.prepareStatement(SQL);
           pstmt.setString(1, title);
           pstmt.setString(2, content);
	       pstmt.setInt(3, bbsid);
	       return pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1; // 데이터베이스 오류
   } 
 
public int delete(int bbsID)
{
    String SQL = "UPDATE BBSJSP SET bbsAvailable = 0  WHERE bbsID = ?";
    try {
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        pstmt.setInt(1, bbsID);
        return pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return -1; // 데이터베이스 오류
}

/**
  * @Method Name : getSearch
  * @작성일 : 2022. 2. 28.
  * @작성자 : bluem
  * @변경이력 : 
  * @Method 설명 : bbs 게시판에서 검색 기능 활용을 위해 만든 메소드
  * @param searchField
  * @param searchText
  * @return
 * @throws UnsupportedEncodingException 
 * @throws SQLException 
  */


/*
 * public ArrayList<BBS> getSearch(String searchField, String searchText) throws
 * UnsupportedEncodingException, SQLException {// 특정한 리스트를 받아서 반환
 * 
 * ArrayList<BBS> list = new ArrayList<BBS>();
 * 
 * try { if (searchText != null && !searchText.equals("")) { //검색박스가 null이나 공란이
 * 아니면 String searchField1 = new String
 * (searchField.getBytes("iso-8859-1"),"euc-kr"); //게시판 드롭박스 선택값 제목 or 작성자을 가져와서
 * search1로 선언 // String searchField2 = searchField1.toUpperCase(); // 게시판에서
 * 검색필드에 입력한 값을 가져와서 search2로 선언 String searchText1 = new
 * String(searchText.getBytes("iso-8859-1"),"euc-kr"); //String searchText2 =
 * searchText1.toUpperCase(); String SQL =
 * "SELECT bbsid,bbstitle, userid, bbsdata, bbscontent FROM BBSJSP WHERE BBSAVAILABLE = 1 AND 'searchField2' LIKE '%searchText2%' "
 * ;
 * 
 * 
 * 
 * Statement stmt = conn.createStatement(); rs = stmt.executeQuery(SQL);// 문장을
 * 실행하고 결과를 리턴 받음
 * 
 * while (rs.next()) { //Result set에 저장된 데이터 얻기 //BBS getSearch = new BBS();
 * //list. //String searchField1 = rs.getString(1); //String searchText1 =
 * rs.getString(2);
 * 
 * } } } finally { rs.close(); } return list; }
 */
public ArrayList<BBS> getList1(String field_, String query_, int page) {
	
	String field = "bbstitle";
	if(field_ != null && !field_.equals(""))
		field = field_;
	
	String query = "";
	if(query_ != null && !query_.equals(""))
		query = query_;
	
	
	ArrayList<BBS> list= new ArrayList<BBS>();		
	
    String SQL = "     SELECT * FROM"
    		+ "    		(SELECT A.*, RANK() OVER(ORDER BY BBSID DESC) RNUM FROM BBSJSP A WHERE bbsAvailable = 1"
    		+ "			and upper("+field+") LIKE upper(?))  "   //조회필드
    		+ "    		WHERE RNUM >= ? AND RNUM <= ? ";
	
	try {

		PreparedStatement pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, "%"+query+"%" ); //조회값
        pstmt.setInt(2, (page - 1 ) * 10 + 1);
        pstmt.setInt(3, (page - 1 ) * 10 + 10);
		rs = pstmt.executeQuery();
		
		   while (rs.next()) {
		       BBS bbs = new BBS();
		       bbs.setBbsid(rs.getInt(1));
		       bbs.setBbstitle(rs.getString(2));
		       bbs.setUserID(rs.getString(3));
		       bbs.setBbsdate(rs.getString(4));
		       bbs.setBbscontent(rs.getString(5));
		       bbs.setBbsavailable(rs.getInt(6));
		       list.add(bbs);
		   }
		} catch (Exception e) {
		   e.printStackTrace();
		}
		return list; 
}

}
	    