<%@page import="java.io.PrintWriter"%>
<%@page import="User.UserDao"%>  
<%@page import="User.UserVO"%>  

<%@page import="javax.servlet.RequestDispatcher"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet"%>
<%@page import="javax.servlet.http.Cookie"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>


<%@page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>   
<jsp:useBean id="user" scope="page" class="User.User" />  <!-- javaBean으로 쓸 거 -->
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />   <!-- login에서 넘어온 정보를 받아오기-->
<% String checkbox = request.getParameter("checkbox");%> <!--  체크박스의 체크여부 받아오기. -->


<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body> 


	<%
	    String userID = null;
		Cookie cookie;
		//cookie = new Cookie("userId", "1234");
	    cookie = new Cookie("userId", user.getUserID());   // 쿠키를 생성 
		//cookie.setMaxAge(60*60*24);
		//response.addCookie(cookie);
		if (checkbox != null) { // 체크박스 체크여부에 따라 쿠키 저장 확인 
			// 체크박스 체크 되었을 때
			// 쿠키 저장
			cookie.setMaxAge(60*60*24);
			response.addCookie(cookie);
		} else {
			// 체크박스 체크 해제되었을 때
			// 쿠키 유효시간 0으로 해서 브라우저에서 삭제하게 한다.
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
	    
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");		
	}
	
	
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