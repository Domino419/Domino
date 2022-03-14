<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	Cookie cookie=new Cookie("cookieanser",request.getParameter("cookieanser")); 
	cookie.setMaxAge(60*60*24);
	response.addCookie(cookie);
%>
<script>
location.href="/login.jsp"
</script>
