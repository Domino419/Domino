<%@page import="java.io.PrintWriter"%>
<%@page import="BBS.Memo"%>
<%@page import="BBS.MemoDao"%>

<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<jsp:useBean id="Memo" scope="page" class="BBS.Memo" />
<jsp:setProperty name="Memo" property="data" />
<jsp:setProperty name="Memo" property="workcoment" />
<jsp:setProperty name="Memo" property="coment" />

     <!-- MemoWrite에서 쓴  input값
       <td><input type="text" class="form-control" placeholder="작업일" value="입력양식 : YYYYMMDD "style="color:blue" name="Data" maxlength="50" ></td>
       <input type="text" class="form-control" placeholder="글 제목"  name="WorkComent" maxlength="50" ></td>
       <textarea class="form-control" placeholder="글 내용"  name="Coment" maxlength="2048" style="height:350px" ></textarea></td>
 
 <!-- 한글이 깨지면 제일 먼저 확인할 곳은 meta tag -->
 
<!DOCTYPE html>
<html>
<head>  
 
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
       
      //로그인을 했는지를 보고 , 공란이 있는지를 보고.. 
    } else {
	  if (Memo.getData() == null || Memo.getWorkcoment() == null  || Memo.getComent() == null) { // 공란 있음
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')"); // 경고창 띄움
		script.println("history.back()"); // 이전 페이지로 돌려보냄
		script.println("</script>");
    	} else {
    
    	// 공란이 없으면 글 등록 진행 - 	
        MemoDao MemoDao = new MemoDao() ; 
		int result = MemoDao.mwrite(Memo.getWorkcoment(), Memo.getUserID(),Memo.getComent());
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