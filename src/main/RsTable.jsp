<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="BBS.BbsDAO" %>
<%@ page import="BBS.BBS" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1" > 
<link rel="stylesheet" href="css/bootstrap.css">
<title>My web site</title>
<style type = "text/css">
    a, a:hover
    {
        color: #000000;
        text-decoration: none;
    }
</style>
</head>
<body>
 <jsp:include page="/header.jsp"></jsp:include>
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
            <table class="table table-striped" style="; border:3px solid #dddddd">
                <thead>
                    <tr>
                      <th>   <a href="http://localhost:81/upload"  class="btn btn-success">자료실 입장</a></th>
                      <th>   <a href="fileupload_cos_1.jsp"  class="btn btn-primary pull-right">파일 한개씩 업로드</a></th>
                      <th>   <a href="fileupload_cos_2.jsp"  class="btn btn-primary pull-right">파일 3개씩 업로드</a></th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>