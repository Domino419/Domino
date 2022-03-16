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

            <div align="center" >
          <button onclick="window.open('TodoWrite.jsp','Todo','width=430,height=500,location=no,status=no,scrollbars=yes');" class="btn btn-info btn-arrow-center">할일 추가</button> </div>
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
						<option ${(param.to == "todo")?  "selected" : ""} value="접수">접수</option>
						<option ${(param.to == "todo")?  "selected" : ""} value="완료">완료</option>
						<option ${(param.to == "todo")?  "selected" : ""} value="취소">취소</option>
						<option ${(param.to == "todo")?  "selected" : ""} value="불가">불가</option>
						<option ${(param.to == "todo")?  "selected" : ""} value="">전체</option>
					</select>
                        <input type = "submit"  value = "조회">  
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
                    for(int i = 0; i < list.size(); i++)
                    { 
                    %>
                
					
                    <tr>
                    	<td><%=list.get(i).getTodoid() %></td>
                        <td><%=list.get(i).getTodo() %></td>
                        <td><a href="TodoUpdate.jsp?todoID=<%=list.get(i).getTodoid()%>"><%=list.get(i).getTodotitle() %></a></td>
                        <td align = "left"><a href="TodoUpdate.jsp?todoID=<%=list.get(i).getTodoid()%>"><%=list.get(i).getTodocontent() %></a></td>
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
                <a href="Todo.jsp?to=<%=to_%>&pageNumber=<%=pageNumber - 1 %>" class="btn btn-success btn-arrow-left">이전</a>
            <%
                } 
               if (TodoDao.nextPage(to_, pageNumber + 1)) {
            %>
                <a href="Todo.jsp?to=<%=to_%>&pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arrow-left">다음</a>
            <%
                } %>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>