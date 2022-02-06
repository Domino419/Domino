<%@page import="java.io.PrintWriter"%>
<%@page import="BBS.MemoDao"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="Memo" scope="page" class="BBS.Memo" />
<jsp:setProperty name="Memo" property="workcoment" />
<jsp:setProperty name="Memo" property="coment" />

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
	  if (Memo.getWorkcoment() == null || Memo.getComent() == null){ // 공란 있음
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')"); // 경고창 띄움
		script.println("history.back()"); // 이전 페이지로 돌려보냄
		script.println("</script>");
    	} else {
    		
        MemoDao MemoDao = new MemoDao(); // 공란 없음 -> 게시글 작성
		//int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
		int result = MemoDao.mwrite(Memo.getWorkcoment(), userID ,Memo.getComent());
		if (result == -1) { // 데이터베이스 오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시글 작성에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else { // 게시글 작성 성공
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('게시글이 등록되었습니다.')");
			script.println("location.href = 'Memo.jsp'"); // 게시글을 등록했으므로 게시판 페이지로 이동
			script.println("</script>");
		} 
	}
}

	%>
</body>
</html>
	