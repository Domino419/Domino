<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="BBS.BbsDAO" %>
<%@ page import="BBS.BBS" %>
<%@ page import="java.util.ArrayList" %>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"
	name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="js/bootstrap.css">
<title>My web site</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
</head>
<%!// 변수 선언
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String uid = "web_user";
	String pwd = "pass";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	
	String sql =  "select NVL(aa.dept1,'총') 부서1, NVL(aa.dept2,'합계') 부서2, sum(bb.a) 재직자수, sum(bb.a - aa.c - aa.d) 근무자수\r\n"
		    + ",trunc(avg((bb.a-aa.c-aa.d)/bb.a)*100,1) 근무비중  ,sum(aa.c) 연차자, sum(aa.d) 반차자\r\n"
			+ "from\r\n"
			+ "(select a.dept1 dept1, a.dept2 dept2\r\n"
			+ ",count(case when b.time = '반차' then 1 end) c\r\n"
			+ ",count(case when b.time = '연차' then 1 end) d\r\n"
			+ "from insamain a, atntable b\r\n"
			+ "where a.name = b.name\r\n"
			+ "and b.atndate = '21/12/01'\r\n"
			+ "group by a.dept1, a.dept2) aa,\r\n"
			+ "(select dept1 dept1, dept2 dept2, count(case when outdate > '21/12/01' then 1 end) a \r\n"
			+ "from insamain\r\n"
			+ "group by dept1, dept2) bb\r\n"
			+ "where aa.dept1 = bb.dept1\r\n"
			+ "and aa.dept2 = bb.dept2  GROUP BY ROLLUP( aa.dept1 , aa.dept2 ) ORDER By 1,2"; %>
			
<body>
	<jsp:include page="/header.jsp"></jsp:include>
	<script src="js/export.js"></script>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"
	name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">

<head>
<center>
	<title>부서별 근무 비중 확인</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	try { // 데이터베이스를 접속하기 위한 드라이버 SW 로드
		Class.forName("oracle.jdbc.driver.OracleDriver");// 데이터베이스에 연결하는 작업 수행
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "web_user", "pass"); // 쿼리를 생성gkf 객체 생성
		stmt = conn.createStatement(); // 쿼리 생성
		rs = stmt.executeQuery(sql);
	%>

	<H4>ㅁ부서별 근무 비중 계산ㅁ</H4>
	<div class="container">
		<div class="row">
			<p align="right">
				<script type="text/javascript">
					$(document).ready(function() {
						//tooltip 생성
						$(".tooltip_event").tooltip();
					});
				</script>

				<button type="button" align="right" class="tooltip_event" title="Html Table을 엑셀로 변환(Java Script 사용)" onclick="exportTableToCsv('example-table', 'Export example')"> 명단다운받기</button>
			   <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd" id="example-table">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">부서1</th>
						<th style="background-color: #eeeeee; text-align: center;">부서2</th>
						<th style="background-color: #eeeeee; text-align: center;">재직자수</th>
						<th style="background-color: #eeeeee; text-align: center;">근무자수</th>
						<th style="background-color: #eeeeee; text-align: center;">근무비중</th>
						<th style="background-color: #eeeeee; text-align: center;">연차자</th>
						<th style="background-color: #eeeeee; text-align: center;">반차자</th>
					</tr>
				</thead>
				<tbody>

					<%
			while (rs.next()) {
		%>
					<tr>
						<td><%=rs.getString(1)%></td>
						<td><%=rs.getString(2)%></td>
						<td><%=rs.getString(3)%></td>
						<td><%=rs.getString(4)%></td>
						<td><%=rs.getString(5)%></td>
						<!-- 근무 비중은  %표시 따로 붙여줌   -->
						<td><%=rs.getString(6)%></td>
						<td><%=rs.getString(7)%></td>
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
			<h6>
				<p align="left">※ 재직자수 : 재직중인 사람</p>
			</h6>
			<h6>
				<p align="left">※ 근무자수 : 연차/반차 미사용자 (=정상근무자)</p>
			</h6>
			<h6>
				<p align="left">※ 근무비증 : 재직자 중 정상근무한 사원의 비중</p>
			</h6>
			<h6>
				<p align="left">※ 특정 날짜(21/12/08) 기준으로 집계함</p>
			</h6>
			<!-- 
			<div class="container">
				<div class="row">
					<div class="col text-center" style="text-align:center"> 
						<input type="button" button class="btn btn-default"  value="창닫기" onclick="window.close();">
						</div></div> </div>

			<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
			<script src="/js/bootstrap.js"></script></body>	
					 -->

			<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
			<script src="/js/bootstrap.js"></script>
</body>
</html>