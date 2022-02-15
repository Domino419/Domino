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
<body> 

	 <% 
		if(user.getUserID() == null || user.getUserPassword() == null ) 
		{
	      PrintWriter script = response.getWriter();
	      script.println("<script>");
	      script.println("alert('입력이 안된 사항이 있습니다.1')");
	      script.println("history.back()");
	      script.println("</script>");
	    }
		
		else if(user.getUserName() == null || user.getUserEmail() == null)
	    {
		      PrintWriter script = response.getWriter();
		      script.println("<script>");
		      script.println("alert('입력이 안된 사항이 있습니다.2')");
		      script.println("history.back()");
		      script.println("</script>");
		}
	    
		else
		{
	    UserDao user1 = new UserDao(); 
	    
	   // int result = UserDao.join(user);
	   int result = user1.join(user);     //user 똑같이 선언하면 에러나서 숫자 1 덧붘임
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('가입완료되었습니다.')");
			script.println("history.back()");   
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		 }
	    } 
	%>
</body>
</html>