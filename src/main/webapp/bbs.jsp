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
    
	String field_ = request.getParameter("f");
	String query_ = request.getParameter("q");
%>

    <!-- 게시판(게시글 목록) 영역 -->
    <div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                <thead>
                    <tr>
                        <th style="background-color:#eeeeee; text-align:center;">번호</th>
                        <th style="background-color:#eeeeee; text-align:center;">제목</th>
                        <th style="background-color:#eeeeee; text-align:center;">작성자</th>
                        <th style="background-color:#eeeeee; text-align:center;">작성일</th>
                    </tr>
                </thead>
                  <tbody>
                    <%
                    BbsDAO bbsDAO = new BbsDAO();
                    ArrayList<BBS> list = bbsDAO.getList1(field_,query_,pageNumber);
                    //ArrayList<BBS> list = bbsDAO.getList();
                    for(int i = 0; i < list.size(); i++)
                    { 
                    %>
                
                    <tr>
                        <td><%=list.get(i).getBbsid() %></td>
                        <td><a href="view.jsp?Bbsid=<%=list.get(i).getBbsid()%>"><%=list.get(i).getBbstitle() %></a></td>
                        <td><%=list.get(i).getUserID() %></td>
                        <td><%=list.get(i).getBbsdate() %></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
        <div class="container">
					<div class="row">
							<div class="alert alert-info">
							<script>
								const str = document.location.href;
								const words = str.split("/");
								words[2] = 'localhost:7877' ? document.write("개발계") : document.write("운영계");
							</script>
							<strong>
							 </strong></div>
			<form>
				<fieldset>
                 <!--    <legend>글 검색 필드</legend>      -->               
                    <label>검색분류</label>
                        <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example"  name = "f" >
                            <option ${(param.f == "bbstitle")? "selected" : ""} value = "bbstitle">제목</option>  
                            <option ${(param.f == "userid")? "selected" : ""} value = "userid)">작성자</option>
                        </select>
                    <label>검색어</label>
                        <input type = "text" name = "q"  value = "${param.q}"/>
                        <input type = "submit"  value = "검색">                
                </fieldset>        
			</form>	
		</div>	
			  	<div class="container">
							<table class="pull-right">
									<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
								</tr>
							</table>

							<%
                if(pageNumber != 1) {
            %>
							<a href="bbs.jsp?pageNumber=<%=pageNumber - 1 %>"
								class="btn btn-success btn-arrow-left">이전</a>
							<%
                } 
               if (bbsDAO.nextPage(pageNumber + 1)) {
            %>
							<a href="bbs.jsp?pageNumber=<%=pageNumber + 1 %>"
								class="btn btn-success btn-arrow-left">다음</a>
							<%
                } %>

						<!-- 	<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a> -->

							<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
							<script src="js/bootstrap.js"></script></body>
</html>