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
	
	String sql =  "SELECT A.NUM, A.NAME, B.MON,to_DATE(INDATE,'YYYY/MM/DD'), DECODE (B.MON, 3, '수습직→계약직1',12, '계약직1→계약직2',24, '계약직2→무기계약직'),to_DATE(outdate,'YYYY/MM/DD') \r\n"
		    + "FROM INSAMAIN A, (SELECT NUM, NAME, TRUNC(MONTHS_BETWEEN(SYSDATE,b.INDATE),0) AS MON FROM INSAMAIN b )B \r\n"
			+ "WHERE A.NUM = B.NUM\r\n"
			+ "AND B.MON IN (3,12,24)  \r\n"
			+ "AND A.OUTDATE > SYSDATE ORDER BY INDATE DESC"; %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">

<head>
	<center>
<title>부서별 근무 비중 확인  </title>
</head>
    <jsp:include page="/header.jsp"></jsp:include>
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
	 
	    <H4>ㅁ고용전환 예정자 확인ㅁ</H4>
	  <div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                <thead>
                    <tr>
                        <th style="background-color:#eeeeee; text-align:center;">사번</th>
                        <th style="background-color:#eeeeee; text-align:center;">이름</th>
                        <th style="background-color:#eeeeee; text-align:center;">입사일</th>
                        <th style="background-color:#eeeeee; text-align:center;">끈속개월</th>
                        <th style="background-color:#eeeeee; text-align:center;">현고용형태 → 전환후고용형태</th>
                      <!--   <th style="background-color:#eeeeee; text-align:center;">전환예정일</th>
                        <th style="background-color:#eeeeee; text-align:center;">전환예정일</th> -->
                    </tr>
                </thead>
                  <tbody>
                  
		<%
			while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString(1)%></td>  
			<td><%=rs.getString(2)%></td>  
			<td><%=rs.getString(4).substring(0, 9)%></td>
			<td><%=rs.getString(3)%></td>
			<td><%=rs.getString(5)%></td>
	
		<%-- 	<td><%=rs.getString(6).substring(0, 9)%></td> --%>
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
	<h6>  <p align="left">※ 고용전환 예정자 : 당일 기준으로 재직 중인 사람 중 근속개월이 3개월, 12개월, 24개월인 경우  </p></h6>
	<h6>  <p align="left">※ 근속개월 계산식 = MONTHS_BETWEEN(SYSDATE,INDATE)  </p></h6>

			<!-- <div class="container">
				<div class="row">
					<div class="col text-center" style="text-align:center"> 
						<input type="button" button class="btn btn-default"  value="창닫기" onclick="window.close();">
						</div></div> </div> -->

			<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
			<script src="/js/bootstrap.js"></script></body>	
					
</html>