<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="css/favicon.ico" type="image/x-icon" sizes="16x16">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="css/bootstrap.js"> <!-- 참조  -->
<title>My web site</title>
</head>
<body>
<%
    String userID = null; 
    if (session.getAttribute("userID") != null)
    {userID = (String)session.getAttribute("userID");}
  
%>

    <nav class ="navbar navbar-default">
        <div class="navbar-header"> <!-- 홈페이지의 로고 -->
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <span class ="icon-bar"></span> <!-- 줄였을때 옆에 짝대기 -->
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
          
            <a class ="navbar-brand" href="main.jsp">Domino4019</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">   <!-- nav bat menu list  -->
            <ul class="nav navbar-nav">
                <li><a href="/<%=application.getContextPath()%>/main.jsp">메인</a></li>
                <li><a href="<%=application.getContextPath()%>/BBS/bbs.jsp">게시판</a></li>
                <li><a href="<%=application.getContextPath()%>/CalendarTable.jsp">달력</a></li>   <!-- 0122 메뉴 추가 -->
                  <li class="dropdown">
                        <a href="#" class = "dropdown-toggle"
                            data-toggle="dropdown" role ="button" aria-haspopup="true"
                            aria-expanded="false">인사관리 <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="/Insapopup1.jsp">당일근무율</li></a>
                                <li><a href="/Insapopup2.jsp">사원명부(더미데이터)  </li></a>
                                 <li><a href="/Insapopup3.jsp">고용전환</li></a>
                                  </ul>
                
                <li><a href="<%=application.getContextPath()%>/RsTable.jsp">자료실</a></li>
                <li><a href="<%=application.getContextPath()%>/DsbTable.jsp">도서관리</a></li>
                    <li class="dropdown">
                        <a href="#" class = "dropdown-toggle"
                            data-toggle="dropdown" role ="button" aria-haspopup="true"
                            aria-expanded="false">Project history <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="Memo.jsp">작업일지</li></a>
                                <li><a href="Todo.jsp">To do list </li></a>
                                  </ul>
                        </li>
                    </ul>
            <%
            // 접속하기는 로그인이 되어있지 않은 경우만 나오게한다
                if(userID == null)
                {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="<%=application.getContextPath()%>/login.jsp">로그인</a></li>
                        <li><a href="<%=application.getContextPath()%>/join.jsp">회원가입</a></li>                    
                    </ul>
                </li>
            </ul>
             <%
                } else if(userID == "4019") {
             %>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                        <a href="#" class = "dropdown-toggle"
                            data-toggle="dropdown" role ="button" aria-haspopup="true"
                            aria-expanded="false">회원관리<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="<%=application.getContextPath()%>/user/Sorrypage.jsp">회원삭제</a></li>
                                <li><a href="logoutAction.jsp">로그아웃</a></li>
                            </ul>
                        </li>
                    </ul>
              <%  }else{
             %>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                        <a href="#" class = "dropdown-toggle"
                            data-toggle="dropdown" role ="button" aria-haspopup="true"
                            aria-expanded="false">회원관리<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="<%=application.getContextPath()%>/user/logoutAction.jsp">로그아웃</a></li>
                            </ul>
                        </li>
                    </ul>
                    <%
                        }
                    %>
                </div>
            </nav>
    <div class="container">
        <div class="row">
            <table class="table table-striped" style="; border:3px solid #dddddd">
            </table>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="/css/bootstrap.js"></script>
</body>
</html>
