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
	
	String sql = "select * from INSAMAIN";%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일자별 근무율 확인  </title>
</head>
<body>
   <!--   <input type="button" value="새창" onclick="window.open('popup1.jsp', '팝업창 이름', 'width=#, height=#')">  --> 
     
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
	 <!--  <form action="http://localhost/color.php">
            <h1>일자별 근무일 확인</h1>
            <select name="color">
                <option value="red">레드</option>
                <option value="blue">블루</option>
                <option value="black">블랙</option>
            </select>
            <input type="submit">
          </form> -->
        <form> <input type='date' id='currentDate'/></form>  
        <script>  document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);;</script>
        
        <br> </br>
        <br> table 2 join & group by having .. 근데 값이 안 나옴.. <br>
        <br>query 성공하면 화면 구현 마무리 할 거 / 아직 dao 페이지 안 나눠놓음..<br>
        
        </table>
        
          
    </html>
	<table border="1">
		<tr>
			<td>부서1</td>
			<td>부서2</td>
			<td>재직자수</td>
			<td>근무자수</td>
			<td>근무비중</td>
			<td>연차</td>
			<td>반차</td>
		</tr>
		<%
			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getString(2)%></td>
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