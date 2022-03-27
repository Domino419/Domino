<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="BBS.BBS" %>
<%@ page import="BBS.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="../css/bootstrap.css"> <!-- 참조  -->
<title>My web site</title>
</head>
<body>
<jsp:include page="/contents/header.jsp"></jsp:include>
<%
    String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
    if (session.getAttribute("userID") != null)
    {
        userID = (String)session.getAttribute("userID");  //Hppt 세션 
    }
    int bbsID = 0;
    if (request.getParameter("Bbsid") != null)
    {
        bbsID = Integer.parseInt(request.getParameter("Bbsid"));
    }
    if (bbsID == 0)
    {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    }
    BBS bbs = new BbsDAO().getBbs(bbsID);
%>
   
    <div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                <thead>
                    <tr>
                        <th colspan="3" style="background-color:#eeeeee; text-align:center;">게시판 글 보기</th>
 
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="width:20%;">글 제목</td>
                        <td colspan="2"><%= bbs.getBbstitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
                    </tr>
                    <tr>
                        <td>작성자</td>
                 <td colspan="2"><%= bbs.getUserID().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
                    </tr>
                   <tr>
                        <td>작성일자</td>
                        <td colspan="2"><%= bbs.getBbsdate().substring(0,11) + bbs.getBbsdate().substring(11, 13) + "시" 
                                + bbs.getBbsdate().substring(14,16) + "분"  %></td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td colspan="2" style="min-height:200px; text-align:left;">
                        <!-- 특수문자 & 악성 스크립트 방지용  -->
                        <%= bbs.getBbscontent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>    
                    </tr>
                </tbody>
            </table>
            <a href="/BBS/bbs.jsp" class="btn btn-primary">목록</a>
            <%
               // if(userID != null && userID.equals(bbs.getUserID()))  // 여기서 걸리나..?
                {
            %>
                <a href="/BBS/update.jsp?bbsID=<%=(Integer.parseInt(request.getParameter("Bbsid")))%>" class="btn btn-primary">수정</a>
                <a href="/BBS/deleteAction.jsp?bbsID=<%=(Integer.parseInt(request.getParameter("Bbsid")))%>" class="btn btn-primary" onclick="return confirm('진짜 삭제해도 될까요?');">삭제</a>
                
            <%     
                }
            %>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="../js/bootstrap.js"></script></body>
</body>
</html>
