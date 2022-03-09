<!--error.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ page errorPage="/ETC/error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>파라미터</title>
</head>
<body>
	name 파라미터 :
	<%=request.getParameter("name").toUpperCase()%>
</body>
</html>
