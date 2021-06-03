<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@page import ="bbs.userDAO,bbs.bbs" %>
<%@page import="file.fileDAO" %>
<%@page import="java.io.*" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import= "config.configDirectory" %>    
    

<%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bbsWriteAction.jsp</title>
</head>
<body>
<h1>bbsWriteAction.jsp</h1>


	<%
		bbs bbs = new bbs();
	
		System.out.println("==========bbsWriteAction.jsp==========");
		
		String sessionUserID = (String) session.getAttribute("userID");
		if (sessionUserID != null) {			
		bbs.setUserID(sessionUserID); // userID 받기		
			
		} else {
	%><script>
			alert("Log-in Please");
			location.href = 'login.jsp';
		</script>
	<%

	}
%><!-- 로그인 요청 -->


	<%
	userDAO userDAO = new userDAO();
	
	bbs.setBbsID(userDAO.getNext());// bbsID 생성	
	
	// bbsID 생성 -> bbsID 를 인자로 파일 업로드 !
	configDirectory fileDirectory = new configDirectory();
	String directory =fileDirectory.getUploadFileDirectory()+bbs.getBbsID();
	//bbsID 의 폴더 생성 및 파일 저장 위치 설정
	File targetDir = new File(directory);
	if(!targetDir.exists()){
		targetDir.mkdirs();
	}// 경로가 존재하지 않을경우 경로를 추가 
	
	int maxSize = 1024 * 1024 * 10;
	String encoding = "utf-8";

	MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding,
			new DefaultFileRenamePolicy());
//file upload MultipartRequest 호출
	
	Enumeration files = multipartRequest.getFileNames();
	while(files.hasMoreElements()){
		String parameter =(String)files.nextElement();
		String fileName = multipartRequest.getOriginalFileName(parameter);
		String fileRealName = multipartRequest.getFilesystemName(parameter);		
		
		if(fileRealName != null){	
		new fileDAO().upload(fileName,fileRealName,bbs.getBbsID());
		}
		if(files == null) continue;
	}

	%> <!--file table insert querry  -->

	<%
	String bbsTitle = multipartRequest.getParameter("bbsTitle");
	String bbsContents = multipartRequest.getParameter("bbsContents");
	bbs.setBbsTitle(bbsTitle);
	bbs.setBbsContents(bbsContents);

	if (bbs.getBbsTitle() == null) {
	%><script>
		alert("title is empty");
		location.href = "write.jsp";
	</script>
	<%
		}
	%><!-- title,Constents set / && title 유효성 검사 -->

	<%	
	System.out.println("bbs.getUSerID() : "+bbs.getUserID());
	System.out.println("bbs.getBbsTitle() : "+bbs.getBbsTitle());

	
	int k = userDAO.write(bbs.getBbsID(),bbs.getUserID(), bbs.getBbsTitle(), bbs.getBbsContents() , 0);
	System.out.println(k);		
	
	
	if(k == 1){
		%><script>
			location.href ="bbs.jsp";
		</script><%
	}else if (k == -1){
	%>
		<script>
			alert ("DB error");
			location.href ="write.jsp";
		</script>
	<%
	}
	%><!-- bbs table insert querry -->
	


</body>
</html>