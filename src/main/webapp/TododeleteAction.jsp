<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Todo.TodoDao" %>
<%@ page import="Todo.TodoDto" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 파일을 UTF-8로 -->
 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP게시판 웹사이트</title>
</head>
<body>
    <%  // 게시글 수정 기능 구현
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) { // 로그아웃 -> 로그인 페이지로 이동
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시글을 수정하려면 로그인이 필요합니다.')"); 
			script.println("location.href = 'login.jsp'"); 
			script.println("</script>");			
		} 		
		int todoID = 0; // 존재하는 글
		if (request.getParameter("todoID") != null) {
			todoID = Integer.parseInt(request.getParameter("todoID"));
		}
		if (todoID == 0) { // 존재하지 않는 글
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 글입니다.')"); // 경고창 띄우고 
			script.println("location.href = 'Todo.jsp'"); // 게시판 페이지로 보냄
			script.println("</script>");
		}
		TodoDto todo = new TodoDao().gettodo(todoID);
		
		if (!userID.equals(todo.getUserid())) { // 접속자와 작성자가 다르면 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')"); // 글 삭제 권한 없음 
			script.println("location.href = 'Todo.jsp'"); // 게시판 페이지로 보냄
			script.println("</script>");
		} else {
		    	TodoDao TodoDao = new TodoDao(); // 공란 없음 -> 게시글 수정
				int result = TodoDao.delete(todoID);
				if (result == -1) { // 데이터베이스 오류
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('게시글 삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
					
				} else { // 게시글 삭제 성공
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('게시글이 삭제되었습니다.')");
					script.println("location.href ='Todo.jsp'"); // 게시글을 삭제했으므로 게시판 페이지로 이동
					script.println("</script>");
				} 
			}
	%>
</body>
</html> 
