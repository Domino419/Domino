<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="/css/bootstrap.css"> <!-- 참조  -->
<title>My web site</title>
</head>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
<!-- 	
	<script>
	const str = document.location.href;
	const words = str.split("/"); 
	words[2]= 'localhost:7877' ? document.write ("개발계") : document.write ("운영계") ;
    </script>
 -->
	
	<H2>개발환경 </H2>
	<h5>- DB : Oracle 11g </h5>
	<h5>- WAS : Tomcat v9.0, </h5>
	<h5>- Client : Bootstrap </h5>
	<h2>프로젝트 도구 </h2>
	<h5>- Tools : Oracle SQL Developer, SVN, Eclipse </h5>
	<h5>- Language : Java, JSP, JavaScript</h5>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>