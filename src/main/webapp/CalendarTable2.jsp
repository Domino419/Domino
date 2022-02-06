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
                <li><a href="Memo.jsp">MEMO</a></li>
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
    <!DOCTYPE html>
<html>
<head>
<title>달력</title>
<style type="text/css">
td {
	width: 50px;
	height: 50px;
	text-align: center;
	font-size: 20px;
	font-family: 굴림;
	border: 2px border-color:#3333FF;
	border-radius: 8px; /*모서리 둥글게*/
}
</style>
<script type="text/javascript">
        var today = new Date();
	var date = new Date();
	function prevCalendar() {
		today = new Date(today.getFullYear(), today.getMonth() - 1, today
				.getDate());
		buildCalendar(); 
	}

	function nextCalendar() {
		today = new Date(today.getFullYear(), today.getMonth() + 1, today
				.getDate());
		buildCalendar();//
	}
	function buildCalendar() {
		var doMonth = new Date(today.getFullYear(), today.getMonth(), 1);
		
		var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);
		
		var tbCalendar = document.getElementById("calendar");
		
		var tbCalendarYM = document.getElementById("tbCalendarYM");
		
		tbCalendarYM.innerHTML = today.getFullYear() + "년 "
				+ (today.getMonth() + 1) + "월";

		/*while은 이번달이 끝나면 다음달로 넘겨주는 역할*/
		while (tbCalendar.rows.length > 2) {
			
			tbCalendar.deleteRow(tbCalendar.rows.length - 1);
			
		}
		var row = null;
		row = tbCalendar.insertRow();
		
		var cnt = 0;// count, 셀의 갯수를 세어서 1일 시작되는 칸 맞춰줌 
		for (i = 0; i < doMonth.getDay(); i++) {   /*이번달의 day만큼*/
			
			cell = row.insertCell();
			cnt = cnt + 1;
		}
		/*달력 출력*/
		for (i = 1; i <= lastDate.getDate(); i++) {    //1일부터 마지막 일까지 돌림
			cell = row.insertCell();
			cell.innerHTML = i;//셀을 1부터 마지막 day까지 HTML 문법에 넣어줌
			cnt = cnt + 1;
			if (cnt % 7 == 1) {/*일요일 계산*/
				//1주일이 7일 이므로 일요일 구하기
				//월화수목금토일을 7로 나눴을때 나머지가 1이면 cnt가 1번째에 위치함을 의미한다
				cell.innerHTML = "<font color=#F79DC2>" + i
				//1번째의 cell에만 색칠
			}
			if (cnt % 7 == 0) {/* 1주일이 7일 이므로 토요일 구하기*/
				//월화수목금토일을 7로 나눴을때 나머지가 0이면 cnt가 7번째에 위치함을 의미한다
				cell.innerHTML = "<font color=skyblue>" + i
				//7번째의 cell에만 색칠
				row = calendar.insertRow();
				//토요일 다음에 올 셀을 추가
			}
			/*오늘의 날짜에 노란색 칠하기*/
			if (today.getFullYear() == date.getFullYear()
					&& today.getMonth() == date.getMonth()
					&& i == date.getDate()) {
				//달력에 있는 년,달과 내 컴퓨터의 로컬 년,달이 같고, 일이 오늘의 일과 같으면
				cell.bgColor = "#FAF58C";//셀의 배경색을 노랑으로 
			}
		}
	}
	
</script>
</head>
<head>
    <title>달력</title>
    <style type="text/css">
        td{
            width: 50px;
            height: 50px;
            text-align: center;
            font-size: 20px;
            font-family: 굴림;
            border:2px border-color:#3333FF;
            border-radius: 8px;/*모서리 둥글게*/
        }
    </style>
<script type="text/javascript">
        var today = new Date();
        var date = new Date();
        function prevCalendar() {
         today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
         buildCalendar(); //달력 cell 만들어 출력 
        }
 
        function nextCalendar() {/
             today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
             buildCalendar();//달력 cell 만들어 출력
        }
        function buildCalendar(){//현재 달 달력 만들기
            var doMonth = new Date(today.getFullYear(),today.getMonth(),1);
          
            var lastDate = new Date(today.getFullYear(),today.getMonth()+1,0);
            
            var tbCalendar = document.getElementById("calendar");
            
            var tbCalendarYM = document.getElementById("tbCalendarYM");
         
             tbCalendarYM.innerHTML = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월"; 
 
             /*while은 이번달이 끝나면 다음달로 넘겨주는 역할*/
            while (tbCalendar.rows.length > 2) {
           
                  tbCalendar.deleteRow(tbCalendar.rows.length-1);
                
             }
             var row = null;
             row = tbCalendar.insertRow();
             //테이블에 새로운 열 삽입//즉, 초기화
             var cnt = 0;// count, 셀의 갯수를 세어주는 역할
           
             for (i=0; i<doMonth.getDay(); i++) {
            
                  cell = row.insertCell();
                  cnt = cnt + 1;
             }
            /*달력 출력*/
             for (i=1; i<=lastDate.getDate(); i++) { 
            
                  cell = row.insertCell();
                  cell.innerHTML = i;//셀을 1부터 마지막 day까지 HTML 문법에 넣어줌
                  cnt = cnt + 1;
              if (cnt % 7 == 1) 
                cell.innerHTML = "<font color=#F79DC2>" + i
                
            }    
              if (cnt%7 == 0){
                  cell.innerHTML = "<font color=skyblue>" + i
                  //7번째의 cell에만 색칠
                   row = calendar.insertRow();
                   //토요일 다음에 올 셀을 추가
              }
              /*오늘의 날짜에 노란색 칠하기*/
              if (today.getFullYear() == date.getFullYear()
                 && today.getMonth() == date.getMonth()
                 && i == date.getDate()) {
                 cell.bgColor = "#FAF58C";//셀의 배경색을 노랑으로 
               }
             }
        }
    </script>
</head>
<body>
    <p></p>
    <h3 align="center"></h3>
<table id="calendar" border="3" align="center" style="border-color:#3333FF ">
    <tr><!-- label은 마우스로 클릭을 편하게 해줌 -->
    <center>
     <H2>일정 추가</H2>
     <H2>  </H2>
   <form name=memoAdd method=get action=CalendarAction.jsp>        <!--액샨 태그 위치  --> 
   <input type=text name=memoYear size=4>년
   <input type=text name=memoMonth size=2>월
   <input type=text name=memoDay size=2>일
   내용 : <input type=text name=memoContents>
   <input type=submit value="추가">
   <h2>  </h2>
  </form>
  
        <td><label onclick="prevCalendar()"><</label></td>
        <td align="center" id="tbCalendarYM" colspan="5"> yyyy년 m월</td>

        <td><label onclick="nextCalendar()">>
            
        </label></td>
    </tr>
    <tr>
        <td align="center"><font color ="#F79DC2">일</td>
        <td align="center">월</td>
        <td align="center">화</td>
        <td align="center">수</td>
        <td align="center">목</td>
        <td align="center">금</td>
        <td align="center"><font color ="skyblue">토</td>
    </tr> 
    
       
    

</table>
<script language="javascript" type="text/javascript">
          buildCalendar();  
</script>
</body>
</html>
