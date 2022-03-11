<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>    
<%@ page import="BBS.BBS" %>  
<%@ page import="BBS.BbsDAO" %>  
<%@ page import="java.sql.*" %>  

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width">  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조  -->
<title>My web site</title>
</head>
<body>
<body>
<% request.setCharacterEncoding("UTF-8"); %>    

<%
    String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");  
	}

    if (userID == null)
    {
       PrintWriter script = response.getWriter();
       script.println("<script>");
       script.println("alert('로그인을 하세요')");
       script.println("location.href = 'login.jsp'");
       script.println("</script>");
   }
   int bbsID = 0;
   if (request.getParameter("bbsID") != null)
   {
       bbsID = Integer.parseInt(request.getParameter("bbsID"));
   }
   if (bbsID == 0)
   {
       PrintWriter script = response.getWriter();
       script.println("<script>");
       script.println("alert('유효하지 않은 글입니다')");
       script.println("location.href = 'bbs.jsp'");
       script.println("</script>");
   }
   BBS Bbs = new BbsDAO().getBbs(bbsID) ;
   if (!userID.equals(Bbs.getUserID()))
   {
       PrintWriter script = response.getWriter();
       script.println("<script>");
       script.println("alert('권한이 없습니다')");
       script.println("location.href = 'bbs.jsp'");
       script.println("</script>");
   }
   
   
   
    %>
    <nav class ="navbar navbar-default">
        <div class="navbar-header"> <!-- 홈페이지의 로고 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span> 
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">게시판</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li class="active"><a href="bbs.jsp">게시판</a></li>
                <li><a href="CalendarTable.jsp">달력</a></li>
                <li><a href="InsaTable.jsp">인사관리</a></li>
                <li><a href="RsTable.jsp">성과관리</a></li>
                <li><a href="DsbTable.jsp">자재관리</a></li>
                <li><a href="Memo.jsp">MEMO</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">회원관리<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="logoutAction.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    <div class="container">
        <div class="row">
           <form method="post" action="updateAction.jsp?=<%="Bbsid"%>">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd"><thead><tr>
                        <th colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글수정 양식</th></tr>
                </thead>
                      <tbody>
                                    <tr>
                    <td><input type="text" class="form-control" placeholder="아이디"  name="bbsID" maxlength="50" value = "<%=Bbs.getBbsid() %>"></td>
                    </tr>
                    <tr>
                    <td><input type="text" class="form-control" placeholder="글 제목"  name="bbstitle" maxlength="50" value = "<%=Bbs.getBbstitle() %>"></td>
                    </tr>
                    <tr>
                    <td><textarea class="form-control" placeholder="글 내용"  name="bbscontent" maxlength="2048" style="height:350px;"><%=Bbs.getBbscontent()%></textarea></td>
                    </tr>
                </tbody>
            </table>
                <input type="submit"  class="btn btn-primary pull-right" value="글수정">
            </form>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>