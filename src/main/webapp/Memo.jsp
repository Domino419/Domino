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
<jsp:include page="header.jsp"></jsp:include>
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