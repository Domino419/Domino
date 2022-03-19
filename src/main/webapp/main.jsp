<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="/css/bootstrap.css"> <!-- 참조  -->
<title>My web site</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script> 
    $(document).ready(function(){
        /** 초기화 처리*/
        // 첫 번재 항목이 펼쳐져 있도록 처리
        $(".collapsible:eq(0) a").addClass("selected"); //첫번째 항목만 selected 클래스를 적용
        $(".collapsible").not(":eq(0)").find(".content").hide(); //첫번째 항목 이외의 content를 숨김
        /** 링크에 대한 클릭 이벤트 처리 */
        $(".collapsible .title a").click(function() {            
            $(this).toggleClass("selected");  //클릭된 나 자신을 제외한 나머리 링크들은 slected 클래스를 무조건 제거
            $(".collapsible .title a").not(this).removeClass("selected"); // 펼칠 내용 영역 선택
            var target = $(this).parents(".collapsible").find(".content"); // 나머지 내용 영역을 선택
            var other = $(".collapsible .title a").not(this)
                                                  .parents(".collapsible").find(".content"); // 애니메이션으로 열고 닫기 처리
            target.slideToggle(300);// other.slideUp(300); // 링크 페이지 이동 중지
            return false;
        });
    });
  </script>
</head>
<body>
	<jsp:include page="/header.jsp"></jsp:include>
	 <body>
	<ul>
		<li class="collapsible">
			<h2 class="title">
				<a href="#main">프로젝트 구성</a></h2>
			      ㅇ인사관리 - 실무에서 사용하는 엑셀 작업의 전산화 <br>
                  ㅇ게시판 - 작업시 발생한 에러 및 참고용 자료 기록 (=기술블로그 대용) <br>
                  ㅇ달력 & 자료실 & 도서관리 - 개인적인 활용 목적의 기능 구현  <br>
                  ㅇProject history - 프로젝트 진행시 이력 관리를 위한 to do list 및 작업일지 기록
		</li>
		<li class="collapsible">
			<h4 class="title">
				<a href="#detail1">▼ 회원로그인 ▼</a></h4>
		    	<p class="content">쿠키 : ID 저장기능</p>
		</li>
		<li class="collapsible">
			<h4 class="title">
			<a href="#detail2">▼ 게시판 ▼</a></h4>
			<p class="content">CRUD 기능, 페이징 및 검색 처리</p>
			<p class="content">글작성자 본인만 글수정/삭제가능</p>
			<p class="content">유효성 검사 : 제목 or 글내용 공백 입력불가</p>
		</li>
		<li class="collapsible">
			<h4 class="title">
				<a href="#detail3">▼ 달력 ▼</a></h4>
			<p class="content">달력 화면 & 일정추가 기능</p>
		<!-- 	<p class="content">쿠기 : ID 저장기능</p> -->
		</li>
		<li class="collapsible">
			<h4 class="title">
				<a href="#detail4">▼ 인사관리 ▼</a></h4>
			<p class="content">인사 관련 업무 처리를 위한 통게 및 엑셀다운로드 기능 구현</p>
			<p class="content">소속별 근무비중 확인, 사원명단 확인,고용전환 대상자 집계</p>
			<p class="content">엑셀 다운로드 기능 구현</p>
		</li>
		<li class="collapsible">
			<h4 class="title">
				<a href="#detail5">▼ 자료실 ▼</a></h4>
			<p class="content">자료 업로드/다운로드</p>
		</li>
		<li class="collapsible">
			<h4 class="title">
				<a href="#detail6">▼ 도서관리 ▼</a></h4>
			<p class="content">게시판 조회 기능 / 검색 기능 </p>
			<!-- <p class="content">대여 접수 / 반납 처리 기능 </p> -->
		</li>
		<li class="collapsible">
			<h4 class="title">
				<a href="#detail7">▼ Project History ▼</a></h4>
			<p class="content">CRUD 기능,페이징 및 검색 처리</p>
			<p class="content">작성자와 상관없이 글수정 가능하록 구현</p>
		</li>
		<li class="collapsible">
			<h4 class="title">
				<a href="tool">▼ 개발환경 ▼ </a></h4>
			<p class="content">DB : Oracle 11g XE</p>
			<p class="content">Server : Apache Tomcat 9.0</p>
			<p class="content">framework : Bootstrap </p>
			<p class="content">Tools : Oracle SQL Developer, SVN, Eclipse</p>
			<p class="content">Language : Java, JSP, JavaScript</p>
		</li>
		<li class="collapsible">
			<h4 class="title">
				<a href="tool">프로젝트 산출물</a></h4>
			<p class="content">DB설계</p>
			<p class="content">API설계</p>
		
		</li>
	</ul>


	<!-- <ul>
	<li><H4>개발환경 </H4></li>
	<li class="content">  DB : Oracle 11g XE </li>
	<li class="content">  Server : Apache Tomcat 9.0 </li>
	<li class="content">  framework : Bootstrap </li>
	<li><h3>개발도구 </h3></li>
	<li class="content"> Tools : Oracle SQL Developer, SVN, Eclipse </li>
	<li class="content"> Language : Java, JSP, JavaScript</li></ul>
 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
	
</body>
</html>