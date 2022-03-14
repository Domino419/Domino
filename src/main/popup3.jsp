<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 쿠키값으로 id정보 받아오기 -->
	<%String cookie = "";
		Cookie[] cookies = request.getCookies(); //쿠키생성
		if(cookies !=null&& cookies.length > 0)
		for (int i = 0; i < cookies.length; i++){
			if (cookies[i].getName().equals("userId")) { // 내가 원하는 쿠키명 찾아서 값 저장
				cookie = cookies[i].getValue();}}%>
<%-- 	<form action="/LoginAction" method=post>
		id:<input name="id" type=text value="<%=cookie%>"
			placeholder="your id."><br> pwd:<input name="pwd"
			type=password value="" placeholder="your password."><br> --%>
		<input name="checkbox" type=checkbox> id 기억하기 <br> 
	<!-- 	<inputtype=submit value="Login" -->>
	</form>
</body>
</html>