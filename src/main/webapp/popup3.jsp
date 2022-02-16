<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>파일 업로드용 </title>
</head>
<body>
	<form action="upload.do" method="post" enctype="multipart/form-data"> 업로드 : 
	<input type="text" name="name"><br> 파일명 : 
    <input  type="text" name="title"><br> 파일 지정하기  : 
    <input   type="file" name="uploadFile"><br> <input type="submit"  value="구현 전입니다">
	</form>
</body>
</html>