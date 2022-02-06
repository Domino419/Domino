<%@page import="java.io.PrintWriter"%>
<%@page import="User.UserDao"%>  
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>   
<jsp:useBean id="user" scope="page" class="User.User" />  <!-- javaBean으로 쓸 거 -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />   <!-- loginp에서 넘어온 정보를 setproperty-->


<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body> 
	<%
	    String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	/* 
	if (userID == null) { // 로그아웃 -> 로그인 페이지로 이동
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('게시글을 작성하려면 로그인이 필요합니다.')"); 
		script.println("location.href = 'login.jsp'"); 
		script.println("</script>");	
	 */
	
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어 있습니다.')"); 
	  	script.println("location.href = 'main.jsp'"); 
	  	script.println("</script>");
	    }
	
	
		UserDao UserDao = new UserDao(); 
	    int result = UserDao.login(user.getUserID(), user.getUserPassword());
	    
		if(result == 1){
			session.setAttribute("userID", user.getUserID());  //로그인 성공하면 세션값 부여 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 성공')");
			script.println("location.href='main.jsp'");   
			script.println("</script>");
			
			
		}else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다')");
			script.println("history.back()");
			script.println("</script>"); 
			
			
			
		}else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다')");
			script.println("history.back()");
			script.println("</script>");
			
			
		}else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류입니다')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>   
</body>
</html>