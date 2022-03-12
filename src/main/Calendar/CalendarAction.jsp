<%@page import="java.io.PrintWriter"%>
<%@page import="Tableocl.Calendar"%>
<%@page import="Tableocl.CalendarDao"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="Tableocl" scope="page" class="Tableocl.Calendar" />
<jsp:setProperty name="Tableocl" property="memoYear" />
<jsp:setProperty name="Tableocl" property="memoMonth" />
<jsp:setProperty name="Tableocl" property="memoDay" />
<jsp:setProperty name="Tableocl" property="memoContents" />

<!DOCTYPE html>
<html>
<head> 
 <!-- 한글이 깨지면 제일 먼저 확인할 곳은 meta tag -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body> 
	<% 
    String userID = null;
      if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
     }

	
   if(userID == null)   
       {
       PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
       
   
    } else {
	  if (Tableocl.getMemoYear() == null || Tableocl.getMemoMonth() == null|| Tableocl.getMemoDay() == null|| Tableocl.getMemoContents() == null) { // 공란 있음
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')"); // 경고창 띄움
		script.println("history.back()"); // 이전 페이지로 돌려보냄
		script.println("</script>");
    	} else {
    	CalendarDao CalendarDao = new CalendarDao( ); // 객체 생성 
		//int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
		int result = CalendarDao.write(Tableocl.getMemoYear(), Tableocl.getMemoMonth(), Tableocl.getMemoDay(), Tableocl.getMemoContents());
		if (result == -1) { // 데이터베이스 오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시글 작성에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else { // 게시글 작성 성공
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('일정이 등록되었습니다.')");
			script.println("location.href = 'CalendarTable.jsp'"); // 게시글을 등록했으므로 게시판 페이지로 이동
			script.println("</script>");
		} 
	}
}

   
   

	%>
</body>
</html>