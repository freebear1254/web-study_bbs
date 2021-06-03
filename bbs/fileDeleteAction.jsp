<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="config.configDirectory"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fileDeleteAction.jsp</title>
</head>
<body>
<%
	String bbsID = request.getParameter("bbsID");
	configDirectory fileDirectory = new configDirectory();
	String directory = fileDirectory.getUploadFileDirectory();
	String fileName = request.getParameter("fileRealName");
	
	File file = new File(directory+bbsID+"\\"+fileName);
	file.delete();
	
	%>
	<script>
		alert("Success");
		location.href = "bbsModify.jsp?bbsID=<%=bbsID%>";
	</script>
	<%
%>
</body>
</html>