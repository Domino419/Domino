<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Book.BookDao" %>
<%@ page import="Book.BookDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.DriverManager"%>


<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String uid = "web_user";
	String pwd = "pass";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String sql = "select ID, ISBN, TITLE,REPLACE(Writer, '(지은이)', ''), Publish, Gubun from (select ID, ISBN, TITLE,Writer, Publish, Gubun from BOOK order by DBMS_RANDOM.RANDOM ) ";%>

	<!-- "SELECT ID, ISBN, TITLE,REPLACE(Writer, '(지은이)', ''), Publish, Gubun FROM BOOK"; Db 랜덤 기능 구현 전 쿼리-->

<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1" > 
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
<style type = "text/css">
    a, a:hover
    {
        color: #000000;
        text-decoration: none;
    }
</style>
</head>
<body>
 <jsp:include page="/header.jsp"></jsp:include>
 <%    
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	   }
		try { // 데이터베이스를 접속하기 위한 드라이버 SW 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");// 데이터베이스에 연결하는 작업 수행
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE","web_user","pass");		// 쿼리를 생성gkf 객체 생성
		stmt = conn.createStatement();		// 쿼리 생성
		rs = stmt.executeQuery(sql);
		
		int pageNumber = 1;  
	    if (request.getParameter("pageNumber") != null)
	    {
	        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	    }  
	    
	%>
    
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
			     	<div style="width: 30%; float:none; margin:0 auto" >
				     <a href="SorryPage.jsp" class="btn btn-primary pull-right">제목으로 검색하기 </a> 
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">ISBN</th> 
						<th style="background-color: #eeeeee; text-align: center;">제목</th>  
						<th style="background-color: #eeeeee; text-align: center;">저자</th>
						<th style="background-color: #eeeeee; text-align: center;">출판사</th>
						<th style="background-color: #eeeeee; text-align: center;">장르구분</th>
					</tr>
				</thead>
				<tbody>
					<!-- 게시판 루트 바꿀 부분  -->
					<%
			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getString(3)%></td>
			<td><%=rs.getString(4)%></td>
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
		</tbody>
			</table>
			<a href="SorryPage.jsp" class="btn btn-primary pull-right">글쓰기 검색하기로 바꿜 거 </a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>