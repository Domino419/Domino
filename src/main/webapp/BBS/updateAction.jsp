<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="BBS.BbsDAO" %>
<%@ page import="BBS.BBS" %>
<%@ page import="java.io.PrintWriter" %> 
 
<!DOCTYPE html>
<html>
<head>
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
		script.println("location.href = '../login.jsp'"); 
		script.println("</script>");			
	} 		
	int bbsID = 0 ; // 존재하는 글이면 글 번호를 가져오기  
	if (request.getParameter("bbsID") != null) ;   {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	
	if (bbsID == 0) { 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 글입니다.')"); // 경고창 띄우고 
		script.println("location.href = '/BBS/bbs.jsp'"); // 게시판 페이지로 보냄
		script.println("</script>");
	}
	BBS bbs = new BbsDAO().getBbs(bbsID);
	if (!userID.equals(bbs.getUserID())) { // 접속자와 작성자가 다르면 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')"); // 글 수정 권한 없음 
		script.println("location.href = '/BBS/bbs.jsp'"); // 게시판 페이지로 보냄
		script.println("</script>");
	} else {
/* 		if (request.getParameter("bbstitle") == null || request.getParameter("bbscontent") == null ||
			request.getParameter("bbstitle").equals("") || request.getParameter("bbscontent").equals("")) { 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')"); 
			script.println("</script>");
		} else { */
			BbsDAO bbsDAO = new BbsDAO(); 
			int result = bbsDAO.update(bbsID, request.getParameter("bbstitle"), request.getParameter("bbscontent"));
			if (result == -1) { 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('게시글 수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else { 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('게시글이 수정되었습니다.')");
				//script.println("location.href = 'bbs.jsp'"); // 게시글을 수정했으므로 게시판 페이지로 이동
				script.println("history.go(-3)");
				script.println("</script>");
			} 
		//}
	}
%>
         
    %>
</body>
</html> 
