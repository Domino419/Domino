<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="Todo.TodoDao" %>
<%@ page import="Todo.TodoDto" %>
<%@ page import="java.io.PrintWriter" %> 
 
<!DOCTYPE html>
<html>
<head>
<!-- 한글이 깨지면 제일 먼저 확인할 곳은 meta tag -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP게시판 웹사이트</title>
</head>
<body>
    <%  // 
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	if (userID == null) { 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('게시글을 수정하려면 로그인이 필요합니다.')"); 
		script.println("location.href = 'login.jsp'"); 
		script.println("</script>");			
	} 		
	/* int todoID = 0 ; // 존재하는 글이면 글 번호를 가져오기  
	if (request.getParameter("todoID") != null) ;   {
		todoID = Integer.parseInt(request.getParameter("todoID"));
	} */
	
	/* if (todoID == 0) { 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 글입니다.')"); // 경고창 띄우고 
		script.println("location.href = 'Memo.jsp'"); // 게시판 페이지로 보냄
		script.println("</script>");
	} */

			TodoDao TodoDto = new TodoDao(); 
			int result = TodoDto.write(request.getParameter("todotitle"), userID, request.getParameter("todocontent"));
			if (result == -1) { 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('게시글 수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else { 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('게시글이 작성되었습니다.')");
				script.println("windows.close()");
				//script.println("location.href = 'Todo.jsp'"); // 게시글을 수정했으므로 게시판 페이지로 이동
				script.println("</script>");
			} 
		//}
	//}
%>
         

</body>
</html> 
