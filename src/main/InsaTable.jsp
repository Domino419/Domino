<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조  -->
<title>JSP 게시판 웹 사이트</title>
</head>

<body>
<jsp:include page="/header.jsp"></jsp:include>
<%
     String userID = null;
     if (session.getAttribute("userID") != null) {
	 userID = (String) session.getAttribute("userID");
      }
%>
	<div align="center">
		<section>
			<br> <a href="#"
				onclick="window.open('http://localhost:7877/Insapopup1.jsp','window팝업','width=300, height=300, menubar=no, status=yes, toolbar=yes');">당일근무율 확인 </a><br> <br> <a href="#"
				onclick="window.open('http://localhost:7877/Insapopup2.jsp','window팝업','width=300, height=300, menubar=no, status=yes, toolbar=yes');">직원명단 확인 및 수정</a> <br> <br> <a href="#"
				onclick="window.open('http://localhost:7877/Insapopup3.jsp','window팝업','width=300, height=300, menubar=no, status=yes, toolbar=yes');">고용전환예정자 확인</a> <br> <br> <a href="#"
				onclick="window.open('http://localhost:7877/popup3.jsp','window팝업','width=300, height=300, menubar=no, status=yes, toolbar=yes');">파일업로드</a> <br> <br>
		</section>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    
</body>
</html>


     