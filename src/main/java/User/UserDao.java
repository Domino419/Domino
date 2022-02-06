package User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.*;
import oracle.*;


 
public class UserDao {
	 Connection conn = null;       
     PreparedStatement pstmt = null;     
	 ResultSet rs;                    

	
		
		  public UserDao() { 
			  try
		  { 
				  Class.forName("oracle.jdbc.driver.OracleDriver");
		          conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","web_user","pass"); 
		  }catch (Exception e)
		  { e.printStackTrace() ;
		    }
		  }
		 
	   
			public int login(String userID, String userPassword) throws ClassNotFoundException, SQLException {

			/*
			 * Class.forName("oracle.jdbc.driver.OracleDriver"); conn =
			 * DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","web_user",
			 * "pass");
			 */
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","web_user", "pass");
			String sql = "select userPassword from bbs where userID = ?";
		//	System.out.println(sql); 
				pstmt = conn.prepareStatement(sql); 
				pstmt.setString(1, userID); 
				rs = pstmt.executeQuery(); 
			//	System.out.println(rs);
				if(rs.next()) {
					if(rs.getString(1).equals(userPassword)) {
						return 1; 
					}else
						return 0; 
				}
				return -1; 
			
			//return -2; //DB 
				
		}		
				
	public int join(User user) {
		String SQL = "INSERT INTO bbs VALUES (?,?,?,?,?)" ;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,user.getUserID());
			pstmt.setString(2,user.getUserPassword());
			pstmt.setString(3,user.getUserName());
			pstmt.setString(4,user.getUserGender());
			pstmt.setString(5,user.getUserEmail());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
}
		
			

