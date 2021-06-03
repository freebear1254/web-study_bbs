<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bbs.userDAO"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>joinAction.jsp</title>
</head>
<body>
	<jsp:useBean id="user" class="bbs.user" />
	<jsp:setProperty property="*" name="user" />
	<h1>joinAction.jsp</h1>
	
	<%
	System.out.println("==============joinAction.jsp=================");
	String addr1 = request.getParameter("addr1");
	String addr2 = request.getParameter("addr2");
	String addr3 = request.getParameter("addr3");
	user.setUserAddr(addr1 + " " + addr2 + " " + addr3);
	System.out.println("userID: "+user.getUserID());
	System.out.println("userPassword : "+user.getUserPassword());
	System.out.println("userName : "+user.getUserName());
	System.out.println("userEmail : "+user.getUserEmail());
	System.out.println("userZipcode : "+user.getZipcode());
	System.out.println("userAddr : "+user.getUserAddr());


	userDAO userDAO = new userDAO();
	
	
	int k = userDAO.join(user.getUserID(),user.getUserPassword(),user.getUserName(),user.getUserEmail(),user.getUserAddr(),user.getZipcode());
	if(k == 1){
		%>
			<script >
				alert("success please login");
				location.href="login.jsp";
			</script>
		<%
	}else if(k == -1){
		%>
			<script >
				alert("sorry We have problems - retry join us");
				location.href="join.jsp";
			</script>
		<%
	}


	%>

</body>
</html>