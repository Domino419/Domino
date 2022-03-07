<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   

<!DOCTYPE html>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charc=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>My web site</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
		<div class = "container">
	    <div class = "col - lg - 4"> </div>
	    <div class = "col - lg - 4"> 
	         <div class = "jumbotron" style = "padding-top : 20px;">
	             
	              <form method = "post" action ="joinAction.jsp"> <!-- post 사용해서 Joinaction으로   -->
	               <h3 style = "text-align : center;"> 회원가입 화면 </h3>
	                 <div class = "form-group">
	                    <input type = "text" class = "form-control" placeholder = "아이디" name = "userID" maxlength = "20" >
	                    </div>
	                 <div class = "form-group">
	                    <input type = "text" class = "form-control" placeholder = "비밀번호" name = "userPassword" maxlength = "20" >
	                    </div> 
	                    <div class = "form-group">  
	                    <input type = "text" class = "form-control" placeholder = "이름" name = "userName" maxlength = "20" >
	                    </div>
					<div class="form-group" style="text-align: center;">
						<label class="btn btn-primary active">
							<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
						</label>
						<label class="btn btn-primary">
							<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
						</label>
					</div>
	                   <!--  <input type = "text" class = "form-control" placeholder = "성별" name = "userGender" maxlength = "20" >
	                    </div>	   -->                  
	                    <input type = "email" class = "form-control" placeholder = "이메일" name = "userEmail" maxlength = "20" >
	                    </div>  
	                     
	               <input type = "submit" class ="btn btn-primary form-control" value = "회원가입">
	        
	    	</div>
	  <div class = "col-lg-4"> 
	  </div>>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>