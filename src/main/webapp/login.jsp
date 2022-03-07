<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta charc=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>My web site</title>
</head>
<body>
	 <jsp:include page="header.jsp"></jsp:include>
	<div class = "container">
	    <div class = "col - lg - 4"> </div>
	    <div class = "col - lg - 4"> 
	         <div class = "jumbotron" style = "padding-top : 20px ;"></div>
	              <form method = "post" action ="loginAction.jsp"> 
	               <h3 style = "text-align : center;"> 로그인 화면 </h3>
	                 <div class = "form-group">
	                    <input type = "text" class = "form-control" placeholder = "아이디" name = "userID" maxlength = "20" >
	                    </div>
	                 <div class = "form-group">
	                    <input type = "text" class = "form-control" placeholder = "비밀번호" name = "userPassword" maxlength = "20" >
	                    </div>
	               <input type = "submit" class ="btn btn-primary form-control" value = "로그인">
	           </form> 
	       </div>   
	 </div>   
	  <div class = "col-lg-4"> 
	  </div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>