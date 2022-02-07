<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="BBS.MemoDao" %>
<%@ page import="BBS.Memo" %>
<%@ page import="java.io.PrintWriter" %> 

<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 파일을 UTF-8로 -->
 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP게시판 웹사이트</title>
</head>
<body>
     <% // project history 
     	String userID = null;
     	if (session.getAttribute("userID") != null) {
     		userID = (String) session.getAttribute("userID");
     	}

     %>
</body>
</html> 
