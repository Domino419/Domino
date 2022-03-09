<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String name="";
	String value="";
	String cookie = request.getHeader("Cookie");  // 쿠키가 생성됬는지 여부 확인 
	
	if(cookie!=null){
		Cookie cookies[]=request.getCookies();     // 쿠키가 null이 아닌지 확인 
		
		for(int i=0;i<cookies.length;i++){                       // 쿠키 배열에 담긴 객체들을 for문으로 꺼내서 
			if(cookies[i].getName().equals("name")){             // 이름이 맞는지 확인하고   
				name=cookies[i].getName();                       // 배열에 담아준다 
				value=cookies[i].getValue();
			}
		}
	}
%>
<html>
<head>
<title>Cookie Test</title>
</head>
<body>
<h2>쿠키 이름 = <%=name %></h2>
<h2>쿠키 값 = <%=value %></h2>
</body>
</html>
