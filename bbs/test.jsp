<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import ="java.io.BufferedReader,java.io.FileReader" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		out.print("Hello World");
	
		String path = request.getServletContext().getRealPath("\\");
		
		out.print(path);
		
		String filePath = "/freebear1254/tomcat/webapps/file/";
		BufferedReader in =new BufferedReader(new FileReader(filePath +"fileUpload.txt"));
		
		
		String testText = in.readLine();
		in.close();
		
	%>

	 
</body>
</html>