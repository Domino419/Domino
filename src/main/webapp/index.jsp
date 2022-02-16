<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<script language = "JavaScript1.2"> 
   var message = "Domino4019.com ..:'':..:'':..★!";
   var message = message+"          ";
   i = "0";
   var temptitle = "";
   var speed = "150";
   function titler()
   { 
    if (!document.all && !document.getElementById) 
      return; 
    document.title = temptitle + message.charAt(i);
    temptitle = temptitle + message.charAt(i);
    i++;
    if (i == message.length) 
    { 
      i = "0"; 
      temptitle = ""; 
    } 
    setTimeout("titler()",speed); 
   } 
   window.onload = titler; 
   </script>
<head>
<meta charset="UTF-8">
<title>Domino4019.com ..:'':..:'':..★ </title>
</head>
<body>
 <script>
   location.href = 'http://domino4019.com/main.jsp'; 
 </script>
</body>
</html>

<!-- 모든 웹 사이트의 기본이 되는 페이지  -->
