<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Todo.TodoDao" %>
<%@ page import="Todo.TodoDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Tableocl.CalendarDao" %>
<%@ page import="Tableocl.Calendar" %>

<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" name="viewport" content="width=device-width" initial-scale="1"  >
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
<style type = "text/css">
    a, a:hover
        color: #000000;
        text-decoration: none;
td {

	width: 50px;
	height: 50px;
	text-align: center;
	font-size: 20px;
	font-family: 굴림;
	border: 2px border-color:#3333FF;
	border : 8px; /*모서리 둥글게*/
}
</style>
</head>
<body>
<%
    String userID = null; 
    if (session.getAttribute("userID") != null)
    {userID = (String)session.getAttribute("userID");}
    
    
    int pageNumber = 1;  
    if (request.getParameter("pageNumber") != null)
    {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    }
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
            <a class ="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li><a href="bbs.jsp">게시판</a></li>
                <li class="active"><a href="CalendarTable.jsp">달력</a></li>
                <li><a href="InsaTable.jsp">인사관리</a></li>
                <li><a href="RsTable.jsp">자료실</a></li>
                <li><a href="DsbTable.jsp">도서관리</a></li>
                  <ul class="nav navbar-nav navbar-right">
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
            </ul>

            <%
                if(userID == null)
                {
            %>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>                    
                    </ul>
                </li>
            </ul>
            <%
                } else {
            %>
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
            <%
                }
            %>
  
        </div>
    </nav>
    <h3 align="center"></h3>
    	<table id="calendar" border="3" align="center"
    		style="border-color:#3333FF ">
    		<tr><!-- label은 마우스로 클릭을 편하게 해줌 -->
    			<center>
    				<H2>일정 추가</H2>
    				<H2></H2>
    				<form name=memoAdd method=get action=CalendarAction.jsp>
<!--액션 태그 위치  -->
    					<input type=text name=memoYear size=4>
    					년
    					<input type=text name=memoMonth size=2>
    					월
    					<input type=text name=memoDay size=2>
    					일 내용 :
    					<input type=text name=memoContents>
    					<input type=submit value="추가">
    					<h2></h2>
    				</form>
                </tbody>
            </table>
             <h3 align="center"></h3>
            <table id="calendar" border="3" align="center" style="border-color:#3333FF ">
    			<center>
                      <p> 요기서부서 </p>
            </table>
            
            
            
</body>
</html>