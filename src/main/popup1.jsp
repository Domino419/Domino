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
	<jsp:include page="/header.jsp"></jsp:include>
    <!-- 쿠키값으로 id정보 받아오기 -->
	<%String cookie = "";
		Cookie[] cookies = request.getCookies(); //쿠키생성
		if(cookies !=null&& cookies.length > 0)
		for (int i = 0; i < cookies.length; i++){
			if (cookies[i].getName().equals("userID")) { // 내가 원하는 쿠키명 찾아서 값 저장
				cookie = cookies[i].getValue();}}%>
				
	<div class = "container">
	    <div class = "col - lg - 4"> </div>
	    
	         <div class = "jumbotron" style = "padding-top : 20px ;"></div>
	              <form method = "post" action ="loginAction.jsp"> 
	               <h3 style = "text-align : center;"> 로그인 화면 </h3>
	                 <div class = "form-group">
	                    <input type = "text" class = "form-control" placeholder = "아이디" name = "userID" maxlength = "20" >
	                    </div>
	                 <div class = "form-group">
	                    <input type = "text" class = "form-control" placeholder = "비밀번호" name = "userPassword" maxlength = "20" >
	                    </div>
	                     <input name="checkbox" type=checkbox name = "cookiremember" value="<%=cookie%>" > id 기억하기 <br> 
	                    <input type = "submit" class ="btn btn-primary form-control" value = "로그인">
	        
				</form>
			</body>
		
	  <div class = "col-lg-4"> 
	  </div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>