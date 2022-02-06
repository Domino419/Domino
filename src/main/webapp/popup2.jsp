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
	String sql = "select * from projecthistory";%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 고용전환 대상자 확인 (당월분) </title>
<!--<input type="button" value="새창" onclick="window.open('popup1.jsp', '팝업창 이름', 'width=#, height=#')"> -->

</head>
<body>
    <%  // 
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	   }
		try { // 데이터베이스를 접속하기 위한 드라이버 SW 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");// 데이터베이스에 연결하는 작업 수행
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","web_user","pass");		// 쿼리를 생성gkf 객체 생성
		stmt = conn.createStatement();		// 쿼리 생성
		rs = stmt.executeQuery(sql);
	%>
	<table border="1">
		<tr>
			<td>사번</td>
			<td>이름</td>
			<td>입사일</td>
			<td>1인 Dao에서 근속개월별 쿼리문 - case문 연결해서 계1, 계2, 무기 구분해서 명단 list로 만들어서 출력 , 계1,계2,무기 구분해서 cnt 숫자테이블마다 표기 </td>
			<td>2안 Dao에서 그룹바이 해빙으로 묶어내고 테이블 전체로 출력  / 작업은 이게 더 편할 거 같은데... 두개 다 시도해보기  </td>
		</tr>
		<%
			while (rs.next()) {
		%>
		<tr>
		  
		
		
			<td><%=rs.getString("NUM")%></td>
			<td><%=rs.getString("NAME")%></td>
			<td><%=rs.getString("INDATE")%></td>
			
		</tr>


		<%
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
	</table>
</body>
</html>