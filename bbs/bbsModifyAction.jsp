<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bbs.userDAO" %>
<%@page import="file.fileDAO" %>
<%@page import="java.io.*" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import = "config.configDirectory" %>    
<%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbsModifyAction.jsp</title>
</head>
<body>
	<%
	int bbsID = Integer.parseInt(request.getParameter("bbsID"));
	configDirectory fileDirectory = new configDirectory();
	String directory = fileDirectory.getUploadFileDirectory() + bbsID;
	int maxSize = 1024 * 1024 * 10;
	String encoding = "utf-8";

	File targetDir = new File(directory);
	if(!targetDir.exists()){
		targetDir.mkdirs();
	}// 경로가 존재하지 않을경우 경로를 추가 
	
	MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding,
			new DefaultFileRenamePolicy());

	String bbsTitle = multipartRequest.getParameter("bbsTitle");
	String bbsContents = multipartRequest.getParameter("bbsContents");

	userDAO userDAO = new userDAO();

	int k = userDAO.modifyBbs(bbsTitle, bbsContents, bbsID);

	if (k == 1) {
	%>
	<script>
		alert("Success");
		location.href = "bbsView.jsp?bbsID=<%=bbsID%>";
	</script>
	<%
	}else if(k == -1){
	%>
		<script>
			alert("DB error");
			location.href = "bbsView.jsp?bbsID=<%=bbsID%>";
		</script>
	<%
	}

String fileName = multipartRequest.getOriginalFileName("file");
String fileRealName = multipartRequest.getFilesystemName("file");
if(fileName != null ){	
new fileDAO().upload(fileName,fileRealName,bbsID);// 
}
%>
<h1>bbsModifyAction.jsp</h1>
	

</body>
</html>