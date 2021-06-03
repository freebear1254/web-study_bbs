<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import = "config.configDirectory" %>    
<%request.setCharacterEncoding("utf-8"); %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fileDownload.jsp</title>
</head>
<body>
<h1>fileDownload.jsp</h1>
<%
	int bbsID = Integer.parseInt(request.getParameter("bbsID"));	
	String fileRealName = request.getParameter("fileRealName") ;
	configDirectory fileDirectory = new configDirectory();
	String directory =fileDirectory.getUploadFileDirectory()+bbsID+"\\"+fileRealName;
	

	File file = new File(directory);
	byte[] temp = new byte[1024];
	
	FileInputStream fileInputStream = new FileInputStream(file);
	
	String mimeType = getServletContext().getMimeType(directory);
	if(mimeType == null) {
		response.setContentType("application/octet-stream ");//없으면 application/octet-stream (이진타입 기본값) 으로지정
	}
	ServletOutputStream servletOutputStream = response.getOutputStream();
	
	String header = request.getHeader("User-Agent");
	String encoding;
	if(header.contains("Chrome")){
		encoding =new String(fileRealName.getBytes("UTF-8"), "ISO-8859-1");
		response.setHeader("Content-Disposition","attachment;filename="+encoding);
	}else if (header.contains("Edge")){
		 encoding = URLEncoder.encode(fileRealName, "UTF-8").replaceAll("\\+", "%20");
		 response.setHeader("Content-Disposition", "attachment;filename=\"" + encoding);
	}else if(header.contains("MSIE") || header.contains("Trident")){
		 encoding = URLEncoder.encode(fileRealName, "UTF-8").replaceAll("\\+", "%20");
		 response.setHeader("Content-Disposition", "attachment;filename=" +encoding); 
	}else if (header.contains("Opera")) {
		    encoding = new String(fileRealName.getBytes("UTF-8"), "ISO-8859-1");
		    response.setHeader("Content-Disposition", "attachment; filename=\"" +encoding);
	 }else if (header.contains("Firefox")) {
		    encoding = new String(fileRealName.getBytes("UTF-8"), "ISO-8859-1");
		    response.setHeader("Content-Disposition", "attachment; filename=" + encoding);
	}
		
	int data = 0;
	
	while ((data = fileInputStream.read(temp,0,temp.length))!=-1) {
		servletOutputStream.write(temp,0,data);
	}
	servletOutputStream.flush();
	servletOutputStream.close();
	fileInputStream.close();
%>

<%

%>
</body>
</html>