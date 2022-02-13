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
	String sql = "SELECT ID, ISBN, TITLE, Writer, Publish, page, price, Pday, memo, Gubun FROM BOOK";%>
	

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
 <%    //이거 지워도 될 거 같은데...
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
    <nav class ="navbar navbar-default">
        <div class="navbar-header"> <!-- 홈페이지의 로고 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">   <!-- nav bat menu list  -->
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li><a href="bbs.jsp">게시판</a></li>
                <li><a href="CalendarTable.jsp">달력</a></li>   <!-- 0122 메뉴 추가 -->
                <li><a href="InsaTable.jsp">인사관리</a></li>
                <li><a href="RsTable.jsp">성과관리</a></li>
                <li class="active"><a href="DsbTable.jsp">도서관리</a></li>
                  <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                        <a href="#" class = "dropdown-toggle"
                            data-toggle="dropdown" role ="button" aria-haspopup="true"
                            aria-expanded="false">Project history <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="Memo.jsp">작업일지</li></a>
                                <li><a href="Todo.jsp">To do list </li></a>
                            </ul>
                        </li>
                    </ul>
            </ul>
            <%
            // 접속하기는 로그인이 되어있지 않은 경우만 나오게한다
                if(userID == null)
                {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>                    
                    </ul>
                </li>
            </ul>
            <%
                } else {
             %>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                        <a href="#" class = "dropdown-toggle"
                            data-toggle="dropdown" role ="button" aria-haspopup="true"
                            aria-expanded="false">회원관리<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="logoutAction.jsp">로그아웃</a></li>
                            </ul>
                        </li>
                    </ul>
                    <%
                        }
                    %>
                </div>
            </nav>
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
			<td><%=rs.getString(10)%></td>
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