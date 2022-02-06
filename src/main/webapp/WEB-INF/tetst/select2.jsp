<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%!// 변수 선언
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String uid = "web_user";
	String pwd = "pass";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String sql = "select * from files";%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CONSOLE로 오라클 DB 가져오기 </title>
</head>
<body>
	<%
		try { // 데이터베이스를 접속하기 위한 드라이버 SW 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");// 데이터베이스에 연결하는 작업 수행
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","web_user","pass");		// 쿼리를 생성gkf 객체 생성
		stmt = conn.createStatement();		// 쿼리 생성
		rs = stmt.executeQuery(sql);
		
		while (rs.next()) {
			System.out.println(rs.getNString("filename"));
			System.out.println(rs.getNString("content"));
			System.out.println();
		}
		
		
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (rs != null) {
		rs.close();
			}
			if (stmt != null) {
		stmt.close();
			}
			if (conn != null) {
		conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	%>
</body>
</html>	
