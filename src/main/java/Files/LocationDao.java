/* LocationDao.java */

package Files;

import java.sql.*;
import java.util.*;
import Files.files;

public class LocationDao {
	// +-------------½Ì±ÛÅæ ÆÐÅÏ Àû¿ë-------------+
	private static LocationDao locationDao = new LocationDao();
	
	private LocationDao() {	
	}
	public static LocationDao getLocationDao() {
		return locationDao;
	}
	// +-------------½Ì±ÛÅæ ÆÐÅÏ Àû¿ë-------------+
	
	private Connection getConnection() throws Exception {
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "scott", pw = "tiger";
		Connection con = null;
		
		Class.forName("oracle.jdbc.OracleDriver");
		con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","web_user","pass");
		return con;
	}

	// JDBC ÀÚ¿ø ´Ý±â
	private void closeJDBC(Connection con, PreparedStatement pstmt, ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public List<files> selectAll() {
		List<files> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";	
		try {
			con = getConnection();
			sql = "SELECT * FROM files ORDER BY filename ASC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery(); 
			while (rs.next()) { 
				files loc = new files();
				loc.setFileName(rs.getString("filname"));
				loc.setContents(rs.getString("content"));
				list.add(loc);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeJDBC(con, pstmt, rs);
		}
		return list;
	}
	
	public int insert(files files) {
		int rowCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = getConnection();
			sql = "INSERT INTO files (filename, content) VALUES (?, ?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, files.getFileName());
			pstmt.setString(2, files.getContents());
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeJDBC(con, pstmt, null);
		}
		return rowCount;
	}
	
	public int filename(String filename) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = getConnection();
			sql = "SELECT COUNT(*) AS cnt FROM files WHERE filename = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, filename);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeJDBC(con, pstmt, rs);
		}
		return count;
	}
	
	public int updateByfilename(files filename) {
		int rowCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = getConnection();
			sql = "UPDATE sample SET content = ? WHERE filename = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, filename.getContents());
			pstmt.setString(2, filename.getFileName());
			rowCount = pstmt.executeUpdate(); // ½ÇÇà
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeJDBC(con, pstmt, null);
		}
		return rowCount;
	}
	
	public int deleteByfileName(String filename) {
		int rowCount = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = getConnection();
			sql = "DELETE FROM files WHERE filename = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, filename);
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeJDBC(con, pstmt, null);
		}
		return rowCount;
	}
}