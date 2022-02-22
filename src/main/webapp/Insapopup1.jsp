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
	
	String sql = "SELECT A.dept1, NVL(A.dept2, '총합계'), COUNT(NUM) FROM insamain A  WHERE A.OUTDATE > '21/12/01' GROUP BY ROLLUP ( A.dept1,A.dept2 )";%>
	
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
         
          <!-- form 부분에서 날짜값을 받아오는 파라미터 CheckDate --> 
          
         <!--  <form> <input type='date' id='CheckDate'/></form>  
        <script>  document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);;</script>
         -->
        </table>
        
          
    </html>
	<table border="1">
		  <!--  <td colspan = "4"></td> -->
			<td>부서1</td>
			<td>부서2</td>
			<td>재직자수</td>
			<td>근무자수</td>
			<td>근무비중</td>
		

		</tr>
		<%
			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString(1)%></td>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getString(3)%></td>
			<td><%=rs.getString(3)%></td>
			<td><%=rs.getString(3)%></td>
			

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