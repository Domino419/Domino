<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>    
<%@ page import="Todo.TodoDao" %>
<%@ page import="Todo.TodoDto" %>
<%@ page import="java.sql.*" %>  

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width">  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조  -->
<title>write.jsp</title>
</head>
<body>
<!-- 
<pre>
<script type="text/javascript">
var name = location.search;
var arr = name.split('&');
for(var i=0; i<arr.length; i++){
// 	alert(arr[i]+"\n");
	document.writeln(arr[i]);
}
</script>
</pre>
 -->

<% request.setCharacterEncoding("UTF-8"); %>    

<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
    	userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
    	PrintWriter script = response.getWriter();
    	script.println("<script>");
    	script.println("alert('로그인을 하세요')");
    	script.println("location.href = 'login.jsp'");
    	script.println("</script>");
    }
    %>
    <%
    
    int todoID = 0;
    if (request.getParameter("todoID") != null) {
    	todoID = Integer.parseInt(request.getParameter("todoID"));
    }
    if (todoID == 0) {
    	PrintWriter script = response.getWriter();
    	script.println("<script>");
    	script.println("alert('유효하지 않은 글입니다')");
    	script.println("location.href = 'Todo.jsp'");
    	script.println("</script>");
    }
    TodoDto tododto; 
    tododto = new TodoDao().gettodo(todoID);
    
    // DTo 클래스명 , 변수 = 생성자 
    //if (!userID.equals(Memo.getUserID())) {/*  작성자가 일치하지 않아도 상관없음, 로그인할 때 뭘로 로그인할지 몰라서..
    //	PrintWriter script = response.getWriter();
    //	script.println("<script>");
   // 	script.println("alert('권한이 없습니다')");
   // 	script.println("location.href = 'Memo.jsp'");
   // 	script.println("</script>");
    // */}
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
            <a class ="navbar-brand" href=Memo.jsp>MEMO</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <li class="active"><a href="bbs.jsp">게시판</a></li>
                <li><a href="CalendarTable.jsp">달력</a></li>
                <li><a href="InsaTable.jsp">인사관리</a></li>
                <li><a href="RsTable.jsp">성과관리</a></li>
                <li><a href="DsbTable.jsp">도서관리</a></li>
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
           <form method="post" action="TodoUpdateAction.jsp?=<%="TodoID"%>">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd"><thead><tr>
                        <th colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글수정 양식</th></tr>
                </thead>
                <tbody>
                                    <tr>
                   <td><input type="text" readonly  class="form-control" placeholder="아이디"  name="todoid" maxlength="50" value = "<%=tododto.getTodoid() %>"></td> 
                    </tr>
                    <tr>
                     <td>
                  <%--     <input type="text" class="form-control" placeholder="작업상태"  name="todos" maxlength="50" value = "<%=tododto.getTodo() %>"></td> --%>
                     	<div class="form-group" style="text-align: center;">
							<label class="btn btn-primary active"> 
							<input type="radio" name="todos" autocomplete="off" value = "가접수" checked>가접수 </label> 
							<label class="btn btn-primary">
							<input type="radio" name="todos" autocomplete="off" value = "접수" checked>접수 </label>
							<label class="btn btn-primary">
							<input type="radio" name="todos" autocomplete="off" value = "할당" checked>할당 </label>
							<label class="btn btn-primary">
							<input type="radio" name="todos" autocomplete="off" value = "완료" checked>완료 </label>
							<label class="btn btn-primary">
							<input type="radio" name="todos" autocomplete="off" value = "취소" checked>취소 </label>
							<label class="btn btn-primary">
							<input type="radio" name="todos" autocomplete="off" value = "불가" checked>불가 </label>
                    <tr>
                    <td><input type="text" class="form-control" placeholder="글 제목"  name="todotitle" maxlength="50" value = "<%=tododto.getTodotitle() %>"></td>
                    </tr>
                    <td><textarea class="form-control" placeholder="글 내용"  name="todocontent" maxlength="2048" style="height:350px;"><%=tododto.getTodocontent()%></textarea></td>
                    </tr>
					</tbody>
					  </table>
					  <div class="text-center">
					<input type="submit"   class="btn btn-primary pull" value="글수정" >    </div>
            </form>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>
