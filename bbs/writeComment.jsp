<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bbs.userDAO" %>    
    
<%request.setCharacterEncoding("utf-8"); %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>writeComment.jsp</title>
</head>
<body>
<jsp:useBean id="bbs" class ="bbs.bbs" scope="page"/>
<jsp:setProperty property="*" name="bbs"/>
<h1>writeComment.jsp</h1>
<%
		System.out.println("==========writeCommentAction.jsp==========");
		String sessionUserID = (String) session.getAttribute("userID");
		if (sessionUserID != null) {
			
			bbs.setUserID(sessionUserID);
			
		} else {
	%><script>
			alert("Log-in Please");
			location.href = 'login.jsp';
		</script>
	<%
	}
%><!-- 로그인 요청 -->
<% 
	
	if(bbs.getBbsTitle()==null){
		%><script>
			alert ("title is empty");
			location.href = "bbsView.jsp?bbsID=<%=bbs.getParentBbsID()%>";
		</script><%
	}
%><!-- title is Not Null -->
<% 
	if(bbs.getBbsContents()==null){
		%><script>
			alert ("Contents is empty");
			location.href = "bbsView.jsp?bbsID=<%=bbs.getParentBbsID()%>";
		</script><%
	}
%><!-- Contents is Not Null -->

<%
	userDAO userDAO = new userDAO();
	bbs.setBbsID(userDAO.getNext());
	System.out.println("bbs.getUSerID() : "+bbs.getUserID());
	System.out.println("bbs.getBbsTitle() : "+bbs.getBbsTitle());

	int k = userDAO.write(bbs.getBbsID(),bbs.getUserID(), bbs.getBbsTitle(), bbs.getBbsContents() , bbs.getParentBbsID());
	System.out.println(k);
	if(k == 1){
		%><script>
		location.href = document.referrer; 
		</script><%
	}
	%>
		<script>
			alert ("DB error");
			location.href = document.referrer; ;
		</script>
		
	<%
%>


</body>
</html>