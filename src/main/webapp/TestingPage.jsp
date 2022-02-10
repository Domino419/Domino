<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="BBS.MemoDao" %>
<%@ page import="BBS.Memo" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<meta name="viewport" content="width=device-width" initial-scale="1" > 
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
<style type = "text/css">
    a, a:hover
    {
        color: #000000;
        text-decoration: none;
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
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">   <!-- nav bat menu list  -->
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li><a href="bbs.jsp">게시판</a></li>
                <li><a href="CalendarTable.jsp">달력</a></li>   <!-- 0122 메뉴 추가 -->
                <li><a href="InsaTable.jsp">인사관리</a></li>
                <li><a href="RsTable.jsp">성과관리</a></li>
                <li><a href="DsbTable.jsp">자재관리</a></li>
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
    <div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                <thead>
                    <tr>
                    
                    	<th style="background-color:#eeeeee; text-align:center;">일자</th>
                        <th style="background-color:#eeeeee; text-align:center;">작업</th>
                        <th style="background-color:#eeeeee; text-align:center;">세부내용</th>
                        
                      
                    </tr>
                </thead>
                <tbody>  
                    <!-- 게시판 루트 바꿀 부분  -->
                    <%
                    MemoDao MemoDao = new MemoDao();
                    ArrayList<Memo> list = MemoDao.getList(pageNumber);
                    //ArrayList<BBS> list = bbsDAO.getList();
                    for(int i = 0; i < list.size(); i++)
                    { 
                    %>
                
                                        <tr>
                        <td><%=list.get(i).getData() %></td>                    
                        <td><a href="MemoUpdate.jsp?memoid=<%=list.get(i).getMemoid()%>"><%=list.get(i).getWorkcoment() %></a></td>                     
                        <td><a href="MemoUpdate.jsp?memoid=<%=list.get(i).getMemoid()%>"><%=list.get(i).getComent() %> <width='200' style='word-break:break-all'> </a></td> 
                               
                <%
                    }
                %>
                </tbody>
            </table>
            <%
                if(pageNumber != 1) {
            %>
                <a href="Memo.jsp?pageNumber=<%=pageNumber - 1 %>" class="btn btn-success btn-arrow-left">이전</a>
            <%
                } 
               if (MemoDao.nextPage(pageNumber+ 1)) {
            %>
                <a href="Memo.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arrow-left">다음</a>
            <%
                } %>
           <a href="MemoWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>