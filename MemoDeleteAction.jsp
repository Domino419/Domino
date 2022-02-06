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

     	if (userID == null) {
     		PrintWriter script = response.getWriter();
     		script.println("<script>");
     		script.println("alert('게시글을 수정하려면 로그인이 필요합니다.')");
     		script.println("location.href = 'login.jsp'");
     		script.println("</script>");
     	}
     	int MemoID = 0; // 존재하는 글이면 글 번호를 가져오기  
     	if (request.getParameter("memoID") != null) ;
     	{
     		MemoID = Integer.parseInt(request.getParameter("memoID"));
     	}

     	if (MemoID == 0) {
     		PrintWriter script = response.getWriter();
     		script.println("<script>");
     		script.println("alert('존재하지 않는 글입니다.')"); // 경고창 띄우고 
     		script.println("location.href = 'Memo.jsp'"); // 게시판 페이지로 보냄
     		script.println("</script>");
     	}
     	   MemoDao Memo = new MemoDao() ;
     	if (!userID.equals(Memo.getMemo(MemoID))) { // 접속자와 작성자가 다르면 
     			PrintWriter script = response.getWriter();
     			script.println("<script>");
     			script.println("alert('권한이 없습니다.')"); // 권한 없음 경고창
     			script.println("location.href = 'Memo.jsp'"); // 게시판 페이지로 보냄
     			script.println("</script>"); 	} 
 
     	MemoDao MemoDao = new MemoDao();
     	int result = MemoDao.mdelete(MemoID);
     	if (result == -1) {
     		PrintWriter script = response.getWriter();
     		script.println("<script>");
     		script.println("alert('게시글 삭제에 실패했습니다.')");
     		script.println("history.back()");
     		script.println("</script>");
     	} else {
     		PrintWriter script = response.getWriter();
     		script.println("<script>");
     		script.println("alert('게시글이 삭제되었습니다.')");
     		script.println("location.href = 'Memo.jsp'"); // 게시글을 수정했으므로 게시판 페이지로 이동
     		script.println("</script>");
     	}
     	
     		
     %>
</body>
</html> 
