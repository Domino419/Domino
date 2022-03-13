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
	
	String sql = "select NUM, Substr(NAME,1,1)||lpad('*',length(NAME)-2,'*')||Substr(NAME,length(name),1), to_DATE(INDATE,'YYYY/MM/DD'), To_DATE(OUTDATE,'YYYY/MM/DD'), DEPT1, DEPT2 FROM INSAMAIN";%>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"
	name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>My web site</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
</head>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
	<!--  - <input type="button" value="새창" onclick="window.open('popup1.jsp', '팝업창 이름', 'width=#, height=#')">  -->
	<!--  <button onclick="history.back()">뒤로 돌아가기</button> -->
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
	<center>
		<H4>사원 명부(더미데이터)</H4>

		<table border="1">
			<tr>
				<td>사번</td>
				<td>이름</td>
				<td>입사일</td>
				<td>퇴사일</td>
				<td>소속1</td>
				<td>소속2</td>
			</tr>
			<%
			while (rs.next()) {
		%>
			<tr>
				<td><%=rs.getString(1)%></td>
				<td><%=rs.getString(2)%></td>
				<td><%=rs.getString(3).substring(0, 9)%></td>
				<td><%=rs.getString(4).substring(0, 9)%></td>
				<td><%=rs.getString(5)%></td>
				<td><%=rs.getString(6)%></td>
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

		<div class="container">
			<div class="row">
				<div class="col text-center" style="text-align: center">
					<input type="button" button class="btn btn-default" value="창닫기"
						onclick="window.close();">
				</div>
			</div>
		</div>


<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/js/bootstrap.js"></script>
</body>

</html>