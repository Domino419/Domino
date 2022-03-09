<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Cookie cookie=new Cookie("name","hongkildong");   // 쿠키 객체 생성 
	cookie.setMaxAge(600);     // 쿠키 생존 시간을 600초 (10분) 으로 설정 
	response.addCookie(cookie);  // 생성한 쿠키를 클라이언트로 전송 
%>
<html>
<head>
<title>Cookie Test</title>
</head>
<body>
<h2><%=cookie.getName() %></h2>
<h2><%=cookie.getValue() %></h2>
<h2><%=cookie.getMaxAge() %></h2>
<a href="cookieTest2.jsp">쿠키 값 불러오기</a>
</body>
</html>

