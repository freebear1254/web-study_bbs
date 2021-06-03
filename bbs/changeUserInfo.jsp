<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="bbs.userDAO" %>
    <% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>changeUserInfo.jsp</title>
</head>
<body>
	<jsp:useBean id="user" class="bbs.user" />
	<jsp:setProperty property="*" name="user" />

	<h1>changeUserInfo.jsp</h1>
	
	<%
	String userID = null;
	if(session.getAttribute("userID") !=null ){
		userID = (String)session.getAttribute("userID");
	}else{
		%>
		<script>
			alert("Log-in please");
			location.href ="login.jsp";
		</script>
		<%
	}

	
	
	System.out.println("==============changeUserInfo.jsp=================");
	String addr1 = request.getParameter("addr1");
	String addr2 = request.getParameter("addr2");
	String addr3 = request.getParameter("addr3");
	user.setUserAddr(addr1 + " " + addr2 + " " + addr3);//set userAddr
	
	System.out.println("userID: "+user.getUserID());
	System.out.println("userPassword : "+user.getUserPassword());
	System.out.println("userName : "+user.getUserName());
	System.out.println("userEmail : "+user.getUserEmail());
	System.out.println("userZipcode : "+user.getZipcode());
	System.out.println("userAddr : "+user.getUserAddr());


	userDAO userDAO = new userDAO();
	int k =userDAO.changeUserInfo(user.getUserID(),user.getUserPassword(),user.getUserName(),user.getUserEmail(),user.getUserAddr(),user.getZipcode());
	
	if(k == 1){
		%>
		<script >
			alert("change success!!  please re-Login!");			
			location.href = "logout.jsp";
		</script>
		<%
	}
	
	
	%>
</body>
</html>