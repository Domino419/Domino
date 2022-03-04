<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Todo.TodoDao" %>
<%@ page import="Todo.TodoDto" %>
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
<% request.setCharacterEncoding("UTF-8"); %>    
<%
    String userID = null; 
    if (session.getAttribute("userID") != null)
    {userID = (String)session.getAttribute("userID");}
    
    
    int pageNumber = 1;  
    if (request.getParameter("pageNumber") != null)
    {
        pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    }
    
    
	String to_ = request.getParameter("to");
	if(to_ == null)
		to_ = "";     //파라미터 캐치하는 부분 
%>
<!-- <script type="text/javascript">
function button_event(){
if (confirm("정말 삭제하시겠습니까??") == true){    //확인
    document.form.submit();
}else{   //취소
    return;
}
}
</script> -->
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
                <li class="active"><a href="bbs.jsp">게시판</a></li>
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
            <div align="center" >
           <!--    <div class="btn-group"></div> --> 
          <button onclick="window.open('TodoWrite.jsp','Todo','width=430,height=500,location=no,status=no,scrollbars=yes');" class="btn btn-info btn-arrow-center">할일 추가</button> </div>
       <!--    <button onclick="window.open('popup1.jsp','칸반보드');" class="btn btn-success btn-arrow-center">칸반보드 (To do list 연동 전 탬플릿만)</button> </div> --> 
         <div>
         </div>
         <div class="container">
					<div class="row">
						<!-- 	<div class="alert alert-info">
					         <strong>운영.개발 구분용 line </strong></div> -->
			<form>
				<fieldset>
                 <!--    <legend>글 검색 필드</legend>      -->               
                   <label>진행상태</label>
                        <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example"  name = "to" >
						<option ${(param.to == "todo")?  "selected" : ""} value=""><%=to_ %></option>
						<option ${(param.to == "todo")?  "selected" : ""} value="할당">할당</option>
						<!-- <option ${(param.to == "todo")? "selected" : ""} value="가접수">가접수</option> -->
						<option ${(param.to == "todo")?  "selected" : ""} value="접수">접수</option>
						<option ${(param.to == "todo")?  "selected" : ""} value="완료">완료</option>
						<option ${(param.to == "todo")?  "selected" : ""} value="취소">취소</option>
						<option ${(param.to == "todo")?  "selected" : ""} value="불가">불가</option>
						<option ${(param.to == "todo")?  "selected" : ""} value="">전체</option>
					</select>
                  <!--  <label>검색어</label> -->  
                   <!--    <input type = "text" name = "state"  value = "${param.to}"/>-->   
                        <input type = "submit"  value = "조회">   <!-- 드롭다운 메뉴에서 선택 후 sumit -->
                </fieldset>        
			</form>	
		</div>	
	<div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                <thead>
                    <tr>
                    	<th style="background-color:#eeeeee; text-align:center;">번호</th>
                        <th style="background-color:#eeeeee; text-align:center;">진행상태</th>
                        <th style="background-color:#eeeeee; text-align:center;">접수구분</th>
                        <th style="background-color:#eeeeee; text-align:center;">내용</th>
                        <th style="background-color:#eeeeee; text-align:center;">접수일</th>
                        <th style="background-color:#eeeeee; text-align:center;">삭제</th>
                    </tr>
                </thead>
                <tbody>
                
                    <%
                    TodoDao TodoDao = new TodoDao();
                    ArrayList<TodoDto> list = TodoDao.getList(to_, pageNumber);
                    //ArrayList<BBS> list = bbsDAO.getList();
                    for(int i = 0; i < list.size(); i++)
                    { 
                    %>
                
					
                    <tr>
                    	<td><%=list.get(i).getTodoid() %></td>
                        <td><%=list.get(i).getTodo() %></td>
                        <td><a href="TodoUpdate.jsp?todoID=<%=list.get(i).getTodoid()%>"><%=list.get(i).getTodotitle() %></a></td>
                        <td><a href="TodoUpdate.jsp?todoID=<%=list.get(i).getTodoid()%>"><%=list.get(i).getTodocontent() %></a></td>
                        <td><a href="TodoUpdate.jsp?todoID=<%=list.get(i).getTodoid()%>"><%=list.get(i).getTododata() %></a></td>
                        <td><a href="TododeleteAction.jsp?todoID=<%=list.get(i).getTodoid()%>" onclick="return confirm('진짜 삭제해도 될까요?');">삭제</a>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
			
			<%
                if(pageNumber != 1) {
            %>
                <a href="Todo.jsp?pageNumber=<%=pageNumber - 1 %>" class="btn btn-success btn-arrow-left">이전</a>
            <%
                } 
               if (TodoDao.nextPage(pageNumber + 1)) {
            %>
                <a href="Todo.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arrow-left">다음</a>
            <%
                } %>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>