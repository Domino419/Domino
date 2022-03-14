package User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


 
public class UserDao {
	 Connection conn = null;       
     PreparedStatement pstmt = null;     
	 ResultSet rs;                    

	
		
		public UserDao() {
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "web_user", "pass");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	   
		

		public int login(String userID, String userPassword) throws ClassNotFoundException, SQLException {

			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "web_user", "pass");
			String sql = "select userPassword from bbs where userID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {

					return 1;
				} else
					return 0;
			}
			return -1;

		}
			
			
	
				
	public int join(User user) {
		String SQL = "INSERT INTO bbs VALUES (?,?,?,?,?)" ;
		try {
			pstmt = conn.prepareStatement(SQL);
			String UserID;
			UserID = new String(user.getUserID().getBytes("iso-8859-1"),"euc-kr");
	        String UserPassword;
	        UserPassword = new String(user.getUserPassword().getBytes("iso-8859-1"),"euc-kr");
	        String UserName;
	        UserName = new String(user.getUserName().getBytes("iso-8859-1"),"euc-kr");
	        String UserGender;
	        UserGender = new String(user.getUserGender().getBytes("iso-8859-1"),"euc-kr");
	        String Email;
	        Email = new String(user.getUserEmail().getBytes("iso-8859-1"),"euc-kr");
	        
	      
	        
	        pstmt.setString(1,UserID);
			pstmt.setString(2,UserPassword);
			pstmt.setString(3,UserName);
			pstmt.setString(4,UserGender);
			pstmt.setString(5,Email);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
}
	        
//			pstmt = conn.prepareStatement(SQL);
//			pstmt.setString(1,user.getUserID());
//			pstmt.setString(2,user.getUserPassword());
//			pstmt.setString(3,user.getUserName());
//			pstmt.setString(4,user.getUserGender());
//			pstmt.setString(5,user.getUserEmail());
//			return pstmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return -1; 
//	}
//}
//		
//			

