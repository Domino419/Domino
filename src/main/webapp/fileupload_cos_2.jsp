<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 다중 업로드(cos.jar이용)</title>
</head>
<body>
	<!-- enctype속성 : 전송타입을 설정, 파일을 전송을 하기 위해서는 반드시 multipart/form-data로 지정을 해야한다. -->
	<form name="fileForm" action="fileupload_cos_2_process.jsp" method="post" 
		  enctype="multipart/form-data">
		<p><b>이 름1 : </b> <input type="text" name="name1" />	
		   <b>제 목1 : </b> <input type="text" name="title1" />
		   <b>파 일1 : </b> <input type="file" name="filename1" />
		
		<p><b>이 름2 : </b> <input type="text" name="name2" />	
		   <b>제 목2 : </b> <input type="text" name="title2" />
		   <b>파 일2 : </b> <input type="file" name="filename2" />
		  
		<p><b>이 름3 : </b> <input type="text" name="name3" />	
		   <b>제 목3 : </b> <input type="text" name="title3" />
		   <b>파 일3 : </b> <input type="file" name="filename3" />
		
		<p><input type="submit" value="파일 업로드" />	
	</form>
</body>
</html>
