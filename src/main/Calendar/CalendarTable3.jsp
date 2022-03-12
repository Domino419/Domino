<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="Todo.TodoDao" %>
<%@ page import="Todo.TodoDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Tableocl.CalendarDao" %>
<%@ page import="Tableocl.Calendar" %>

<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" name="viewport" content="width=device-width" initial-scale="1"  >
<link rel="stylesheet" href="/css/bootstrap.css">
<title>My web site</title>
<style type = "text/css">
    a, a:hover
        color: #000000;
        text-decoration: none;
td {

	width: 50px;
	height: 50px;
	text-align: center;
	font-size: 20px;
	font-family: 굴림;
	border: 2px border-color:#3333FF;
	border : 8px; /*모서리 둥글게*/
}
</style>
</head>
<body>
<jsp:include page="/include/header.jsp"></jsp:include>

    <h3 align="center"></h3>
    	<table id="calendar" border="3" align="center"
    		style="border-color:#3333FF ">
    		<tr><!-- label은 마우스로 클릭을 편하게 해줌 -->
    			<center>
    				<H2>일정 추가</H2>
    				<H2></H2>
    				<form name=memoAdd method=get action=CalendarAction.jsp>
<!--액션 태그 위치  -->
    					<input type=text name=memoYear size=4>
    					년
    					<input type=text name=memoMonth size=2>
    					월
    					<input type=text name=memoDay size=2>
    					일 내용 :
    					<input type=text name=memoContents>
    					<input type=submit value="추가">
    					<h2></h2>
    				</form>
                </tbody>
            </table>
             <h3 align="center"></h3>
            <table id="calendar" border="3" align="center" style="border-color:#3333FF ">
    		<!-- 	<center> -->
                      <%@ include file="/Calendar/GoogleCalendar.html" %>
            </table>
            	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
                <script src="js/bootstrap.js"></script>
</body>
</html>