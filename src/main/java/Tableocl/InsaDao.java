package Tableocl;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



/**
  * @FileName : InsaDao.java
  * @Project : Jsptest
  * @Date : 2022. 2. 6. 
  * @작성자 : Domino
  * @변경이력 : 인사메뉴에서 쓰는 함수들 모음 
  * @프로그램 설명 :  DB연결  line 21~ line 34
  */
public class InsaDao {
	  Connection conn = null;       
	  PreparedStatement pstmt = null;     
	  ResultSet rs;                    	

	  public InsaDao() { 
		   try{ Class.forName("oracle.jdbc.driver.OracleDriver");
	             conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","web_user","~~~~"); 
	  }catch 
		  (Exception e)
				  { e.printStackTrace() ;    
	    }
	  }	
    }       




 // 당일 근무율 확인 // 
 // 직원 명단 확인 및 수정  - 인사 DB연결해서 CRUD //
 // 엑셀로 인사 DB자료 UPload//
 // 엑셀로 인사 DB자료 download //
 // 고용전환 예정자 확인  - sql 결과 rs tableㄴㄴㄴ로 웹으로 넘겨주기 // 
 

