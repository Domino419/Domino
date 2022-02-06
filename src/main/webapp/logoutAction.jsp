<%@page import="java.io.PrintWriter"%>
<%@page import="User.UserDao"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="user" scope="application" class="User.User" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<</head>
<body>
	<%
		session.invalidate(); // 로그아웃 (세션 빼앗음)
	%>
	<script>
		alert('로그아웃 되었습니다.');
		location.href = "main.jsp";
	</script>
</body>
</html>