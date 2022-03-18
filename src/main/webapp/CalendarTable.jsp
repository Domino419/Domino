<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Calendar" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="Tableocl.CalendarDao" %>

<%
	Calendar cal = Calendar.getInstance();
	int year = request.getParameter("year") == null ? cal.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("year")); 
	int month = request.getParameter("month") == null ? cal.get(Calendar.MONTH) + 1 : Integer.parseInt(request.getParameter("month"));
	cal.set(year, month - 1, 1); 
	int week = cal.get(Calendar.DAY_OF_WEEK);
	int first_day = cal.get(Calendar.DAY_OF_MONTH);
	int last_day = cal.getActualMaximum(Calendar.DATE);
	int count = 0;
	int i = 0;
%> 



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
<jsp:include page="/header.jsp"></jsp:include>

    
    <form name="calform" method="post">
	<input type="hidden" name="year" value="<%=year %>" />
	<input type="hidden" name="month" value="<%=month %>" />
	
	 <!-- 달력 앞뒤로 넘기기 위한 폼 설정 -->
		<div class="container">
			<div class="row">
			    <div class="col" align="center"><H3><%=year%>년 <%=month %>월 </H3>
			    </div>
				<div class="container">
					<div class="row">
						<input type="button" value="지난달" class="btn btn-primary pull-left" onclick="prevMonth()">
					   <input type="button" value="다음달" class="btn btn-primary pull-right" onclick="nextMonth()" />
					</div>
				</div>

				<script>
			function nextMonth() {
				var calform = document.calform;
				var year = Number(calform.year.value);
				var month = Number(calform.month.value);
				if (month == 12) {
					calform.year.value = year + 1;
					calform.month.value = 1;
				} else {
					calform.month.value = month + 1;
				}
				calform.submit();
			}

			function prevMonth() {
				var calform = document.calform;
				var year = Number(calform.year.value);
				var month = Number(calform.month.value);
				if (month == 1) {
					calform.year.value = year - 1;
					calform.month.value = 12;
				} else {
					calform.month.value = month - 1;
				}
				calform.submit();
			}
		</script>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
			     	<div style="width: 30%; float:none; margin:0 auto" >
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">일</th> 
						<th style="background-color: #eeeeee; text-align: center;">월</th> 
						<th style="background-color: #eeeeee; text-align: center;">화</th> 
						<th style="background-color: #eeeeee; text-align: center;">수</th> 
						<th style="background-color: #eeeeee; text-align: center;">목</th> 
						<th style="background-color: #eeeeee; text-align: center;">금</th> 
						<th style="background-color: #eeeeee; text-align: center;">토</th> 
					</tr>
				</thead>
				
				
<%
	while(first_day<=last_day) {
		++i;
		if(first_day>last_day) {
			break;
		}
		if(count%7==0) {
%>
		<tr></tr>
<%
			System.out.println();
			count=0; 
		}	
		if(i>=week) { 
%>
			<td><%=first_day%></td> 
<%
 			System.out.print(first_day+"\t"); 
			++first_day; 
		} else { 
%>
			<td> </td> 
<% 
			System.out.print(" \t"); 
		} 
		++count;
		}
%> 
		<tr></tr> 
	</table>
</form>
<h3 align="center"></h3>
    	<table id="calendar" border="3" align="center"
    		style="border-color:#3333FF ">
    		<tr><!-- label은 마우스로 클릭을 편하게 해줌 -->
    			<center>
    				<form name=memoAdd method=get action=CalendarAction.jsp>
<!--액션 태그 위치  -->
    					<input type=text name=memoYear size=4>년
    					<input type=text name=memoMonth size=2>월
    					<input type=text name=memoDay size=2>일 내용 :
    					<input type=text name=memoContents>
    					<input type=submit value="일정추가">
    					<h2></h2>
    				</form>
                </tbody>
            </table>
            	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
                <script src="js/bootstrap.js"></script>
</body>
</html>