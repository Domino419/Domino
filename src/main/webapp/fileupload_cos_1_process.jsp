<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 처리</title>
</head>
<body>
	<%
		MultipartRequest multi = new MultipartRequest(request,
													  "C:\\upload",  //업로드 될 경로를 지정
													  10000*10240*10240,//파일의 크기를 지정(100M)
													  "utf-8",       //인코딩 방식
													  //파일이름에 대한 정책(덮어쓰는 것이 아니라 동일한
													  //이름의 파일이라면 새로운 파일로 만들어준다.)
													  new DefaultFileRenamePolicy() 
													  );
	    Enumeration params = multi.getParameterNames();
		
	    while(params.hasMoreElements()){
	    	String name = (String)params.nextElement();
	    	String value = multi.getParameter(name);
	    	out.println(name + " = " + value + "<br/>");
	    }
	    
	    out.println("---------------------------------------------<br/>");
	    
	    Enumeration files = multi.getFileNames();
	    while(files.hasMoreElements()){
	    	String name = (String)files.nextElement();
	    	String filename = multi.getFilesystemName(name);  //파일 이름 얻기
	    	String original = multi.getOriginalFileName(name); //이전파일이름 얻기
	    	String type = multi.getContentType(name);
	    	File file = multi.getFile(name); //파일의 참조를 얻음
	    	
	    	out.println("요청들어온 파라메터 이름 : " + name + "<br/>");
	    	out.println("실제 파일 이름 : " + original + "<br/>");
	    	out.println("저장 파일 이름 : " + filename + "<br/>");
	    	out.println("파일 컨텐츠 유형 : " + type + "<br/>");
	    	
	    	if(file != null) {
	    		out.println("파일 크기 : " + file.length() + "<br/>");
	    		out.println("파일 경로 : " + file.getPath() + "<br/>");
	    
	    	}

	    }

	
	%>

</body>
</html>